import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:car2gouser/controller/socket_controller.dart';
import 'package:car2gouser/models/api_responses/commons/location_position.dart';
import 'package:car2gouser/models/api_responses/google_map_poly_lines_response.dart';
import 'package:car2gouser/models/api_responses/nearest_cars_list_response.dart';
import 'package:car2gouser/models/api_responses/ride_request_update_socket_response.dart';
import 'package:car2gouser/models/api_responses/schedule_ride_post_response.dart';
import 'package:car2gouser/models/api_responses/search_nearest_vehicle_response.dart';
import 'package:car2gouser/models/core_api_responses/api_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/models/enum.dart';
import 'package:car2gouser/models/enums/ride_type.dart';
import 'package:car2gouser/models/location_model.dart';
import 'package:car2gouser/models/screenParameters/accepted_request_screen_parameter.dart';
import 'package:car2gouser/models/screenParameters/select_car_screen_parameter.dart';
import 'package:car2gouser/screens/bottomsheet_screen/ride_ongoing_dialog.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
/* 
class SelectCarScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  String testing = 'Select car screen controller.';
  SelectCarScreenParameter? screenParameter;
  LocationModel? pickupLocation;
  LocationModel? dropLocation;
  bool isScheduleRide = false;
  List<NearestCarsListRide> rides = [];
  RxBool barrierDismissible = false.obs;
  List<NearestCarsListCategory> categories = [];
  NearestCarsListRide? selectedRide;
  final GlobalKey<ScaffoldState> bottomSheetFormKey =
      GlobalKey<ScaffoldState>();
  BitmapDescriptor? nearestCarIcon;
  BitmapDescriptor? nearestMotorCycleIcon;
  String requestId = '';
  ScheduleRideData rideRequest = ScheduleRideData.empty();
  BitmapDescriptor pickUpIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropUpIcon = BitmapDescriptor.defaultMarker;
  StreamSubscription<RideRequestUpdateSocketResponse>? listen;
  RideRequestStatus? rideRequestStatus;
  RxBool rideAccepted = false.obs;
  DateTime? selectedDate;


  var selectedBookingDate = DateTime.now().obs;
  var selectedBookingTime = TimeOfDay.now().obs;

  final pickupMarkerId = 'pickUpMarkerId';
  final dropMarkerId = 'dropMarkerId';
  late GoogleMapController googleMapController;
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolyLines = {};
  LatLng cameraPosition = const LatLng(0, 0);
  final List<LocationModel> polyLinePoints = [];
  double zoomLevel = 12;
  double maxDistance = 0;

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
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

  String formatDateTime(DateTime date, TimeOfDay time) {
    DateTime combinedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    return Helper.timeZoneSuffixedDateTimeFormat(combinedDateTime);
  }
/* <---- Update selected start date----> */

  void updateSelectedStartDate(DateTime newDate) {
    selectedBookingDate.value = newDate;
    log(selectedBookingDate.value.toString());
  }
/* <---- Update selected start time----> */

  void updateSelectedStartTime(TimeOfDay newTime) {
    selectedBookingTime.value = newTime;
    log(selectedBookingTime.value.toString());
  }
/* <---- Reset list button tap----> */

  onResetListButtonTap() {
    selectedRide = null;
    update();
    getList();
  }
