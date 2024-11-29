import 'dart:developer';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:car2gouser/models/api_responses/commons/location_position.dart';
import 'package:car2gouser/models/api_responses/recent_location_response.dart';
import 'package:car2gouser/models/api_responses/saved_location_list_response.dart';
import 'package:car2gouser/models/api_responses/t/saved_Location/address_list_response/address_list_response.dart';
import 'package:car2gouser/models/core_api_responses/api_list_response.dart';
import 'package:car2gouser/models/core_api_responses/api_response.dart';
import 'package:car2gouser/models/enums/ride_type.dart';
import 'package:car2gouser/models/location_model.dart';
import 'package:car2gouser/models/screenParameters/select_car_screen_parameter.dart';
import 'package:car2gouser/models/screenParameters/select_screen_parameters.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickedLocationScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  GoogleMapController? googleMapController;
  bool mapMarked = false;
  bool isScheduleRide = false;
  // List<SavedLocationListSingleLocation> savedLocations = [];
  List<SavedAddressItem> savedLocations = [];
  List<RecentLocationsData> recentLocations = [];
  final String riderMarkerID = 'riderID';
  final String markerID = 'markerID';
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolylines = {};
  TextEditingController pickUpLocationTextController = TextEditingController();
  TextEditingController dropLocationTextController = TextEditingController();
  LocationModel? selectedLocation;
  LocationModel? pickUpLocation;
  LocationModel? dropLocation;
  FocusNode pickUpLocationFocusNode = FocusNode();
  FocusNode dropLocationFocusNode = FocusNode();
  bool pickFocusFirst = true;
  bool dropFocusFirst = true;
  Position? _currentPosition;
  String pickUpSearch = '';
  String dropSearch = '';
  DateTime? selectedDate;

  void showDatePicker(BuildContext context) {
    BottomPicker.date(
      minDateTime: DateTime.now(),
      maxDateTime: DateTime.now().add(const Duration(days: 366)),
      dismissable: false,
      buttonSingleColor: AppColors.primaryColor,
      buttonWidth: MediaQuery.of(context).size.width * 0.85,
      buttonContent: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppGaps.hGap5,
          Text(
            'Confirm Date',
            style: AppTextStyles.bodyLargeSemiboldTextStyle
                .copyWith(color: Colors.white),
          ),
          AppGaps.hGap5,
        ],
      ),
      pickerTitle: const Text(
        'Schedule Ride',
        style: AppTextStyles.bodyLargeSemiboldTextStyle,
      ),
      onSubmit: (date) {
        selectedDate = date;
        // onLocateOnMapButtonTap();
        log(selectedDate.toString());
        navigateToSelectCarScreen();
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }

  Future<void> navigateToSelectCarScreen() async {
    await Future.delayed(const Duration(milliseconds: 200));
    hideKeyBoard();
    final currentLocation = await _getCurrentLocationPosition(Get.context!);
    if (currentLocation == null) {
      AppDialogs.showErrorDialog(
          messageText: 'Please allow location permission or turn on your GPS');
      return;
    }
    await Get.toNamed(AppPageNames.selectCarScreen,
        arguments: SelectCarScreenParameter(
            pickupLocation: pickUpLocation!,
            dropLocation: dropLocation!,
            rideType: isScheduleRide ? RideType.shareRide : RideType.rideNow,
            selectedDate: selectedDate,
            currentLocation: LocationPosition(
                lat: currentLocation.latitude,
                lng: currentLocation.longitude)));
  }

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }
/* <---- Focus camera on google map using lat lng ----> */

  Future<void> _focusLocation(
      {required double latitude,
      required double longitude,
      bool showRiderLocation = false}) async {
    final latLng = LatLng(latitude, longitude);
    if (googleMapController == null) {
      return;
    }
    if (showRiderLocation) {
      _addRiderMarker(latLng);
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

  void onGoogleMapTap(LatLng latLng) async {
    _focusLocation(latitude: latLng.latitude, longitude: latLng.longitude);
    String address = await latLongToAddressWithoutController(
        latLng.latitude, latLng.longitude);
    selectedLocation = LocationModel(
        address: address,
        latitude: latLng.latitude,
        longitude: latLng.longitude);
  }
/* <---- Add rider marker ----> */

  Future<void> _addRiderMarker(LatLng latLng) async {
    BitmapDescriptor? gpsIcon;
    final context = Get.context;
    if (context != null) {
      final ImageConfiguration config = createLocalImageConfiguration(context);
      gpsIcon = await BitmapDescriptor.fromAssetImage(
          config, AppAssetImages.riderGPSImage);
    }
    googleMapMarkers.add(Marker(
        markerId: MarkerId(riderMarkerID),
        anchor: const Offset(0.5, 0.5),
        position: latLng,
        icon: gpsIcon ?? BitmapDescriptor.defaultMarker));
  }

  Future<void> _addMarker(LatLng latLng) async {
    googleMapMarkers
        .add(Marker(markerId: MarkerId(markerID), position: latLng));
    mapMarked = true;
    update();
  }
/* <---- Get Current position ----> */

  void getCurrentPosition(BuildContext context) {
    _getCurrentPosition(context);
  }

  Future<void> _getCurrentPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) {
      log('No permission acquired!');
      return;
    }
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _currentPosition?.toJson();
      pickUpLocationTextController.text =
          await latLongToAddressWithoutController(
              _currentPosition?.latitude ?? 0,
              _currentPosition?.longitude ?? 0);
      selectedLocation = LocationModel(
          address: pickUpLocationTextController.text,
          latitude: _currentPosition?.latitude ?? 0,
          longitude: _currentPosition?.longitude ?? 0);
      pickUpLocation = selectedLocation;
      update();
      if (dropLocationTextController.text.isEmpty) {
        dropLocationFocusNode.requestFocus();
        hideKeyBoard();
        update();
      } else {
        /* Get.toNamed(AppPageNames.selectCarScreen,
            arguments: SelectCarScreenParameter(
                pickupLocation: pickUpLocation!,
                dropLocation: dropLocation!,
                isScheduleRide: isScheduleRide));
        log('Initiate next process from currentLocation Tap'); */
        if (isScheduleRide) {
          showDatePicker(Get.context!);
        } else {
          navigateToSelectCarScreen();
        }
        log('Initiate next process from pickupLocation');
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<Position?> _getCurrentLocationPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) {
      log('No permission acquired!');
      return null;
    }
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
/* <---- Handle location permission ----> */

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
          AppLanguageTranslation
              .locationServiceDisabledTranskey.toCurrentLanguage,
          AppLanguageTranslation.locationServiceAreDisabledEnableServiceTranskey
              .toCurrentLanguage);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
            AppLanguageTranslation.locationDeniedTransKey.toCurrentLanguage,
            AppLanguageTranslation
                .locationPermissionDeniedTranskey.toCurrentLanguage);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
          AppLanguageTranslation
              .locationDeniedForeverTransKey.toCurrentLanguage,
          AppLanguageTranslation
              .permissionsPermanentlyDeniedCannotrequestTranskey
              .toCurrentLanguage);
      return false;
    }
    return true;
  }

  Future<String> latLongToAddressWithoutController(
      double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    final placemark = placemarks.firstOrNull;
    if (placemark == null) {
      return '';
    }
    String? street = placemark.street;
    String? locality = placemark.locality;
    String? country = placemark.country;
    return '$street, $locality, $country';
  }

  void onLocateOnMapButtonTap() async {
    if (pickUpLocationFocusNode.hasFocus) {
      dynamic res = await Get.toNamed(AppPageNames.selectLocationScreen,
          arguments: SelectLocationScreenParameters(
              locationModel:
                  pickUpLocation ?? LocationModel(latitude: 0, longitude: 0),
              showCurrentLocationButton: true,
              screenTitle: AppLanguageTranslation
                  .selectPickupLocationTransKey.toCurrentLanguage));
      if (res is LocationModel) {
        selectedLocation = res;
        pickUpLocation = res;
        pickUpLocationTextController.text = res.address;
        update();
        if (dropLocationTextController.text.isEmpty) {
          dropLocationFocusNode.requestFocus();
        } else {
          /* Get.toNamed(AppPageNames.selectCarScreen,
              arguments: SelectCarScreenParameter(
                  pickupLocation: pickUpLocation!,
                  dropLocation: dropLocation!,
                  isScheduleRide: isScheduleRide)); */
          if (isScheduleRide) {
            showDatePicker(Get.context!);
          } else {
            navigateToSelectCarScreen();
          }
          log('Initiate next process from pickupLocation');
        }
      }
    } else if (dropLocationFocusNode.hasFocus) {
      dynamic res = await Get.toNamed(AppPageNames.selectLocationScreen,
          arguments: SelectLocationScreenParameters(
              locationModel:
                  dropLocation ?? LocationModel(latitude: 0, longitude: 0),
              showCurrentLocationButton: false,
              screenTitle: AppLanguageTranslation
                  .selectDropLocationTransKey.toCurrentLanguage));
      if (res is LocationModel) {
        selectedLocation = res;
        dropLocation = res;
        dropLocationTextController.text = res.address;
        update();
        if (pickUpLocationTextController.text.isEmpty) {
          pickUpLocationFocusNode.requestFocus();
        } else {
          /* Get.toNamed(AppPageNames.selectCarScreen,
              arguments: SelectCarScreenParameter(
                  pickupLocation: pickUpLocation!,
                  dropLocation: dropLocation!,
                  isScheduleRide: isScheduleRide)); */
          if (isScheduleRide) {
            showDatePicker(Get.context!);
          } else {
            navigateToSelectCarScreen();
          }
          log('Initiate next process from pickupLocation');
        }
      }
    } else {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .pleaseFocusOnAFieldFirstTransKey.toCurrentLanguage);
      return;
    }
    update();
  }

  void onFocusChange() {
    if (pickFocusFirst && pickUpLocationFocusNode.hasFocus) {
      hideKeyBoard();
      pickFocusFirst = false;
    } else if (dropFocusFirst && dropLocationFocusNode.hasFocus) {
      hideKeyBoard();
      dropFocusFirst = false;
    } else {
      pickFocusFirst = true;
      dropFocusFirst = true;
    }
    onLocateOnMapButtonTap();
  }

  void onConfirmLocationButtonTap() {
    log('Confirm Location Button got tapped!');
    if (pickUpLocationFocusNode.hasFocus) {
      pickUpLocationTextController.text = selectedLocation?.address ?? '';
      pickUpLocation = selectedLocation;
      update();
      if (dropLocationTextController.text.isEmpty) {
        dropLocationFocusNode.requestFocus();
        hideKeyBoard();
        update();
      } else {
        /* Get.toNamed(AppPageNames.selectCarScreen,
            arguments: SelectCarScreenParameter(
                pickupLocation: pickUpLocation!,
                dropLocation: dropLocation!,
                isScheduleRide: isScheduleRide));
        log('Initiate next process from pickupLocation'); */
        if (isScheduleRide) {
          showDatePicker(Get.context!);
        } else {
          navigateToSelectCarScreen();
        }
        log('Initiate next process from pickupLocation');
      }
    } else if (dropLocationFocusNode.hasFocus) {
      /* latLongToAddress(
          googleMapMarkers.first.position.latitude,
          googleMapMarkers.first.position.longitude,
          dropLocationTextController); */
      dropLocationTextController.text = selectedLocation?.address ?? '';
      dropLocation = selectedLocation;
      update();
      if (pickUpLocationTextController.text.isEmpty) {
        pickUpLocationFocusNode.requestFocus();
        hideKeyBoard();
        update();
      } else {
        /* Get.toNamed(AppPageNames.selectCarScreen,
            arguments: SelectCarScreenParameter(
                pickupLocation: pickUpLocation!,
                dropLocation: dropLocation!,
                isScheduleRide: isScheduleRide));
        log('Initiate next process from dropLocation'); */
        if (isScheduleRide) {
          showDatePicker(Get.context!);
        } else {
          navigateToSelectCarScreen();
        }
        log('Initiate next process from pickupLocation');
      }
    } else {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .pleaseFocusOnAFieldFirstTransKey.toCurrentLanguage);
    }
  }

