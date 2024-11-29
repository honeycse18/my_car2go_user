import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:car2gouser/controller/socket_controller.dart';
import 'package:car2gouser/models/api_responses/google_map_poly_lines_response.dart';
import 'package:car2gouser/models/api_responses/pooling_new_request_socket_response.dart';
import 'package:car2gouser/models/api_responses/pooling_request_status_socket_response.dart';
import 'package:car2gouser/models/api_responses/pulling_request_details_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/models/location_model.dart';
import 'package:car2gouser/models/screenParameters/submit_review_screen_parameter.dart';
import 'package:car2gouser/screens/bottomsheet_screen/choose_reason_ride_cancel_bottomsheet.dart';
import 'package:car2gouser/screens/bottomsheet_screen/submit_review_bottomSheet.dart';
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

class PullingRequestDetailsScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  StreamSubscription<PoolingNewRequestSocketResponse>? listen;
  StreamSubscription<PoolingRequestStatusSocketResponse>? listen2;
  String test = 'screen controller is connected!';
  int totalSeat = 0;
  String otp = '';
  RxBool pickUpPassengers = false.obs;
  late SocketController homeSocketScreenController;
  LocationModel pickupLocation = LocationModel.empty();
  LocationModel dropLocation = LocationModel.empty();
  final GlobalKey<ScaffoldState> bottomSheetFormKey =
      GlobalKey<ScaffoldState>();
  BitmapDescriptor? nearestCarIcon;
  BitmapDescriptor? nearestMotorCycleIcon;
  String requestId = '';
  String type = 'passenger';
  PullingRequestDetailsData requestDetails = PullingRequestDetailsData.empty();
  BitmapDescriptor pickUpIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropUpIcon = BitmapDescriptor.defaultMarker;

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
  PoolingNewRequestSocketResponse newRequestOfferId =
      PoolingNewRequestSocketResponse();
  PoolingRequestStatusSocketResponse requestStatusSocketResponse =
      PoolingRequestStatusSocketResponse();

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
/* <---- Make payment tap ----> */

  void onMakePaymentTap() async {
    await AppDialogs.showConfirmPaymentDialog(
        amount: requestDetails.rate * requestDetails.seats.toDouble(),
        symbol: requestDetails.currency.symbol,
        titleText: 'Payment Confirmation ',
        totalAmount: requestDetails.rate * requestDetails.seats.toDouble(),
        noButtonText: 'Cancel',
        yesButtonText: 'Confirm To Pay',
        onYesTap: () async {
          await Get.toNamed(AppPageNames.selectPaymentMethodsScreen,
              arguments: requestDetails.id);
        },
        onNoTap: () {
          Get.back();
        });
  }
/* <---- Review button tap ----> */

  void reviewButtonTap() {
    Get.bottomSheet(const SubmitReviewBottomSheetScreen(),
        settings: RouteSettings(
            arguments: SubmitReviewScreenParameter(
                id: requestDetails.id, type: 'pulling_request')));
  }
/* <---- Cancel trip button tap ----> */

  void onCancelTripButtonTap() async {
    log('Cancel Button got Tapped!');
    dynamic res =
        await Get.bottomSheet(const ChooseReasonCancelRideBottomSheet());
    if (res is String) {
      cancelRide(res);
    }
    getRequestDetails();
  }
/* <---- Cancel ride----> */

  Future<void> cancelRide(String reason) async {
    RawAPIResponse? response = await APIRepo.updateShareRideRequest(
        requestId: requestId, action: 'cancelled', reason: reason);
    if (response == null) {
      Helper.showSnackBar('No response found for this action!');
      return;
    } else if (response.success) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    log(response.toJson().toString());
    onSuccessCancellingRide(response);
  }

  onSuccessCancellingRide(RawAPIResponse response) {
    AppDialogs.showSuccessDialog(messageText: 'Ride cancelled successfully!');
    getRequestDetails();
  }
/* <---- Get request details from API ----> */

  Future<void> getRequestDetails() async {
    PoolingRequestDetailsResponse? response =
        await APIRepo.getPoolingRequestDetails(requestId);
    if (response == null) {
      APIHelper.onError('No response found for this action!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRequestDetails(response);
  }

  onSuccessRetrievingRequestDetails(PoolingRequestDetailsResponse response) {
    requestDetails = response.data;
    otp = requestDetails.otp;
    update();
    _assignParameters();
  }
/*<----------- Fetch screen navigation argument----------->*/

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      requestId = params;
      // type = params.type;
      // totalSeat = params.seat;
      update();
      if (requestId.isNotEmpty) {
        getRequestDetails();
      }
    }
  }

  /* <---- Get bytes from asset from API ----> */

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
      APIHelper.onError('No PolyLines found for this route!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(
          AppLanguageTranslation.errorHappenedTransKey.toCurrentLanguage);
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
        position: LatLng(pickupLocation.latitude, pickupLocation.longitude),
        icon: pickUpIcon));
    googleMapMarkers.add(Marker(
        markerId: MarkerId(dropMarkerId),
        position: LatLng(dropLocation.latitude, dropLocation.longitude),
        icon: dropUpIcon));
  }

  _assignParameters() async {
    _addPickUpAndDropMarkers();
    pickupLocation = LocationModel(
        address: requestDetails.offer.from.address,
        latitude: requestDetails.offer.from.location.lat,
        longitude: requestDetails.offer.from.location.lng);
    dropLocation = LocationModel(
        latitude: requestDetails.offer.to.location.lat,
        longitude: requestDetails.offer.to.location.lng,
        address: requestDetails.offer.to.address);
    update();
    getPolyLines(
        // googleMapPolyLines,
        pickupLocation.latitude,
        pickupLocation.longitude,
        dropLocation.latitude,
        dropLocation.longitude);
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
  /*<-----------Get socket response for new pooling request ----------->*/

  dynamic onNewPoolingRequest(dynamic data) async {
    if (data is PoolingNewRequestSocketResponse) {
      newRequestOfferId = data;
      update();
      if (newRequestOfferId.offer.isNotEmpty) {
        Helper.showSnackBar('Your offer has a new request.');
      }
    }
  }
  /*<-----------Get socket response for pooling request status update ----------->*/

  dynamic onPoolingRequestStatusUpdate(dynamic data) async {
    if (data is PoolingRequestStatusSocketResponse) {
      requestStatusSocketResponse = data;
      update();
      if (requestStatusSocketResponse.status.isNotEmpty) {
        if (requestId == requestStatusSocketResponse.request) {
          getRequestDetails();
        }
      }
    }
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameters();

    SocketController socketController = Get.find<SocketController>();

    if (listen == null) {
      listen = socketController.pullingRequestResponseData.listen((p0) {});
      listen?.onData((data) {
        onNewPoolingRequest(data);
      });
    }
    if (listen2 == null) {
      listen2 =
          socketController.pullingRequestStatusResponseData.listen((p0) {});
      listen2?.onData((data) {
        onPoolingRequestStatusUpdate(data);
      });
    }
    super.onInit();
  }

  void popScope() {
    listen?.cancel();
    listen2?.cancel();
  }

  @override
  void onClose() {
    dispose();
    listen?.cancel();
    listen2?.cancel();
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
