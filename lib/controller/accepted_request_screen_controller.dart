import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'dart:ui';

import 'package:car2gouser/controller/socket_controller.dart';
import 'package:car2gouser/models/api_responses/google_map_poly_lines_response.dart';
import 'package:car2gouser/models/api_responses/live_location_response.dart';
import 'package:car2gouser/models/api_responses/nearest_cars_list_response.dart';
import 'package:car2gouser/models/api_responses/profile_details.dart';
import 'package:car2gouser/models/api_responses/ride_details_response.dart';
import 'package:car2gouser/models/api_responses/ride_request_update_socket_response.dart';
import 'package:car2gouser/models/api_responses/user_details_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/models/enum.dart';
import 'package:car2gouser/models/location_model.dart';
import 'package:car2gouser/models/payment_option_model.dart';
import 'package:car2gouser/models/screenParameters/accepted_request_screen_parameter.dart';
import 'package:car2gouser/models/screenParameters/submit_review_screen_parameter.dart';
import 'package:car2gouser/screens/bottomsheet_screen/choose_reason_ride_cancel_bottomsheet.dart';
import 'package:car2gouser/screens/bottomsheet_screen/select_payment_method_bottomSheet.dart';
import 'package:car2gouser/screens/bottomsheet_screen/submit_review_bottomSheet.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:url_launcher/url_launcher.dart';

class AcceptedRequestScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /*<----------- Initialize variables ----------->*/
  late AnimationController _animationController;
  late Animation<double> _animation;
  ProfileDetails userDetailsData = ProfileDetails.empty();
  TextEditingController couponController = TextEditingController();
  SelectPaymentOptionModel getValues = SelectPaymentOptionModel();
  String otp = '';
  String value = '';
  List<LatLng> remainingPolylinePoints = [];
  Timer? locationUpdateTimer;
  SocketController socketController = Get.find<SocketController>();

  AcceptedRequestScreenParameter? screenParameter;
  late Location location;
  LocationModel? pickupLocation;
  LocationModel? dropLocation;
  List<NearestCarsListRide> rides = [];
  List<NearestCarsListCategory> categories = [];
  NearestCarsListRide? selectedRide;
  LatLng? _previousPosition;
  LatLng? _targetPosition;
  BitmapDescriptor? driverCarIcon;
  BitmapDescriptor? nearestCarIcon;
  BitmapDescriptor? nearestMotorCycleIcon;
  BitmapDescriptor pickUpIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropUpIcon = BitmapDescriptor.defaultMarker;
  String rideId = '';
  RideDetailsData rideDetails = RideDetailsData.empty();
  RideHistoryStatus ridePostAcceptanceStatus = RideHistoryStatus.accepted;
  Rx<LatLng> userLocation = Rx<LatLng>(const LatLng(0.0, 0.0));
  RideRequestStatus? rideRequestStatus;
  RxBool rideAccepted = false.obs;
  double carRotation = 0.0;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  bool _makePayment = false;
  bool get makePayment => _makePayment;
  set makePayment(bool value) {
    _makePayment = value;
    update();
  }

  final pickupMarkerId = 'pickUpMarkerId';
  final dropMarkerId = 'dropMarkerId';

  late GoogleMapController googleMapController;
  bool isGoogleMapInitialized = false;
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolyLines = {};
  LatLng cameraPosition = const LatLng(0, 0);
  final List<LocationModel> polyLinePoints = [];
  double zoomLevel = 12;
  double maxDistance = 0;
/*<-------- Socket initialize------->*/
  IO.Socket socket = IO.io(
      AppConstants.appBaseURL,
      IO.OptionBuilder().setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']).build());
  StreamSubscription<RideDetailsData>?
      rideDetailsAcceptRequestScreenSocketListener;
  void onGoogleMapCreated(GoogleMapController controller) {
    isGoogleMapInitialized = true;
    googleMapController = controller;
  }

  Future<void> _focusLocation(
      {required double latitude, required double longitude}) async {
    final latLng = LatLng(latitude, longitude);
    final double zoomLevel = await googleMapController.getZoomLevel();
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: zoomLevel)));
    AppSingleton.instance.defaultCameraPosition =
        CameraPosition(target: latLng, zoom: zoomLevel);
    update();
  }

  dynamic onRideRequestStatus(dynamic data) async {
    log('data socket');
    RideRequestUpdateSocketResponse? response =
        RideRequestUpdateSocketResponse.fromJson(data);
    log(response.toJson().toString());
    if (response.status.isNotEmpty) {
      rideRequestStatus = RideRequestStatus.toEnumValue(response.status);
      update();
    }
    if (rideRequestStatus?.stringValue ==
        RideRequestStatus.accepted.stringValue) {
      rideAccepted.value = true;
      Get.back();
      Get.toNamed(AppPageNames.acceptedRequestScreen, arguments: response.ride);
    } else {
      rideAccepted.value = false;
      Get.back();
    }
    log('back getting called');
    update();
    await Future.delayed(const Duration(seconds: 1));
    update();
  }

  void computeCentroid(List<LocationModel> points) {
    double latitude = 0;
    double longitude = 0;
    LocationModel eastMost = LocationModel(latitude: 0, longitude: -180);
    LocationModel westMost = LocationModel(latitude: 0, longitude: 180);
    LocationModel northMost = LocationModel(latitude: -180, longitude: 0);
    LocationModel southMost = LocationModel(latitude: 180, longitude: 0);

    for (LocationModel point in points) {
      if (point.longitude > eastMost.longitude) {
        eastMost = point;
      }
      if (point.longitude < westMost.longitude) {
        westMost = point;
      }
      if (point.latitude > northMost.latitude) {
        northMost = point;
      }
      if (point.latitude < southMost.latitude) {
        southMost = point;
      }
    }
    log('EastMost: ${eastMost.longitude}\nWestMost: ${westMost.longitude}\nNorthMost: ${northMost.latitude}\nSouthMost: ${southMost.latitude}');
    latitude = ((northMost.latitude + southMost.latitude) / 2);
    longitude = ((eastMost.longitude + westMost.longitude) / 2);
    log('Centroid:\nLatitude: $latitude  Longitude: $longitude');

    final bound = boundsFromLatLngList([
      LatLng(eastMost.latitude, eastMost.longitude),
      LatLng(westMost.latitude, westMost.longitude),
      LatLng(southMost.latitude, southMost.longitude),
      LatLng(northMost.latitude, northMost.longitude)
    ]);

    if (bound != null) {
      googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(bound, 60));
      update();
    }
  }

  onResetListButtonTap() {
    selectedRide = null;
    update();
    getList();
  }

  void getNearestCarsList() {
    getList();
  }

