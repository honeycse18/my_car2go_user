import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:car2gouser/models/location_model.dart';
import 'package:car2gouser/models/screenParameters/select_screen_parameters.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/libraries/debouncer/debouncer.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;

class SelectLocationScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  bool mapMarked = false;
  bool showCurrentLocation = true;
  String screenTitle = '';
  Position? _currentPosition;
  bool keyBoardHidden = true;

  GoogleMapController? googleMapController;
  TextEditingController locationTextEditingController = TextEditingController();
  final TextEditingController searchTextController = TextEditingController();
  FocusNode focusSearchBox = FocusNode();
  final String markerID = 'markerID';
  LocationModel? _selectedLocation;
  LocationModel? get selectedLocation => _selectedLocation;
  set selectedLocation(LocationModel? value) {
    _selectedLocation = value;
    update();
  }

  final Set<Marker> googleMapMarkers = {};

  final Placemark _pickPlaceMark = const Placemark();
  Placemark get pickPlaceMark => _pickPlaceMark;

  List<Prediction> _predictionList = [];
  Debouncer debouncer = Debouncer();
/*   final tmpData = [
    'abcde',
    'bbcde',
    'cbcde',
    'dbcde',
    'ebcde',
    'fbcde',
    'gbcde',
    'hbcde',
    'ibcde',
    'jbcde',
    'kbcde',
    'lbcde',
    'mbcde',
    'nbcde',
    'obcde'
  ]; */
  Completer<Iterable<Prediction>> searchOptions = Completer();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  bool get shouldShowConfirmLocationButton => selectedLocation != null;

/*   void getTmpSuggestedData(String query) {
    isLoading = true;
    tmpSuggestedData = Completer();
    debouncer.debounce(
      duration: const Duration(milliseconds: 700),
      onDebounce: () {
        isLoading = false;
        final result = tmpData.where(
          (element) => element.contains(query),
        );
        tmpSuggestedData.complete(result);
        update();
        log('returned from debounce');
      },
    );
    log('returned from cached');
  } */

  void getSearchLocations(
      {required String query, required BuildContext context}) {
    // isLoading = true;
    searchOptions = Completer();
    debouncer.debounce(
      duration: const Duration(milliseconds: 700),
      onDebounce: () async {
        isLoading = true;
        final options = await searchLocation(context, query);
        isLoading = false;
        if (searchOptions.isCompleted == false) {
          searchOptions.complete(options);
        }
        update();
      },
    );
  }

/*<----------- Fetch Location from API----------->*/

  Future<LatLng> fetchLocation(String placeId) async {
    const apiKey = AppConstants.googleAPIKey;
    final location = await getLatLngFromPlaceId(placeId, apiKey);
    log('Latitude: ${location['latitude']}, Longitude: ${location['longitude']}');
    return LatLng(location['latitude'], location['longitude']);
  }

  Future<Map<String, dynamic>> getLatLngFromPlaceId(
      String placeId, String apiKey) async {
    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final location = data['result']['geometry']['location'];
      double lat = location['lat'];
      double lng = location['lng'];
      return {'latitude': lat, 'longitude': lng};
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  /*<----------- Get location data from Google API ----------->*/

  Future<http.Response> getLocationData(String text) async {
    http.Response response;

    response = await http.get(
      Uri.parse(
          "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=${AppConstants.googleAPIKey}&input=$text"),
      headers: {"Content-Type": "application/json"},
    );

    log(response.toString());
    return response;
  }
  /*<----------- Search location from API ----------->*/

  Future<List<Prediction>> searchLocation(
      BuildContext context, String? text) async {
    if (text != null && text.isNotEmpty) {
      try {
        http.Response response = await getLocationData(text);
        var data = jsonDecode(response.body.toString());
        log('my status is ${data["status"]}');
        if (data['status'] == 'OK') {
          _predictionList = [];
          data['predictions'].forEach((prediction) =>
              _predictionList.add(Prediction.fromJson(prediction)));
        } else {
          log('No predictions found!');
        }
      } catch (e) {
        log(e.toString());
        _predictionList = [];
        return _predictionList;
      }
    }
    return _predictionList;
  }

  /*<----------- Set location from API ----------->*/

  void setLocation(String placeID, String description,
      GoogleMapController? mapController) async {
    locationTextEditingController.text = description;
    googleMapController = mapController;
    LatLng latLng = await fetchLocation(placeID);
    update();
    onGoogleMapTap(latLng, address: description);
  }

  /*<----------- This section used for polyline on google map----------->*/
  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;

    if (selectedLocation != null) {
      onGoogleMapTap(
          LatLng(selectedLocation?.latitude ?? 0,
              selectedLocation?.longitude ?? 0),
          address: selectedLocation?.address ?? 'No Location');
    }
  }

  void onGoogleMapTap(LatLng latLng, {String? address}) async {
    _focusLocation(latitude: latLng.latitude, longitude: latLng.longitude);
    if (address == null) {
      address = await latLngToAddress(latLng.latitude, latLng.longitude);
    } else {
      address = address;
    }
    locationTextEditingController.text = address;
    update();
    selectedLocation = LocationModel(
        latitude: latLng.latitude,
        longitude: latLng.longitude,
        address: address);
  }

  Future<void> _focusLocation(
      {required double latitude, required double longitude}) async {
    final LatLng latLng = LatLng(latitude, longitude);
    if (googleMapController == null) {
      return;
    }
    _addMarker(latLng);
    final double zoomLevel = await googleMapController!.getZoomLevel();
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        AppSingleton.instance.defaultCameraPosition =
            CameraPosition(target: latLng, zoom: zoomLevel)));
    update();
  }

  Future<void> _addMarker(LatLng latLng) async {
    googleMapMarkers
        .add(Marker(markerId: MarkerId(markerID), position: latLng));
    mapMarked = true;
    update();
  }

  Future<String> latLngToAddress(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      final placemark = placemarks.firstOrNull;
      if (placemark == null) {
        return '';
      }
      String? street = placemark.street;
      String? locality = placemark.locality;
      String? country = placemark.country;
      return '$street, $locality, $country';
    } catch (e) {
      log(e.toString());
      return 'Null Address';
    }
  }
