import 'dart:developer';
import 'dart:ui' as ui;

import 'package:car2gouser/models/api_responses/dashboard_police_response.dart';
import 'package:car2gouser/models/api_responses/profile_details.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  PoliceData policeData = PoliceData.empty();
  RxBool isTapped = false.obs;
  bool status = true;
  GoogleMapController? myMapController;
  final String userMarkerID = 'userID';
  final String markerID = 'markerID';
  Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  GoogleMapController? googleMapController;
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolylines = {};
  GoogleMapController? mapController;
  LatLng myLatLng = const LatLng(0, 0);
  ProfileDetails userDetailsData = ProfileDetails.empty();

  BitmapDescriptor? myCarIcon;

  void onGoogleMapTap(LatLng latLng) async {
    _focusLocation(latitude: latLng.latitude, longitude: latLng.longitude);
  }

  late Location location;
  Rx<LatLng> userLocation = Rx<LatLng>(const LatLng(0.0, 0.0));

  /*<-----------  Function to request location permission----------->*/

  Future<void> _requestPermission() async {
    final hasPermission = await location.hasPermission();
    if (hasPermission == PermissionStatus.denied) {
      await location.requestPermission();
    }
  }
  /*<----------- Get current location from API ----------->*/

  Future<LocationData?> getCurrentLocation() async {
    try {
      final LocationData myCurrentLocation = await location.getLocation();
      myLatLng = LatLng(
        myCurrentLocation.latitude!,
        myCurrentLocation.longitude!,
      );
      userLocation.value = myLatLng;
      _focusLocation(
          latitude: myLatLng.latitude,
          longitude: myLatLng.longitude,
          showRiderLocation: true);

      log('${myLatLng.latitude}');
      return myCurrentLocation;
    } catch (e) {
      log('Error getting location: $e');
      return null;
    }
  }
  /*<----------- Focus location on Map----------->*/

  Future<void> _focusLocation(
      {required double latitude,
      required double longitude,
      bool showRiderLocation = false}) async {
    final latLng = LatLng(latitude, longitude);
    if (googleMapController == null) {
      return;
    }
    if (showRiderLocation) {
      _addTapMarker(latLng);
    } else {
      _addMarker(latLng);
    }
    final double zoomLevel = await googleMapController!.getZoomLevel();
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: zoomLevel)));
    AppSingleton.instance.defaultCameraPosition =
        CameraPosition(target: latLng, zoom: zoomLevel);
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

  Future<void> _addMarker(LatLng latLng) async {
    final context = Get.context;
    if (context != null) {}

    googleMapMarkers.add(Marker(
        markerId: MarkerId(markerID), position: latLng, icon: myCarIcon!));
  }

  void createCarsLocationIcon() async {
    int aspectSize = (Get.context!.devicePixelRatio * 30).toInt();
    final Uint8List? markerIcon = await getBytesFromAsset(
        AppAssetImages.selectedLocationPNGImage, aspectSize);
    if (markerIcon != null) {
      myCarIcon = BitmapDescriptor.fromBytes(markerIcon);
    }

    update();
  }

  /// onTap take location event on map
  Future<void> _addTapMarker(LatLng latLng) async {
    final context = Get.context;
    if (context != null) {}
    googleMapMarkers.add(Marker(
        markerId: MarkerId(userMarkerID),
        anchor: const Offset(0.5, 0.5),
        position: latLng,
        icon: myCarIcon!));
  }

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }
  /*<----------- Get dashboard emergency data details ----------->*/

  Future<void> getDashBoardEmergencyDataDetails() async {
    DashboardEmergencyDataResponse? response =
        await APIRepo.getDashBoardEmergencyDataDetails();
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    _onSuccessGetDashBoardEmergencyData(response);
  }

  void _onSuccessGetDashBoardEmergencyData(
      DashboardEmergencyDataResponse response) async {
    policeData = response.data;
    update();
  }

  /*<----------- Get user details----------->*/

  Future<void> getUserDetails() async {
    final response = await APIRepo.getProfileUpdated();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForUserLoginDetailsTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      Helper.logout();
      APIHelper.onFailure(
        AppLanguageTranslation.sessionExpiredTranskey.toCurrentLanguage,
      );
      return;
    }
  }
  /* <---- Initial state ----> */

  @override
  void onInit() {
    getUserDetails();
    getDashBoardEmergencyDataDetails();
    location = Location();
    getCurrentLocation();

    super.onInit();
    userDetailsData = Helper.getUser();

    _requestPermission();
    createCarsLocationIcon();
  }
}