/*<--------Get nearest vehicle list------->*/
  Future<void> getList() async {
    NearestCarsListResponse? response = await APIRepo.getNearestCarsList(
        lat: pickupLocation?.latitude ?? 0,
        lng: pickupLocation?.longitude ?? 0,
        destLat: dropLocation?.latitude ?? 0,
        destLng: dropLocation?.longitude ?? 0);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingNearestCarsList(response);
  }

  void onSuccessRetrievingNearestCarsList(NearestCarsListResponse response) {
    rides = response.data.rides;
    categories = response.data.categories;
    update();
    updateNearestCarsList();
    log('Nearest cars list fetched successfully!');
    return;
  }

  void onCategoryClick(String categoryId) async {
    dynamic res = await AppDialogs.showConfirmDialog(
        messageText: AppLanguageTranslation
            .areYouSureSendBatchRequestsCarsUnderThisCategoryTransKey
            .toCurrentLanguage,
        onYesTap: () async {
          Get.back(result: true);
        },
        onNoTap: () {
          Get.back(result: false);
        },
        shouldCloseDialogOnceYesTapped: false);
    if (res is bool) {
      doActionForCategoryClick(categoryId, res);
    }
  }

  void onCouponClick() async {
    if (couponController.text.isEmpty) {
      AppDialogs.showErrorDialog(messageText: 'Please enter coupon code');
      return;
    } else {
      // onCouponTap();
      update();
    }
  } //=========fetching error=============

  void startLocationUpdates() {
    locationUpdateTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      final shouldUpdateDriverLocation = (rideDetails.status == 'reached' ||
              rideDetails.status == 'completed' ||
              rideDetails.status == 'cancelled') ==
          false;
      if (shouldUpdateDriverLocation) {
        //getLiveLocation();
      }
    });
    // createDriverCarIcon();
  }

/*   void createDriverCarIcon() async {
    final Uint8List? markerIcon = await getBytesFromAsset(
        AppAssetImages.carIconImage, 40); // Make the car icon smaller
    if (markerIcon != null) {
      driverCarIcon = BitmapDescriptor.fromBytes(markerIcon);
      update();
    }
  } */
  void createDriverCarIcon() async {
    // driverCarIcon = await _resizeImage(AppAssetImages.carGPSImage, 40, 80); // Adjust the size as needed
    try {
      // driverCarIcon = await BitmapDescriptor.asset(const ImageConfiguration(size: Size(5, 5)),AppAssetImages.carGPSImage);
      // driverCarIcon = await BitmapDescriptor.fromAssetImage(
      //     const ImageConfiguration(size: Size(15, 15)),
      //     AppAssetImages.carGPSImage);
      driverCarIcon = await _resizeImage(AppAssetImages.carGPSImage, 40, 80);
      // driverCarIcon = await BitmapDescriptor.defaultMarker;
    } on Exception catch (e) {
      e.printError();
    }
    update();
  }

/*   Future<void> onCouponTap() async {
    Map<String, dynamic> requestBody = {
      '_id': rideId,
      'coupon': couponController.text
    };
    RawAPIResponse? response = await APIRepo.applyCoupon(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      couponController.clear();

      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      couponController.clear();

      return;
    }
    log(response.toJson().toString());
    _onSuccessApplyCoupon(response);
  }

  _onSuccessApplyCoupon(RawAPIResponse response) async {
    await getRideDetails();
    update();
    couponController.clear();
  } */

  Future<void> doActionForCategoryClick(
      String categoryId, bool runBatchRequests) async {
    NearestCarsListResponse? response = await APIRepo.getNearestCarsList(
        lat: pickupLocation?.latitude ?? 0,
        lng: pickupLocation?.longitude ?? 0,
        destLat: dropLocation?.latitude ?? 0,
        destLng: dropLocation?.longitude ?? 0,
        categoryId: categoryId);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: response?.msg ??
              AppLanguageTranslation
                  .noResponseFoundTryAgainTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingCategoryWiseVehicles(response, runBatchRequests);
  }

  onSuccessGettingCategoryWiseVehicles(
      NearestCarsListResponse response, bool runBatchRequests) {
    rides = response.data.rides;
    selectedRide = null;
    update();
    updateNearestCarsList();
    if (runBatchRequests) {
      sendBatchRideRequests();
    }
  }