/* <---- Get saved location list from API----> */

  Future<void> getSavedAddressList({String? search}) async {
    final response = await APIRepo.getSavedAddressList(
        queries:
            search != null && search.isNotEmpty ? {'search': search} : null);
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    onSuccessGettingSavedLocationList(response);
  }

  onSuccessGettingSavedLocationList(
      APIListResponse<SavedAddressItem> response) async {
    // await AppDialogs.showSuccessDialog(messageText: response.message);
    // await getSavedAddressList();
    savedLocations = response.data;
    update();
  }
/* <---- Get recent location list from API----> */

  Future<void> getRecentLocationList({String? search}) async {
    RecentLocationResponse? response =
        await APIRepo.getRecentLocationList(search: search);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForThisActionTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingRecentLocationList(response);
  }

  onSuccessGettingRecentLocationList(RecentLocationResponse response) {
    recentLocations = response.data;
    update();
  }
/* <---- Saved location tap----> */

  void onSavedLocationTap(dynamic location) {
    double latitude = 0;
    double longitude = 0;
    String address = '';
    if (location is SavedAddressItem) {
      latitude = location.location.lat;
      longitude = location.location.lng;
      address = location.address;
    } else if (location is RecentLocationsData) {
      latitude = location.location.lat;
      longitude = location.location.lng;
      address = location.address;
    }
    if (pickUpLocationFocusNode.hasFocus) {
    } else if (dropLocationFocusNode.hasFocus) {}
    if (pickUpLocationFocusNode.hasFocus) {
      pickUpLocation = LocationModel(
          latitude: latitude, longitude: longitude, address: address);
      pickUpLocationTextController.text = address;
      if (dropLocationTextController.text.isEmpty) {
        dropLocationFocusNode.requestFocus();
        hideKeyBoard();
      } else {
        /* Get.toNamed(AppPageNames.selectCarScreen,
            arguments: SelectCarScreenParameter(
                pickupLocation: pickUpLocation!,
                dropLocation: dropLocation!,
                isScheduleRide: isScheduleRide)); */
        if (isScheduleRide) {
          showDatePicker(Get.context!);
        } else {
          navigateToSelectCarScreen();
        }
        log('Initiate next process from pickupLocation');
      }
    } else if (dropLocationFocusNode.hasFocus) {
      dropLocation = LocationModel(
          latitude: latitude, longitude: longitude, address: address);
      dropLocationTextController.text = address;
      if (pickUpLocationTextController.text.isEmpty) {
        pickUpLocationFocusNode.requestFocus();
        hideKeyBoard();
        update();
      } else {
        /* Get.toNamed(AppPageNames.selectCarScreen,
            arguments: SelectCarScreenParameter(
                pickupLocation: pickUpLocation!,
                dropLocation: dropLocation!,
                isScheduleRide: isScheduleRide)); */
        if (isScheduleRide) {
          showDatePicker(Get.context!);
        } else {
          navigateToSelectCarScreen();
        }
        log('Initiate next process from pickupLocation');
      }
    } else {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .pleaseFocusOnAFieldFirstTransKey.toCurrentLanguage);
    }
    update();
  }

  void hideKeyBoard() {
    Future.delayed(
      const Duration(milliseconds: 0),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
  }
/*<----------- Fetch screen navigation argument----------->*/

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is bool) {
      isScheduleRide = params;
      update();
    }
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameters();
    pickUpLocationFocusNode.requestFocus();
    hideKeyBoard();

    pickUpLocationFocusNode.addListener(() {
      if (pickUpLocationFocusNode.hasFocus) {
        log("PickUpLocation one got focused.");
      } else {
        log("PickUpLocation one got unfocused.");
      }
      update();
    });
    dropLocationFocusNode.addListener(() {
      if (dropLocationFocusNode.hasFocus) {
        log("DropLocation one got focused.");
      } else {
        log("DropLocation one got unfocused.");
      }
      update();
    });

    dropLocationTextController.addListener(() {
      dropSearch = dropLocationTextController.text;
      update();
      // getSavedAddressList(search: dropSearch);
      // getRecentLocationList(search: dropSearch);
    });
    pickUpLocationTextController.addListener(() {
      pickUpSearch = pickUpLocationTextController.text;
      update();
      // getSavedAddressList(search: pickUpSearch);
      // getRecentLocationList(search: pickUpSearch);
    });
    getSavedAddressList();
    // getRecentLocationList();

    super.onInit();
  }

  @override
  void onClose() {
    googleMapMarkers.clear();
    googleMapController?.dispose();
    googleMapPolylines.clear();
    super.onClose();
  }
}