/* <---- Get nearest cars list----> */

  void getNearestCarsList() {
    getList();
  }

  /*<----------- Get List from API ----------->*/
  Future<void> getList() async {
    NearestCarsListResponse? response = await APIRepo.getNearestCarsList(
        lat: pickupLocation?.latitude ?? 0,
        lng: pickupLocation?.longitude ?? 0,
        destLat: dropLocation?.latitude ?? 0,
        destLng: dropLocation?.longitude ?? 0);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForNearestCarListTransKey.toCurrentLanguage);
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
/* <---- Ride request send to all vehicle in same category----> */

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
                  .noResponseForThisActionTranskey.toCurrentLanguage);
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
/* <---- Send batch ride requests from API ----> */

  Future<void> sendBatchRideRequests() async {
    for (NearestCarsListRide currentRide in rides) {
      selectedRide = currentRide;
      update();
      onRideNowButtonTap(showDialogue: false);
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
/* <---- Ride tap ----> */

  void onRideTap(NearestCarsListRide theRide) async {
    if (selectedRide == theRide) {
      selectedRide = null;
    } else {
      selectedRide = theRide;
    }
    update();
  }

/* <---- Ride now button tap ----> */
  void onRideNowButtonTap({bool showDialogue = true}) {
    final Map<String, dynamic> requestBody = {
      'ride': selectedRide!.id,
      'from': {
        'address': pickupLocation?.address,
        'location': {
          'lat': pickupLocation!.latitude,
          'lng': pickupLocation!.longitude
        }
      },
      'to': {
        'address': dropLocation?.address,
        'location': {
          'lat': dropLocation!.latitude,
          'lng': dropLocation!.longitude
        }
      }
    };
    if (isScheduleRide) {
      requestBody['schedule'] = true;
      requestBody['date'] =
          formatDateTime(selectedBookingDate.value, selectedBookingTime.value);
    }

    requestRide(requestBody, showDialogue);
  }

  Future<void> requestRide(
      Map<String, dynamic> requestBody, bool showDialogue) async {
    ScheduleRideResponse? response = await APIRepo.requestForRide(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForRideNowActionTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRequestingForRide(response, showDialogue);
  }

  onSuccessRequestingForRide(ScheduleRideResponse response, bool showDialogue) {
    requestId = response.data.id;
    rideRequest = response.data;
    update();
    if (showDialogue) {
      AppDialogs.showActionableDialog(
        barrierDismissible: barrierDismissible.value,
        titleText:
            AppLanguageTranslation.requestOngoingTransKey.toCurrentLanguage,
        titleTextColor: AppColors.primaryTextColor,
        messageText: AppLanguageTranslation
            .youRideRequestIsOngoingTransKey.toCurrentLanguage,
        buttonText:
            AppLanguageTranslation.cancelRequestTransKey.toCurrentLanguage,
        onTap: promptCancellation,
      );
    }
  }

  promptCancellation() async {
    dynamic res = await AppDialogs.showConfirmDialog(
        messageText: AppLanguageTranslation
            .areYouSuretoCancelOngoingRequestTransKey.toCurrentLanguage,
        onYesTap: () async {
          Get.back(result: true);
        },
        onNoTap: () {
          Get.back(result: false);
        },
        shouldCloseDialogOnceYesTapped: false);
    if (res is bool && res) {
      cancelPendingRequest();
    }
  }

  Future<void> cancelPendingRequest() async {
    final Map<String, dynamic> requestBody = {
      '_id': requestId,
      'status': 'rejected'
    };
    RawAPIResponse? response = await APIRepo.cancelPendingRequest(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForCancellingPendingRequestTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      barrierDismissible.value = true;
      return;
    }
    log(response.toJson().toString());
    onSuccessCancellingRequest(response);
  }

  onSuccessCancellingRequest(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  /*<----------- Fetch screen navigation argument----------->*/

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SelectCarScreenParameter) {
      screenParameter = params;
      selectedDate=screenParameter!.selectedDate;
      pickupLocation = screenParameter!.pickupLocation;
      dropLocation = screenParameter!.dropLocation;
      isScheduleRide = screenParameter?.isScheduleRide ?? false;
      update();
    }
  }

/*<-----------Get bytes from asset from API----------->*/

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }
  /* <---- Get polylines from API ----> */

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
    polyLinePoints.add(LocationModel(latitude: point.latitude, longitude: point.longitude));
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

/* <---- Icons in map ----> */
  void createCarsLocationIcon() async {
    nearestCarIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.nearestCar);
    nearestMotorCycleIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.nearestMotorCycle);
    update();
  }