//bottomsheet button

  void YesbuttonTap() {
    Get.back(result: true);
    Get.toNamed(AppPageNames.cancelRideReason);
  }

  void NobuttonTap() {
    Get.back();
  }

  void updateNearestCarsList() {
    googleMapMarkers.clear();
    _addPickUpAndDropMarkers();
    for (final (int, NearestCarsListRide) singleRide in rides.indexed) {
      singleRide.$1;
      BitmapDescriptor icon;

      icon = nearestCarIcon!;
      googleMapMarkers.add(Marker(
          markerId: MarkerId('nearestCar-${singleRide.$1}'),
          position:
              LatLng(singleRide.$2.location.lat, singleRide.$2.location.lng),
          icon: icon));
    }
    update();
  }

  Future<void> sendBatchRideRequests() async {
    for (NearestCarsListRide currentRide in rides) {
      selectedRide = currentRide;
      update();
      onBottomButtonTap(showDialogue: false);
    }
    AppDialogs.showSuccessDialog(
        messageText: AppLanguageTranslation
            .requestHaveBeenSentDriversUnderThisCategoryTransKey
            .toCurrentLanguage);
    await Future.delayed(const Duration(seconds: 10));
    /*   AppDialogs.showErrorDialog(
        messageText: AppLanguageTranslation
            .noDriverAcceptedYourRequestUnfortunatelyTransKey
            .toCurrentLanguage); */
    selectedRide = null;
    update();
  }

  void onRideTap(NearestCarsListRide theRide) async {
    if (selectedRide == theRide) {
      selectedRide = null;
    } else {
      selectedRide = theRide;
    }
    update();
  }

  Future<void> getLiveLocation() async {
    LiveLocationResponse? response = await APIRepo.getRideLiveLocation(rideId);

    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessGetLiveLocation(response);
  }

  void onSuccessGetLiveLocation(LiveLocationResponse response) {
    LatLng newPosition = LatLng(response.data.lat, response.data.lng);

    if (_previousPosition == null) {
      _previousPosition = newPosition;
      updateDriverMarker(newPosition);
    } else {
      _previousPosition = _targetPosition ?? _previousPosition;
      _targetPosition = newPosition;
      _animationController.forward(from: 0);
    }

    carRotation = calculateBearing(_previousPosition!, newPosition);

    update();
  }

  double calculateBearing(LatLng start, LatLng end) {
    double startLat = degreesToRadians(start.latitude);
    double startLng = degreesToRadians(start.longitude);
    double endLat = degreesToRadians(end.latitude);
    double endLng = degreesToRadians(end.longitude);

    double dLng = endLng - startLng;
    double y = math.sin(dLng) * math.cos(endLat);
    double x = math.cos(startLat) * math.sin(endLat) -
        math.sin(startLat) * math.cos(endLat) * math.cos(dLng);
    double bearing = radiansToDegrees(math.atan2(y, x));
    return (bearing + 360) % 360;
  }

  double degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  double radiansToDegrees(double radians) {
    return radians * 180 / math.pi;
  }

  void updatePolyline() {
    googleMapPolyLines.clear();
    List<LatLng> points = [
      LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
      LatLng(dropLocation!.latitude, dropLocation!.longitude)
    ];

    googleMapPolyLines.add(Polyline(
      polylineId: const PolylineId('thePolyLine'),
      color: Colors.teal,
      width: 3,
      points: points,
    ));

    update();
  }

  int findClosestPointIndex(LatLng position) {
    double minDistance = double.infinity;
    int closestIndex = 0;

    for (int i = 0; i < remainingPolylinePoints.length; i++) {
      double distance = calculateDistance(position, remainingPolylinePoints[i]);
      if (distance < minDistance) {
        minDistance = distance;
        closestIndex = i;
      }
    }

    return closestIndex;
  }

  double calculateDistance(LatLng point1, LatLng point2) {
    return math.sqrt(math.pow(point1.latitude - point2.latitude, 2) +
        math.pow(point1.longitude - point2.longitude, 2));
  }

  void updateDriverMarker(LatLng position) {
    if (isGoogleMapInitialized == false) {
      return;
    }
    googleMapMarkers
        .removeWhere((marker) => marker.markerId.value == 'driverMarker');

    if (driverCarIcon != null) {
      googleMapMarkers.add(
        Marker(
          markerId: const MarkerId('driverMarker'),
          position: position,
          icon: driverCarIcon!,
          rotation: carRotation,
          anchor: const Offset(0.5, 0.5),
        ),
      );
    }
  }

  void onSelectPaymentMethod({bool showDialogue = true}) async {
    final value = await Get.bottomSheet(const SelectPaymentMethodBottomSheet());
    if (value is SelectPaymentOptionModel) {
      getValues = value;
    }
    update();
  }

  void onBottomButtonTap({bool showDialogue = true}) async {
    String reason = 'No reason found';
    final Map<String, dynamic> requestBody = {
      '_id': rideId,
    };
    if (ridePostAcceptanceStatus.stringValue ==
        RideHistoryStatus.accepted.stringValue) {
      dynamic res = await Get.toNamed(AppPageNames.cancelRideReason);
      if (res is String) {
        reason = res;
        update();

        requestBody['status'] = 'cancelled';
        requestBody['cancel_reason'] = reason;
        cancelRide(requestBody);
      }
    }
    log(reason);
    log(ridePostAcceptanceStatus.stringValueForView);
  }
  /*<----------- Cancel ride----------->*/

  Future<void> cancelRide(Map<String, dynamic> requestBody) async {
    RawAPIResponse? response = await APIRepo.updateRideStatus(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: response?.message ??
              AppLanguageTranslation
                  .noResponseFoundTryAgainTranskey.toCurrentLanguage);
      return;
    } else if (response.success) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    log(response.toJson().toString());
    onSuccessCancellingRide(response);
  }

  onSuccessCancellingRide(RawAPIResponse response) {
    Get.back();
    Get.back();
    AppDialogs.showSuccessDialog(
        messageText: AppLanguageTranslation
            .rideHasBeenCancelledSuccessfullyTranskey.toCurrentLanguage);
  }

  Future<void> onPaymentTap() async {
    Map<String, dynamic> requestBody = {
      '_id': rideId,
      'method': getValues.value,
    };
    isLoading = true;
    RawAPIResponse? response = await APIRepo.onPaymentTap(requestBody);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.success) {
      APIHelper.onFailure(response.message);
      return;
    }
    log(response.toJson().toString());
    getValues.value == 'paypal' || getValues.value == 'stripe'
        ? _onSuccessPaymentStatus(response)
        : _onSuccessWalletPaymentStatus(response);
  }

  _onSuccessPaymentStatus(RawAPIResponse response) async {
    final didOpenSuccessfully =
        await Helper.openURLInBrowser(url: response.data);
    if (didOpenSuccessfully == false) {
      AppDialogs.showErrorDialog(
          messageText: 'Failed to open browser for payment');
    }
    update();

    /*  if (rideDetails.status == RideHistoryStatus.completed.stringValue) {
      // Get.offAllNamed(AppPageNames.homeNavigatorScreen);
    } */
    _initializeAfterDelay(response);
  }

  _onSuccessWalletPaymentStatus(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.message);
    update();
    makePayment = true;

    // Get.offAllNamed(AppPageNames.homeNavigatorScreen);
  }

  _initializeAfterDelay(RawAPIResponse response) async {
    await Future.delayed(const Duration(seconds: 300));
    await getRideDetails();
    if (rideDetails.payment.status == 'paid' &&
        rideDetails.payment.method != 'cash') {
      makePayment = true;
      AppDialogs.showSuccessDialog(messageText: response.message);

      update();
    }

    update();
  }
  /*<----------- Get ride details ----------->*/

  Future<void> getRideDetails() async {
    RideDetailsResponse? response = await APIRepo.getRideDetails(rideId);
    if (response == null) {
      APIHelper.onError(response?.msg ??
          AppLanguageTranslation
              .noResponseFoundTryAgainTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRideDetails(response);
  }

  onSuccessRetrievingRideDetails(RideDetailsResponse response) {
    otp = response.data.otp;
    rideDetails = response.data;
    if (rideDetails.payment.status == 'paid' &&
        rideDetails.payment.method != 'cash') {
      makePayment = true;
      update();
    }
    update();
  }
/*<----------- Fetch screen navigation argument----------->*/

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is AcceptedRequestScreenParameter) {
      screenParameter = params;
      rideId = screenParameter?.rideId ?? '';
      pickupLocation =
          screenParameter?.selectedCarScreenParameter.pickupLocation;
      dropLocation = screenParameter?.selectedCarScreenParameter.dropLocation;
      update();
      if (rideId.isNotEmpty) {
        getRideDetails();
      }
    }
  }

  void submitReview() {
    Get.bottomSheet(const SubmitReviewBottomSheetScreen(),
        settings: RouteSettings(
            arguments:
                SubmitReviewScreenParameter(id: rideDetails.id, type: 'ride')));
  }
