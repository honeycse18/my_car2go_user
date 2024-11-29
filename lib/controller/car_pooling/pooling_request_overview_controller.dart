import 'dart:developer';
import 'dart:ui' as ui;
import 'package:car2gouser/controller/socket_controller.dart';
import 'package:car2gouser/models/api_responses/carpolling/pulling_offer_details_response.dart';
import 'package:car2gouser/models/api_responses/google_map_poly_lines_response.dart';
import 'package:car2gouser/models/location_model.dart';
import 'package:car2gouser/models/screenParameters/choose_you_need_screen_parameter.dart';
import 'package:car2gouser/screens/car_pooling/request_ride_bottomsheet_screen.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PullingRequestOverviewController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  int totalseat = 0;
  String otp = '';
  // late SocketController homeSocketScreenController;
  LocationModel pickupLocation = LocationModel.empty();
  LocationModel dropLocation = LocationModel.empty();
  final GlobalKey<ScaffoldState> bottomSheetFormKey =
      GlobalKey<ScaffoldState>();
  BitmapDescriptor? nearestCarIcon;
  BitmapDescriptor? nearestMotorCycleIcon;
  String requestId = '';
  String type = 'passenger';
  PullingOfferDetailsData requestDetails = PullingOfferDetailsData.empty();

  final pickupMarkerId = 'pickUpMarkerId';
  final dropMarkerId = 'dropMarkerId';
  late GoogleMapController googleMapController;
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolyLines = {};
  LatLng cameraPosition = const LatLng(0, 0);
  final List<LocationModel> polyLinePoints = [];
  double zoomLevel = 12;
  double maxDistance = 0;
  BitmapDescriptor pickUpIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor dropUpIcon = BitmapDescriptor.defaultMarker;

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

  void onRequestRideButtonTap() {
    Get.bottomSheet(const RequestRideBottomsheet(),
        settings: RouteSettings(
          arguments: OfferOverViewBottomsheetScreenParameters(
              requestDetails: requestDetails, type: type, seat: totalseat),
        ),
        isScrollControlled: true);
  }

/*<-----------Get request details from API ----------->*/
  Future<void> getRequestDetails() async {
    PoolingOfferDetailsResponse? response =
        await APIRepo.getPoolingOfferDetails(requestId);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseFromServerTryAgainTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRequestDetails(response);
  }

  onSuccessRetrievingRequestDetails(PoolingOfferDetailsResponse response) {
    requestDetails = response.data;
    update();
    _assignParameters();
  }
/*<----------- Fetch screen navigation argument----------->*/

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is OfferOverViewScreenParameters) {
      requestId = params.id;
      type = params.type;
      totalseat = params.seat;
      update();
      if (requestId.isNotEmpty) {
        getRequestDetails();
      }
    }
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

  /*<-----------Get polylines from google API ----------->*/
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
        address: requestDetails.from.address,
        latitude: requestDetails.from.location.lat,
        longitude: requestDetails.from.location.lng);
    dropLocation = LocationModel(
        latitude: requestDetails.to.location.lat,
        longitude: requestDetails.to.location.lng,
        address: requestDetails.to.address);
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
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameters();

    super.onInit();
  }

  @override
  void onClose() {
    dispose();
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