/* <---- Get socket response for ride request status ----> */
  dynamic onRideRequestStatus(dynamic data) async {
    log('ride request status socket got trigerred!');
    RideRequestUpdateSocketResponse response =
        RideRequestUpdateSocketResponse();
    if (data is RideRequestUpdateSocketResponse) {
      response = data;
    }
    log(response.toJson().toString());
    if (response.status.isNotEmpty) {
      rideRequestStatus = RideRequestStatus.toEnumValue(response.status);
      update();
    }
    if (rideRequestStatus?.stringValue ==
        RideRequestStatus.accepted.stringValue) {
      rideAccepted.value = true;
      Get.back();
      Get.toNamed(AppPageNames.acceptedRequestScreen,
          arguments: AcceptedRequestScreenParameter(
              rideId: response.ride,
              selectedCarScreenParameter: SelectCarScreenParameter(
                  pickupLocation: pickupLocation!,
                  dropLocation: dropLocation!)));
    } else {
      rideAccepted.value = false;
      Get.back();
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .youPendingRequestWasRejectedByDriverTransKey.toCurrentLanguage);
    }
    log('back getting called');
    update();
    await Future.delayed(const Duration(seconds: 1));
    update();
  }

/* <---- Initial state ----> */
  @override
  void onInit() {
    SocketController socketScreenController = Get.find<SocketController>();
    listen = socketScreenController.rideRequestSocketResponse.listen(
      (p0) {
        onRideRequestStatus(p0);
      },
    );
    _getScreenParameters();
    createCarsLocationIcon();
    getNearestCarsList();
    _assignParameters();

    super.onInit();
  }

  @override
  void onClose() {
    //
    listen?.cancel();
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

class SelectCarScreenController extends GetxController {
  String testing = 'Select car screen controller.';
  String luggageNumber = '0';
  SelectCarScreenParameter? screenParameter;
  LocationModel? pickupLocation;
  LocationModel? dropLocation;
  bool isScheduleRide = false;
  RideType rideType = RideType.rideNow;
  LocationPosition? currentLocation;
  // List<LatLng> nearestCars = [];
  // List<NearestCarsListRide> rides = [];
  List<NearestVehicle> rides = [];
  RxBool barrierDismissible = false.obs;
  // bool chainRequest = false;
  // List<NearestCarsListCategory> categories = [];
  List<NearestVehiclesCategory> categories = [];
  NearestVehicle? _selectedRide;
  NearestVehicle? get selectedRide => _selectedRide;
  set selectedRide(NearestVehicle? value) {
    _selectedRide = value;
    update();
  }

  NearestVehiclesCategory? _selectedCategory;
  NearestVehiclesCategory? get selectedCategory => _selectedCategory;
  set selectedCategory(NearestVehiclesCategory? value) {
    _selectedCategory = value;
    update();
  }

  // final GlobalKey<ScaffoldState> bottomSheetFormKey =GlobalKey<ScaffoldState>();
  BitmapDescriptor? nearestCarIcon;
  BitmapDescriptor? nearestMotorCycleIcon;
  String requestId = '';
  ScheduleRideData rideRequest = ScheduleRideData.empty();
  BitmapDescriptor pickUpIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropUpIcon = BitmapDescriptor.defaultMarker;
  // late SocketController homeSocketScreenController;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  SocketController socketController = Get.find<SocketController>();
  // StreamSubscription<RideRequestUpdateSocketResponse>? listen;
  StreamSubscription<RideRequestUpdateSocketResponse>?
      rideRequestSocketResponseListener;

  RideRequestStatus? rideRequestStatus;
  // RxBool rideAccepted = false.obs;

  var selectedBookingDate = DateTime.now().obs;
  var selectedBookingTime = TimeOfDay.now().obs;

  final pickupMarkerId = 'pickUpMarkerId';
  final dropMarkerId = 'dropMarkerId';
  // double zoomLevel = 12;
  late GoogleMapController googleMapController;
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolyLines = {};
  LatLng cameraPosition = const LatLng(0, 0);
  final List<LocationModel> polyLinePoints = [];
  double zoomLevel = 12;
  double maxDistance = 0;
  bool get shouldEnableBottomButton =>
      selectedRide != null || selectedCategory != null;

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    // googleMapControllerCompleter.complete(controller);
    /* LatLngBounds;
    final bound = boundsFromLatLngList([
      LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
      LatLng(dropLocation!.latitude, dropLocation!.longitude)
    ]);
    /*
    pickupLocation!.latitude,
        pickupLocation!.longitude,
        dropLocation!.latitude,
        dropLocation!.longitude
    */
    if (bound != null) {
      googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(bound, 15));
    } */
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
    /*
    pickupLocation!.latitude,
        pickupLocation!.longitude,
        dropLocation!.latitude,
        dropLocation!.longitude
    */
    if (bound != null) {
      googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(bound, 60));
      update();
    }

    // return LatLng(latitude, longitude);
  }

  String formatDateTime(TimeOfDay time, DateTime date) {
    DateTime combinedDateTime = DateTime(
      time.hour,
      time.minute,
      date.year,
      date.month,
      date.day,
    );

    return Helper.timeZoneSuffixedDateTimeFormat(combinedDateTime);
  }

  void updateSelectedStartDate(DateTime newDate) {
    selectedBookingDate.value = newDate;
    log(selectedBookingDate.value.toString());
  }

  void updateSelectedStartTime(TimeOfDay newTime) {
    selectedBookingTime.value = newTime;
    log(selectedBookingTime.value.toString());
  }

  // Function to handle the DateTime picker logic

  String selectedDateTime = 'Now';

  void openDateTimePicker(BuildContext context) {
    final dateTimeParts = selectedDateTime.split('\n');
    BottomPicker.dateTime(
      pickerTitle: Column(
        children: [
          AppGaps.hGap5,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Schedule Ride',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black),
              ),
              RawButtonWidget(
                onTap: () {
                  isScheduleRide = false;
                  Get.back();
                },
                child: Text(
                  'RIDE NOW',
                  style: AppTextStyles.bodyMediumTextStyle
                      .copyWith(color: AppColors.warningColor),
                ),
              )
            ],
          ),
          AppGaps.hGap5,
          Divider()
        ],
      ),
      onSubmit: (date) {
        selectedDateTime = _formatDateTime(date); // Update selectedDateTime
        update(); // Notify listeners to rebuild the UI.
      },
      pickerTextStyle: AppTextStyles.titleSmallTextStyle
          .copyWith(color: AppColors.warningColor),
      minDateTime: DateTime(2021, 5, 1),
      maxDateTime: DateTime(2021, 8, 2),
      displayCloseIcon: false,
      initialDateTime: DateTime(2021, 5, 1),
      buttonContent: Center(
          child: Text(
        'Confirm',
        style: TextStyle(color: Colors.white),
      )),
      buttonWidth: 300.0,
      buttonStyle: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: AppColors.warningColor),
    ).show(context);
  }

  String _formatDateTime(DateTime dateTime) {
    final dateFormatter = DateFormat('d MMM yyyy'); // e.g., 2 Apr 2024
    final timeFormatter = DateFormat('h:mm a'); // e.g., 5:32 PM
    return '${timeFormatter.format(dateTime).toLowerCase()}\n${dateFormatter.format(dateTime)}';
  }

  void getNearestCarsList() {
    getList();
  }

  Future<void> getList() async {
/*     // TODO: Remove this fake data implementation
    onSuccessRetrievingNearestCarsList(NearestCarsListResponse(
        data: NearestCarsListData(rides: [
      NearestCarsListRide.empty()
        ..capacity = 3
        ..color = 'Red'
        ..currency = 'USD',
      NearestCarsListRide.empty()
        ..capacity = 3
        ..color = 'red'
        ..currency = 'BDT',
      NearestCarsListRide.empty(),
    ], categories: [
      NearestCarsListCategory(name: 'Name'),
    ])));
    log('message');
    return; */
/*     final response = await APIRepo.getNearestCarsList(
        lat: pickupLocation?.latitude ?? 0,
        lng: pickupLocation?.longitude ?? 0,
        destLat: dropLocation?.latitude ?? 0,
        destLng: dropLocation?.longitude ?? 0); */
    final response = await APIRepo.getNearestCarsListUpdated(requestBody: {
      'user_current_position': currentLocation?.toJson(),
      'pickup_location': {
        'name': pickupLocation?.address,
        'address': pickupLocation?.address,
        'position': {
          'lat': pickupLocation?.latitude,
          'lng': pickupLocation?.longitude
        }
      },
      'drop_location': {
        'name': dropLocation?.address,
        'address': dropLocation?.address,
        'position': {
          'lat': dropLocation?.latitude,
          'lng': dropLocation?.longitude
        }
      },
      'fare_type': RideType.rideNow.stringValue
    });
    if (response == null) {
      AppDialogs.showErrorDialog(messageText: 'Nearest cars list not found');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    log(response.toJson((data) => data.toJson()).toString());
    onSuccessRetrievingNearestCarsList(response);
  }

  void onSuccessRetrievingNearestCarsList(
      APIResponse<SearchNearestVehiclesResponse> response) {
    // rides = response.data.rides;
    rides = response.data.nearestVehicles;
    // categories = response.data.categories;
    categories = response.data.categories;
    update();
    updateNearestCarsList();
    log('Nearest cars list fetched successfully!');
    return;
  }

  void onCategoryClick(NearestVehiclesCategory theRide) async {
    selectedRide = null;
    if (selectedCategory == theRide) {
      selectedCategory = null;
    } else {
      selectedCategory = theRide;
    }
    update();

    // await doActionForCategoryClick(categoryId, true);
/*     dynamic res = await AppDialogs.showConfirmDialog(
        messageText:
            'Are you sure to send batch requests to cars under this category?',
        onYesTap: () async {
          Get.back(result: true);
        },
        onNoTap: () {
          Get.back(result: false);
        },
        shouldCloseDialogOnceYesTapped: false);
    if (res is bool) {
      doActionForCategoryClick(categoryId, res);
    } */
  }

  Future<void> doActionForCategoryClick(
      String categoryId, bool runBatchRequests) async {
    // TODO: Remove this fake data implementation
    _onSuccessGettingCategoryWiseVehicles(
        NearestCarsListResponse(data: NearestCarsListData()), runBatchRequests);
    log('message');
    return;
    isLoading = true;
    NearestCarsListResponse? response = await APIRepo.getNearestCarsList(
        lat: pickupLocation?.latitude ?? 0,
        lng: pickupLocation?.longitude ?? 0,
        destLat: dropLocation?.latitude ?? 0,
        destLng: dropLocation?.longitude ?? 0,
        categoryId: categoryId);
    isLoading = false;

    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: response?.msg ?? 'Nearest cars list not found');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessGettingCategoryWiseVehicles(response, runBatchRequests);
  }

  void _onSuccessGettingCategoryWiseVehicles(
      NearestCarsListResponse response, bool runBatchRequests) {
    // rides = response.data.rides;
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
    return;
/*     for (final (int, NearestVehicle) singleRide in rides.indexed) {
      singleRide.$1;
      BitmapDescriptor icon;
      // if(singleRide.vehicle.category == 'car'){icon = }
      if (nearestCarIcon == null) {
        break;
      }
      icon = nearestCarIcon!;
      googleMapMarkers.add(Marker(
          markerId: MarkerId('nearestCar-${singleRide.$1}'),
          position:
              LatLng(singleRide.$2.location.lat, singleRide.$2.location.lng),
          icon: icon));
    } */
    update();
    // log('Cars Location List: ${nearestCars.toString()}');
    // for (int i = 0; i < nearestCars.length; i++) {
    //   LatLng carLocation = nearestCars[i];
    //   googleMapMarkers.add(Marker(
    //       markerId: MarkerId('nearestCar-$i'),
    //       position: LatLng(carLocation.latitude, carLocation.longitude),
    //       icon: nearestMotorCycleIcon!));
    // }
  }

  Future<void> sendBatchRideRequests() async {
    for (final currentRide in rides) {
      // selectedRide = currentRide;
      // chainRequest = true;
      update();
      onRideNowButtonTap(showDialogue: false);
      /* if (!chainRequest) {
        AppDialogs.showErrorDialog(messageText: 'Chain is broken!');
        selectedRide = null;
        update();
        return;
      } */
    }
    _showRideOngoingDialog();
    AppDialogs.showSuccessDialog(
        messageText: 'Requests have been sent to drivers under this category.');
    await Future.delayed(const Duration(seconds: 10));
    // AppDialogs.showErrorDialog( messageText: 'No driver accepted your request unfortunately!');
    selectedRide = null;
    selectedCategory = null;
    update();
  }

  Future<void> _showRideOngoingDialog() async {
    Get.dialog(const RideOngoingDialog(), barrierDismissible: false);
  }

  void onRideTap(NearestVehicle theRide) async {
    /* if (chainRequest) {
      dynamic res = await AppDialogs.showConfirmDialog(
          messageText: 'Are you sure to break the chain request?',
          onYesTap: () async {
            Get.back(result: true);
          },
          shouldCloseDialogOnceYesTapped: false,
          onNoTap: () async {
            Get.back(result: false);
          });
      if (res is bool && !res) {
        return;
      }
    }
    chainRequest = false; */
    selectedCategory = null;
    if (selectedRide?.id == theRide.id) {
      selectedRide = null;
    } else {
      selectedRide = theRide;
    }
    update();
  }

  void onRideNowButtonTap({bool showDialogue = true}) {
    isScheduleRide
        ? AppDialogs.showActionableDialog(
            barrierDismissible: barrierDismissible.value,
            titleText: 'Request Ongoing',
            titleTextColor: AppColors.secondaryColor,
            messageText: 'Your Ride request is ongoing...',
            buttonText: 'Cancel Request',
            onTap: promptCancellation,
          )
        : AppDialogs.showScheduleRideDialog(
            barrierDismissible: barrierDismissible.value,
            titleText: 'Thank you for reserving your ride',
            messageText: 'Please select a time to schedule your ride',
            titleTextColor: AppColors.primaryColor,
            // messageText: 'Your Ride request is ongoing...',
            buttonText: 'Go Home',
            onTap: promptCancellation,
          );

    // TODO: Remove this fake data implementation

    return;
    if (selectedRide != null) {
      isLoading = true;
      final Map<String, dynamic> fromLocation = {
        'lat': pickupLocation!.latitude,
        'lng': pickupLocation!.longitude
      };
      final Map<String, dynamic> toLocation = {
        'lat': dropLocation!.latitude,
        'lng': dropLocation!.longitude
      };
      final Map<String, dynamic> from = {
        'address': pickupLocation?.address,
        'location': fromLocation
      };
      final Map<String, dynamic> to = {
        'address': dropLocation?.address,
        'location': toLocation
      };
      final Map<String, dynamic> requestBody = {
        'ride': selectedRide!.id,
        'from': from,
        'to': to,
        'luggage': '1',
      };
      if (isScheduleRide) {
        requestBody['schedule'] = true;
        requestBody['date'] = formatDateTime(
            selectedBookingTime.value, selectedBookingDate.value);
      }

      requestRide(requestBody, showDialogue);
    } else if (selectedCategory != null) {
      doActionForCategoryClick(selectedCategory!.id, true);
    }
  }

  /* Future<void> requestScheduleRide(Map<String, dynamic> requestBody) async {
    ScheduleRideResponse? response =
        await APIRepo.scheduleRidePost(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: 'No response for this operation!');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessScheduleBooking(response);
  }

  onSuccessScheduleBooking(ScheduleRideResponse response) {
    AppDialogs.showSuccessDialog(messageText: 'Success!');
  } */

  Future<void> requestRide(
      Map<String, dynamic> requestBody, bool showDialogue) async {
    // String requestBodyJson = jsonEncode(requestBody);
    ScheduleRideResponse? response = await APIRepo.requestForRide(requestBody);
    if (response == null) {
      isLoading = false;

      AppDialogs.showErrorDialog(messageText: '');
      return;
    } else if (response.error) {
      isLoading = false;

      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRequestingForRide(response, showDialogue);
  }

  onSuccessRequestingForRide(ScheduleRideResponse response, bool showDialogue) {
    // if (!chainRequest) {
    //   Get.back();
    //   Get.back();
    // }
    isLoading = false;
    requestId = response.data.id;
    rideRequest = response.data;
    update();
    if (showDialogue) {
      AppDialogs.showActionableDialog(
        barrierDismissible: barrierDismissible.value,
        titleText: 'Request Ongoing',
        titleTextColor: AppColors.secondaryColor,
        messageText: 'Your Ride request is ongoing...',
        buttonText: 'Cancel Request',
        onTap: promptCancellation,
      );
    }
  }

  void promptCancellation() async {
    // TODO: Remove this fake data implementation
    Get.back();
    Get.toNamed(AppPageNames.acceptedRequestScreen,
        arguments: AcceptedRequestScreenParameter(
            rideId: '',
            selectedCarScreenParameter: SelectCarScreenParameter(
                pickupLocation: pickupLocation!, dropLocation: dropLocation!)));
    return;
    dynamic res = await AppDialogs.showConfirmDialog(
        messageText: 'Are you sure to cancel ongoing request?',
        onYesTap: () async {
          Get.back(result: true);
        },
        onNoTap: () {
          Get.back(result: false);
        },
        shouldCloseDialogOnceYesTapped: false);
    if (res is bool && res) {
      cancelPendingRequest();
    }
  }

  Future<void> cancelPendingRequest() async {
    final Map<String, dynamic> requestBody = {
      '_id': requestId,
      'status': 'rejected'
    };
    RawAPIResponse? response = await APIRepo.cancelPendingRequest(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(messageText: response!.message);
      return;
    } else if (response.success) {
      AppDialogs.showErrorDialog(messageText: response.message);
      barrierDismissible.value = true;
      return;
    }
    log(response.toJson().toString());
    onSuccessCancellingRequest(response);
  }

  onSuccessCancellingRequest(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.message);
  }

  /* double computeMaxDistance(List<LocationModel> points, LatLng centroid) {
    double maximumDistance = 0;
    for (LocationModel point in points) {
      double dx = centroid.latitude - point.latitude;
      double dy = centroid.longitude - point.longitude;
      double distance = math.sqrt(dx * dx + dy * dy);
      if (distance > maxDistance) {
        maximumDistance = distance;
      }
    }
    log('Maximum Distance: $maximumDistance');
    return maximumDistance;
  } */

  /* double logBase(num x, num base) => math.log(x) / math.log(base);

  double getZoomLevel(double maxDistance) {
    double screenWidth = Get.width;
    double distInMeters = maxDistance * 111139;
    zoomLevel = logBase((distInMeters / (distInMeters * 256)), 2) - 1;
    log('ScreenWidth: $screenWidth\nzoomLevel: $zoomLevel');
    zoomLevel = 13;
    return zoomLevel < 0 ? 1 : zoomLevel;
  } */

  void _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SelectCarScreenParameter) {
      screenParameter = params;
      pickupLocation = screenParameter!.pickupLocation;
      dropLocation = screenParameter!.dropLocation;
      rideType = screenParameter?.rideType ?? RideType.rideNow;
      isScheduleRide = switch (screenParameter?.rideType) {
        RideType.rideNow => false,
        RideType.shareRide => true,
        RideType.carpooling => false,
        _ => false,
      };
      currentLocation = screenParameter?.currentLocation;
      // update();
    }
  }

  //===============for icon ============
  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }
  //============icon elements end===========

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

  Future<void> getPolyLines(
      /* Set<Polyline> googleMapPolyLines, */ double orLat,
      double orLong,
      double tarLat,
      double tarLong) async {
    GoogleMapPolyLinesResponse? response =
        await APIRepo.getRoutesPolyLines(orLat, orLong, tarLat, tarLong);
    if (response == null) {
      AppDialogs.showErrorDialog(messageText: 'No polyline found');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: 'No polyline found');
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
    /* googleMapPolyLines.add(Polyline(
        polylineId: PolylineId('polyLineId'),
        color: Colors.blue,
        points: [
          LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
          LatLng(dropLocation!.latitude, dropLocation!.longitude),
        ],
        width: 5)); */
    getPolyLines(
        // googleMapPolyLines,
        pickupLocation!.latitude,
        pickupLocation!.longitude,
        dropLocation!.latitude,
        dropLocation!.longitude);
    update();
  }

  void createCarsLocationIcon() async {
    nearestCarIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.nearestCar);
    nearestMotorCycleIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.nearestMotorCycle);
    update();
  }