/* <---- Get polylines from google API ----> */

  Future<void> getPolyLines(
      double orLat, double orLong, double tarLat, double tarLong) async {
    GoogleMapPolyLinesResponse? response =
        await APIRepo.getRoutesPolyLines(orLat, orLong, tarLat, tarLong);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noPolylinesFoundForThisRouteTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(AppLanguageTranslation
          .errorHappenedWhileRetrievingPolylinesTransKey.toCurrentLanguage);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingPolyLines(response);
  }

  void onSuccessRetrievingPolyLines(GoogleMapPolyLinesResponse response) {
    List<LatLng> pointLatLngs = [];
    for (var route in response.routes) {
      for (var leg in route.legs) {
        for (var step in leg.steps) {
          pointLatLngs.addAll(decodePolyline(step.polyline.points));
        }
      }
    }

    googleMapPolyLines.add(Polyline(
      polylineId: const PolylineId('thePolyLine'),
      color: Colors.teal,
      width: 3,
      points: pointLatLngs,
    ));

    polyLinePoints.clear();
    for (var point in pointLatLngs) {
      polyLinePoints.add(
          LocationModel(latitude: point.latitude, longitude: point.longitude));
    }

    computeCentroid(polyLinePoints);
    update();
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      poly.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return poly;
  }

  _addPickUpAndDropMarkers() async {
    int aspectSize = (Get.context!.devicePixelRatio * 30).toInt();
    final Uint8List? pickIcon =
        await getBytesFromAsset(AppAssetImages.pickupMarkerPngIcon, aspectSize);

    if (pickIcon != null) {
      pickUpIcon = BitmapDescriptor.fromBytes(pickIcon);
    }
    final Uint8List? dropIcon =
        await getBytesFromAsset(AppAssetImages.dropMarkerPngIcon, aspectSize);

    if (dropIcon != null) {
      dropUpIcon = BitmapDescriptor.fromBytes(dropIcon);
    }

    googleMapMarkers.add(Marker(
        markerId: MarkerId(pickupMarkerId),
        position: LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
        icon: pickUpIcon));
    googleMapMarkers.add(Marker(
        markerId: MarkerId(dropMarkerId),
        position: LatLng(dropLocation!.latitude, dropLocation!.longitude),
        icon: dropUpIcon));
  }

  _assignParameters() async {
    _addPickUpAndDropMarkers();

    getPolyLines(pickupLocation!.latitude, pickupLocation!.longitude,
        dropLocation!.latitude, dropLocation!.longitude);
    update();
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  void createCarsLocationIcon() async {
    int aspectSize = (Get.context!.devicePixelRatio * 30).toInt();

    final Uint8List? markerIcon =
        await getBytesFromAsset(AppAssetImages.nearestCar, aspectSize);

    if (markerIcon != null) {
      nearestCarIcon = BitmapDescriptor.fromBytes(markerIcon);
    }

    update();
  }
/*   void createCarsLocationIcon() async {
    nearestCarIcon = await _resizeImage(
        AppAssetImages.carGPSImage, 40, 80); // Adjust the size as needed
    update();
  } */

  Future<BitmapDescriptor> _resizeImage(
      String assetPath, int width, int height) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    ByteData? byteData =
        await fi.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }
/* <---- Ride request status update ----> */

  dynamic onRideRequestStatusUpdate(dynamic data) async {
    if (data is RideDetailsData) {
      rideDetails = data;
      update();
      ridePostAcceptanceStatus =
          RideHistoryStatus.toEnumValue(rideDetails.status);
      update();
      /* AppDialogs.showSuccessDialog(
          messageText:
              '${AppLanguageTranslation.rideHasBeenTransKey.toCurrentLanguage} ${ridePostAcceptanceStatus.stringValueForView}!'); */
    }
    log('Ride is updated!');
    if (ridePostAcceptanceStatus == RideHistoryStatus.completed) {
      // Get.offAllNamed(AppPageNames.homeNavigatorScreen);
      Get.until((route) => Get.currentRoute == AppPageNames.zoomDrawerScreen);
    }
  }

  /* <---- Initial state ----> */
  void _animateMarker() {
    if (_previousPosition != null && _targetPosition != null) {
      double lat = lerpDouble(_previousPosition!.latitude,
          _targetPosition!.latitude, _animation.value)!;
      double lng = lerpDouble(_previousPosition!.longitude,
          _targetPosition!.longitude, _animation.value)!;
      LatLng newPosition = LatLng(lat, lng);

      updateDriverMarker(newPosition);
      carRotation = calculateBearing(_previousPosition!, newPosition);

      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    userDetailsData = Helper.getUser();
    createDriverCarIcon();
    startLocationUpdates();

    // SocketController socketScreenController =Get.put<SocketController>(SocketController());

    rideDetailsAcceptRequestScreenSocketListener ??=
        socketController.rideDetails.stream.listen((p0) {
      onRideRequestStatusUpdate(p0);
    }, cancelOnError: false);
/*     socketController.rideDetailsAcceptRequestScreenSocketListener
        ?.onData((data) {
      onRideRequestStatus(data);
    }); */
    _animationController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    _animationController.addListener(_animateMarker);
    createCarsLocationIcon();
    // getNearestCarsList();
    // _assignParameters();
    // TODO: Save Dummy Data
    rideDetails.status = 'cancelled';
    super.onInit();
  }

/*   @override
  void dispose() {
    listen?.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    dispose();
    socket.disconnect();
    socket.close();
    socket.dispose();
    // Get.reset();
    super.onClose();
  } */

  @override
  void onClose() {
    onAsyncClose();
    _animationController.removeListener(_animateMarker);
    _animationController.dispose();
    super.onClose();
  }

  Future<void> onAsyncClose() async {
    await rideDetailsAcceptRequestScreenSocketListener?.cancel();
    rideDetailsAcceptRequestScreenSocketListener = null;
  }

  LatLngBounds? boundsFromLatLngList(List<LatLng> list) {
    if (list.isEmpty) {
      return null;
    }
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }

    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }
}