/* <---- Confirm location button tap ----> */

  void onConfirmLocationButtonTap() async {
    final result = await AppDialogs.showConfirmDialog(
      shouldCloseDialogOnceYesTapped: false,
      titleText: AppLanguageTranslation.confirmTransKey.toCurrentLanguage,
      messageText: AppLanguageTranslation
          .doYouWantToConfirmthisLocationTranskey.toCurrentLanguage,
      onYesTap: () async {
        Get.back(result: true);
      },
    );
    if (result is bool && result) {
      Get.back(result: selectedLocation);
    }
  }
  /*<----------- Get current position from API ----------->*/

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
      locationTextEditingController.text = await latLngToAddress(
          _currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0);
      _focusLocation(
          latitude: _currentPosition?.latitude ?? 0,
          longitude: _currentPosition?.longitude ?? 0);
      selectedLocation = LocationModel(
          address: locationTextEditingController.text,
          latitude: _currentPosition?.latitude ?? 0,
          longitude: _currentPosition?.longitude ?? 0);
      selectedLocation = selectedLocation;
      update();
    } on Exception catch (e) {
      log(e.toString());
    }
  }
  /*<----------- Handle location permission from API----------->*/

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
            AppLanguageTranslation
                .locationServiceDisabledTranskey.toCurrentLanguage,
            AppLanguageTranslation
                .locationServiceAreDisabledEnableServiceTranskey
                .toCurrentLanguage);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
          AppLanguageTranslation.locationPermissionTranskey.toCurrentLanguage,
          AppLanguageTranslation
              .permissionsPermanentlyDeniedCannotrequestTranskey
              .toCurrentLanguage);
      return false;
    }
    return true;
  }
/*<----------- Fetch screen navigation argument----------->*/

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SelectLocationScreenParameters) {
      showCurrentLocation = params.showCurrentLocationButton ?? true;
      screenTitle = params.screenTitle ??
          AppLanguageTranslation.selectAddressTransKey.toCurrentLanguage;
      selectedLocation =
          params.locationModel?.latitude != 0 ? params.locationModel : null;

      update();
    }
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameters();
    // searchTextController.addListener(() {
    //   log(searchTextController.text);
    // });
    focusSearchBox.addListener(
      () {
        try {
          if (focusSearchBox.hasFocus == false) {
            if (searchOptions.isCompleted == false) {
              searchOptions.complete([]);
            }
          }
        } catch (e) {
          log(e.toString());
        }
      },
    );
    super.onInit();
  }

  @override
  void onClose() {
    googleMapMarkers.clear();
    selectedLocation = null;
    googleMapController?.dispose();
    locationTextEditingController.dispose();
    debouncer.cancel();
    focusSearchBox.dispose();

    super.onClose();
  }
}