/* 
  void openBottomSheet(BuildContext context) {
    final bottomSheet = bottomSheetFormKey.currentState?.showBottomSheet<void>(
        (BuildContext context) {
      return DraggableScrollableSheet(
          expand: false, // Set to true if you want it to expand initially
          initialChildSize:
              0.5, // Initial size as a fraction of the screen height
          minChildSize: 0.3, // Minimum size as a fraction of the screen height
          maxChildSize: 0.8,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.topLeft,
                decoration: const ShapeDecoration(
                    color: AppColors.mainBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    )),
                child: Column(
                  children: [
                    AppGaps.hGap10,
                    Container(
                      width: 60,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 3,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFA5A5A5),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: SelectCarBottomSheet(),
                    )),
                  ],
                ));
          });
    },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ));

    /* Get.bottomSheet(const SelectCarBottomSheet(),
        settings: RouteSettings(arguments: screenParameter)); */
  } */

/*   void getBottomsheetWithDelay() async {
    await Future.delayed(Duration(milliseconds: 500));
    final context = Get.context;
    if (context != null) {
      // ignore: use_build_context_synchronously
      // openBottomSheet(context);
    }
  } */

  void onRideRequestStatus(RideRequestUpdateSocketResponse data) async {
    log('ride request status socket got trigerred!');
    /* RideRequestUpdateSocketResponse response =
        RideRequestUpdateSocketResponse();
    if (data is RideRequestUpdateSocketResponse) {
      response = data;
    } */
    // log(response.toJson().toString());
    /*  if (data['status'].isNotEmpty) {
      rideRequestStatus = RideRequestStatus.toEnumValue(response.status);
      update();
    } */
    if (data.status == 'accepted') {
      // rideAccepted.value = true;
      Get.back();
      Get.toNamed(AppPageNames.acceptedRequestScreen,
          arguments: AcceptedRequestScreenParameter(
              rideId: data.ride,
              selectedCarScreenParameter: SelectCarScreenParameter(
                  pickupLocation: pickupLocation!,
                  dropLocation: dropLocation!)));
    } else {
      // rideAccepted.value = false;
      Get.back();
      // AppDialogs.showErrorDialog( messageText: 'Your Pending Request is cancelled');
    }
    log('back getting called');
    update();
    await Future.delayed(const Duration(seconds: 1));
    update();
  }