/* class AcceptedRequestScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  SelectPaymentOptionModel getValues = SelectPaymentOptionModel();
  String otp = '';
  String value = '';
  AcceptedRequestScreenParameter? screenParameter;

  LocationModel? pickupLocation;
  LocationModel? dropLocation;
  List<NearestCarsListRide> rides = [];
  List<NearestCarsListCategory> categories = [];
  NearestCarsListRide? selectedRide;
  SocketController socketController = Get.find<SocketController>();
  BitmapDescriptor? nearestCarIcon;
  BitmapDescriptor? nearestMotorCycleIcon;
  BitmapDescriptor pickUpIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropUpIcon = BitmapDescriptor.defaultMarker;
  String rideId = '';
  RideDetailsData rideDetails = RideDetailsData.empty();
  RideHistoryStatus ridePostAcceptanceStatus = RideHistoryStatus.accepted;

  RideRequestStatus? rideRequestStatus;
  RxBool rideAccepted = false.obs;

  final pickupMarkerId = 'pickUpMarkerId';
  final dropMarkerId = 'dropMarkerId';

  late GoogleMapController googleMapController;
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolyLines = {};
  LatLng cameraPosition = const LatLng(0, 0);
  final List<LocationModel> polyLinePoints = [];
  double zoomLevel = 12;
  double maxDistance = 0;
/*<-------- Socket initialize------->*/
  IO.Socket socket = IO.io(
      AppConstants.appBaseURL,
      IO.OptionBuilder().setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']).build());

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  dynamic onRideRequestStatus(dynamic data) async {
    log('data socket');
    RideRequestUpdateSocketResponse? response =
        RideRequestUpdateSocketResponse.fromJson(data);
    log(response.toJson().toString());
    if (response.status.isNotEmpty) {
      rideRequestStatus = RideRequestStatus.toEnumValue(response.status);
      update();
    }
    if (rideRequestStatus?.stringValue ==
        RideRequestStatus.accepted.stringValue) {
      rideAccepted.value = true;
      Get.back();
      Get.toNamed(AppPageNames.acceptedRequestScreen, arguments: response.ride);
    } else {
      rideAccepted.value = false;
      Get.back();
    }
    log('back getting called');
    update();
    await Future.delayed(const Duration(seconds: 1));
    update();
  }

  void computeCentroid(List<LocationModel> points) {
    double latitude = 0;
    double longitude = 0;
    LocationModel eastMost = LocationModel(latitude: 0, longitude: -180);
    LocationModel westMost = LocationModel(latitude: 0, longitude: 180);
    LocationModel northMost = LocationModel(latitude: -180, longitude: 0);
    LocationModel southMost = LocationModel(latitude: 180, longitude: 0);

    for (LocationModel point in points) {
      if (point.longitude > eastMost.longitude) {
        eastMost = point;
      }
      if (point.longitude < westMost.longitude) {
        westMost = point;
      }
      if (point.latitude > northMost.latitude) {
        northMost = point;
      }
      if (point.latitude < southMost.latitude) {
        southMost = point;
      }
    }
    log('EastMost: ${eastMost.longitude}\nWestMost: ${westMost.longitude}\nNorthMost: ${northMost.latitude}\nSouthMost: ${southMost.latitude}');
    latitude = ((northMost.latitude + southMost.latitude) / 2);
    longitude = ((eastMost.longitude + westMost.longitude) / 2);
    log('Centroid:\nLatitude: $latitude  Longitude: $longitude');

    final bound = boundsFromLatLngList([
      LatLng(eastMost.latitude, eastMost.longitude),
      LatLng(westMost.latitude, westMost.longitude),
      LatLng(southMost.latitude, southMost.longitude),
      LatLng(northMost.latitude, northMost.longitude)
    ]);

    if (bound != null) {
      googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(bound, 60));
      update();
    }
  }

  onResetListButtonTap() {
    selectedRide = null;
    update();
    getList();
  }

  void getNearestCarsList() {
    getList();
  }