/* 
  IO.Socket socket = IO.io(
      AppConstants.appBaseURL,
      IO.OptionBuilder()
          // .setAuth(Helper.getAuthHeaderMap())
          .setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']) // for Flutter or Dart VM
          .build()); */

  /*  void _initSocket() {
    socket.on('ride_request_status', onRideRequestStatus);
    socket.onConnect((data) {
      log('Socket Connect');
      // socket.emit('load_message', <String, dynamic>{'user': chatUser.id});
    });
    socket.onConnectError((data) {
      log('data connect Error'.toString());
    });
    socket.onConnecting((data) {
      log('data Connecting'.toString());
    });
    socket.onConnectTimeout((data) {
      log('data Connect Timeout');
    });
    socket.onReconnectAttempt((data) {
      log('data Reconnect Attempt');
    });
    socket.onReconnect((data) {
      log('data Reconnect');
    });
    socket.onReconnectFailed((data) {
      log('data Reconnect Failed');
    });
    socket.onReconnectError((data) {
      log('data Reconnect Error');
    });
    socket.onError((data) {
      log('data Error');
    });
    socket.onDisconnect((data) {
      log('data Disconnect');
    });
    socket.onPing((data) {
      log('data Ping');
    });
    socket.onPong((data) {
      log('data Pong');
    });
  } */

  // StreamSubscription<RideRequestUpdateSocketResponse>? listen;

  @override
  void onInit() {
    // _initSocket();

    _getScreenParameters();
    createCarsLocationIcon();
    getNearestCarsList();
    _assignParameters();
/*     listen ??= socketController.rideRequestSocketResponse.listen((p0) {
      log(p0.toString());
      onRideRequestStatus(p0);
    }); */
    // listen?.onData(handleData);
    // listen?.onData((data) { onRideRequestStatus(data); });
/*     socketController.rideRequestSocketResponseListener?.onData(
      (data) {
        log(data.toString());
        onRideRequestStatus(data);
      },
    ); */
    rideRequestSocketResponseListener ??=
        socketController.rideRequestSocketResponse.stream.listen((p0) {
      log(p0.toString());
      // onRideRequestStatus(p0);
    }, cancelOnError: false);
    super.onInit();
  }

  @override
  void onClose() async {
    // await listen?.cancel();
    // listen = null;
    _onAsyncClose();
    super.onClose();
  }

  Future<void> _onAsyncClose() async {
    await rideRequestSocketResponseListener?.cancel();
    rideRequestSocketResponseListener = null;
  }

  /* @override
  void onClose() {
    socket.disconnect();
    socket.close();
    socket.dispose();
    // Get.reset();
    super.onClose();
  } */
}