/*<--------Get nearest vehicle list------->*/
  Future<void> getList() async {
    NearestCarsListResponse? response = await APIRepo.getNearestCarsList(
        lat: pickupLocation?.latitude ?? 0,
        lng: pickupLocation?.longitude ?? 0,
        destLat: dropLocation?.latitude ?? 0,
        destLng: dropLocation?.longitude ?? 0);
    if (response == null) {
      APIHelper.onError(response?.msg ??
          AppLanguageTranslation
              .noResponseFoundTryAgainTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingNearestCarsList(response);
  }

  void onSuccessRetrievingNearestCarsList(NearestCarsListResponse response) {
    rides = response.data.rides;
    categories = response.data.categories;
    update();
    updateNearestCarsList();
    log('Nearest cars list fetched successfully!');
    return;
  }

  void onCategoryClick(String categoryId) async {
    dynamic res = await AppDialogs.showConfirmDialog(
        messageText: AppLanguageTranslation
            .areYouSureSendBatchRequestsCarsUnderThisCategoryTransKey
            .toCurrentLanguage,
        onYesTap: () async {
          Get.back(result: true);
        },
        onNoTap: () {
          Get.back(result: false);
        },
        shouldCloseDialogOnceYesTapped: false);
    if (res is bool) {
      doActionForCategoryClick(categoryId, res);
    }
  }

  Future<void> doActionForCategoryClick(
      String categoryId, bool runBatchRequests) async {
    NearestCarsListResponse? response = await APIRepo.getNearestCarsList(
        lat: pickupLocation?.latitude ?? 0,
        lng: pickupLocation?.longitude ?? 0,
        destLat: dropLocation?.latitude ?? 0,
        destLng: dropLocation?.longitude ?? 0,
        categoryId: categoryId);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: response?.msg ??
              AppLanguageTranslation
                  .noResponseFoundTryAgainTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingCategoryWiseVehicles(response, runBatchRequests);
  }

  onSuccessGettingCategoryWiseVehicles(
      NearestCarsListResponse response, bool runBatchRequests) {
    rides = response.data.rides;
    selectedRide = null;
    update();
    updateNearestCarsList();
    if (runBatchRequests) {
      sendBatchRideRequests();
    }
  }

  void updateNearestCarsList() {
    googleMapMarkers.clear();
    _addPickUpAndDropMarkers();
    for (final (int, NearestCarsListRide) singleRide in rides.indexed) {
      singleRide.$1;
      BitmapDescriptor icon;

      icon = nearestCarIcon!;
      googleMapMarkers.add(Marker(
          markerId: MarkerId('nearestCar-${singleRide.$1}'),
          position:
              LatLng(singleRide.$2.location.lat, singleRide.$2.location.lng),
          icon: icon));
    }
    update();
  }

  Future<void> sendBatchRideRequests() async {
    for (NearestCarsListRide currentRide in rides) {
      selectedRide = currentRide;
      update();
      onBottomButtonTap(showDialogue: false);
    }
    AppDialogs.showSuccessDialog(
        messageText: AppLanguageTranslation
            .requestHaveBeenSentDriversUnderThisCategoryTransKey
            .toCurrentLanguage);
    await Future.delayed(const Duration(seconds: 10));
    AppDialogs.showErrorDialog(
        messageText: AppLanguageTranslation
            .noDriverAcceptedYourRequestUnfortunatelyTransKey
            .toCurrentLanguage);
    selectedRide = null;
    update();
  }

  void onRideTap(NearestCarsListRide theRide) async {
    if (selectedRide == theRide) {
      selectedRide = null;
    } else {
      selectedRide = theRide;
    }
    update();
  }

  void onSelectPaymentMethod({bool showDialogue = true}) async {
    final value = await Get.bottomSheet(const SelectPaymentMethodBottomSheet());
    if (value is SelectPaymentOptionModel) {
      getValues = value;
    }
    update();
  }

  void onBottomButtonTap({bool showDialogue = true}) async {
    String reason = 'No reason found';
    final Map<String, dynamic> requestBody = {
      '_id': rideId,
    };
    if (ridePostAcceptanceStatus.stringValue ==
        RideHistoryStatus.accepted.stringValue) {
      dynamic res =
          await Get.bottomSheet(const ChooseReasonCancelRideBottomSheet());
      if (res is String) {
        reason = res;
        update();

        requestBody['status'] = 'cancelled';
        requestBody['cancel_reason'] = reason;
        cancelRide(requestBody);
      }
    }
    log(reason);
    log(ridePostAcceptanceStatus.stringValueForView);
  }
  /*<----------- Cancel ride----------->*/

  Future<void> cancelRide(Map<String, dynamic> requestBody) async {
    RawAPIResponse? response = await APIRepo.updateRideStatus(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: response?.msg ??
              AppLanguageTranslation
                  .noResponseFoundTryAgainTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessCancellingRide(response);
  }

  onSuccessCancellingRide(RawAPIResponse response) {
    Get.back();
    Get.back();
    AppDialogs.showSuccessDialog(
        messageText: AppLanguageTranslation
            .rideHasBeenCancelledSuccessfullyTranskey.toCurrentLanguage);
  }

  Future<void> onPaymentTap() async {
    Map<String, dynamic> requestBody = {
      '_id': rideId,
      'method': getValues.value,
    };
    RawAPIResponse? response = await APIRepo.onPaymentTap(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    getValues.value == 'paypal'
        ? _onSuccessPaymentStatus(response)
        : _onSuccessWalletPaymentStatus(response);
  }

  _onSuccessPaymentStatus(RawAPIResponse response) async {
    await launchUrl(Uri.parse(response.data));
    update();
    // Get.offAllNamed(AppPageNames.zoomDrawerScreen);
    Helper.getBackToHomePage();
    _initializeAfterDelay(response);
  }

  _onSuccessWalletPaymentStatus(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
    // Get.offAllNamed(AppPageNames.zoomDrawerScreen);
    Helper.getBackToHomePage();
  }

  _initializeAfterDelay(RawAPIResponse response) async {
    await Future.delayed(const Duration(seconds: 3));
    AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
  }
  /*<----------- Get ride details ----------->*/

  Future<void> getRideDetails() async {
    RideDetailsResponse? response = await APIRepo.getRideDetails(rideId);
    if (response == null) {
      APIHelper.onError(response?.msg ??
          AppLanguageTranslation
              .noResponseFoundTryAgainTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRideDetails(response);
  }

  onSuccessRetrievingRideDetails(RideDetailsResponse response) {
    otp = response.data.otp;
    rideDetails = response.data;
    update();
  }
/*<----------- Fetch screen navigation argument----------->*/

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is AcceptedRequestScreenParameter) {
      screenParameter = params;
      rideId = screenParameter?.rideId ?? '';
      pickupLocation =
          screenParameter?.selectedCarScreenParameter.pickupLocation;
      dropLocation = screenParameter?.selectedCarScreenParameter.dropLocation;
      update();
      if (rideId.isNotEmpty) {
        getRideDetails();
      }
    }
  }

  void submitReview() {
    Get.bottomSheet(const SubmitReviewBottomSheetScreen(),
        settings: RouteSettings(
            arguments:
                SubmitReviewScreenParameter(id: rideDetails.id, type: 'ride')));
  }
/* <---- Get polylines from google API ----> */

  Future<void> getPolyLines(
      double orLat, double orLong, double tarLat, double tarLong) async {
    GoogleMapPolyLinesResponse? response =
        await APIRepo.getRoutesPolyLines(orLat, orLong, tarLat, tarLong);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noPolylinesFoundForThisRouteTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(AppLanguageTranslation
          .errorHappenedWhileRetrievingPolylinesTransKey.toCurrentLanguage);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingPolyLines(response);
  }

  void onSuccessRetrievingPolyLines(GoogleMapPolyLinesResponse response) {
    List<LatLng> pointLatLngs = [];
    for (var route in response.routes) {
      for (var leg in route.legs) {
        for (var step in leg.steps) {
          pointLatLngs.addAll(decodePolyline(step.polyline.points));
        }
      }
    }

    googleMapPolyLines.add(Polyline(
      polylineId: PolylineId('thePolyLine'),
      color: Colors.teal,
      width: 3,
      points: pointLatLngs,
    ));

    polyLinePoints.clear();
    for (var point in pointLatLngs) {
      polyLinePoints.add(
          LocationModel(latitude: point.latitude, longitude: point.longitude));
    }

    computeCentroid(polyLinePoints);
    update();
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      poly.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return poly;
  }

  _addPickUpAndDropMarkers() async {
    int aspectSize = (Get.context!.devicePixelRatio * 30).toInt();
    final Uint8List? pickIcon =
        await getBytesFromAsset(AppAssetImages.pickupMarkerPngIcon, aspectSize);

    if (pickIcon != null) {
      pickUpIcon = BitmapDescriptor.fromBytes(pickIcon);
    }
    final Uint8List? dropIcon =
        await getBytesFromAsset(AppAssetImages.dropMarkerPngIcon, aspectSize);

    if (dropIcon != null) {
      dropUpIcon = BitmapDescriptor.fromBytes(dropIcon);
    }

    googleMapMarkers.add(Marker(
        markerId: MarkerId(pickupMarkerId),
        position: LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
        icon: pickUpIcon));
    googleMapMarkers.add(Marker(
        markerId: MarkerId(dropMarkerId),
        position: LatLng(dropLocation!.latitude, dropLocation!.longitude),
        icon: dropUpIcon));
  }

  _assignParameters() async {
    _addPickUpAndDropMarkers();

    getPolyLines(pickupLocation!.latitude, pickupLocation!.longitude,
        dropLocation!.latitude, dropLocation!.longitude);
    update();
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  void createCarsLocationIcon() async {
    int aspectSize = (Get.context!.devicePixelRatio * 30).toInt();

    final Uint8List? markerIcon =
        await getBytesFromAsset(AppAssetImages.nearestCar, aspectSize);

    if (markerIcon != null) {
      nearestCarIcon = BitmapDescriptor.fromBytes(markerIcon);
    }

    update();
  }
/* <---- Ride request status update ----> */

  dynamic onRideRequestStatusUpdate(dynamic data) async {
    if (data is RideDetailsData) {
      rideDetails = data;
      update();
      ridePostAcceptanceStatus =
          RideHistoryStatus.toEnumValue(rideDetails.status);
      update();
      AppDialogs.showSuccessDialog(
          messageText:
              '${AppLanguageTranslation.rideHasBeenTransKey.toCurrentLanguage} ${ridePostAcceptanceStatus.stringValueForView}!');
    }
    log('Ride is updated!');
  }

  StreamSubscription<RideDetailsData>? listen;
  /* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameters();
    SocketController socketScreenController =
        Get.put<SocketController>(SocketController());

    listen = socketScreenController.rideDetails.listen((p0) {
      onRideRequestStatusUpdate(p0);
    });
    createCarsLocationIcon();

    _assignParameters();

    super.onInit();
  }

  @override
  void dispose() {
    listen?.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    dispose();
    socket.disconnect();
    socket.close();
    socket.dispose();
    // Get.reset();
    super.onClose();
  }

  LatLngBounds? boundsFromLatLngList(List<LatLng> list) {
    if (list.isEmpty) {
      return null;
    }
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }

    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }
}
 */
