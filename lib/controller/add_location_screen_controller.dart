import 'dart:developer';

import 'package:car2gouser/models/core_api_responses/api_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/models/location_model.dart';
import 'package:car2gouser/models/screenParameters/add_location_save_address_as.dart';
import 'package:car2gouser/models/screenParameters/saved_location_screen_parameter.dart';
import 'package:car2gouser/models/screenParameters/select_screen_parameters.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddLocationScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  String locationID = '';
  LatLng cameraPosition = const LatLng(22.816904, 89.544045);
  double zoomLevel = 12;
  bool othersClicked = false;
  bool buttonOkay = false;
  final Set<Marker> googleMapMarkers = {};
  late GoogleMapController googleMapController;
  SavedLocationScreenParameter savedLocationScreenParameter =
      SavedLocationScreenParameter(
    locationModel: LocationModel(latitude: 0, longitude: 0),
  );
  List<SaveAddressAsTabsItem> saveAsOptions = [
    SaveAddressAsTabsItem(
        name: 'Home', icon: AppAssetImages.homeDarkSVGLogoSolid),
    SaveAddressAsTabsItem(
        name: 'Office', icon: AppAssetImages.officeDarkSVGLogoSolid),
    SaveAddressAsTabsItem(
        name: 'Other', icon: AppAssetImages.mallDarkSVGLogoSolid),
  ];
  SaveAddressAsTabsItem? selectedSaveAsOption;
  TextEditingController addressNameEditingController = TextEditingController();

  void onOptionTap(int index) {
    othersClicked = index == 2;
    buttonOkay = index != 2;
    selectedSaveAsOption = saveAsOptions[index];
    update();
  }

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    _markSelectedLocation();
  }

  void onAddLocationButtonTap() {
    if (locationID.isEmpty) {
      createNewAddress();
    } else {
      patchLocation();
    }
  }

  /*<----------- Add location from google API----------->*/

  // Future<void> addLocation() async {
  //   final Map<String, dynamic> requestBody = getRequestBody();
  //   RawAPIResponse? response = await APIRepo.addFavoriteLocation(requestBody);
  //   if (response == null) {
  //     AppDialogs.showErrorDialog(
  //         messageText: response?.message ??
  //             AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
  //     return;
  //   } else if (response.success) {
  //     AppDialogs.showErrorDialog(messageText: response.message);
  //     return;
  //   }
  //   log(response.toJson().toString());
  //   onSuccessAddingNewLocation(response);
  // }

  // onSuccessAddingNewLocation(RawAPIResponse response) {
  //   Get.back();
  //   AppDialogs.showSuccessDialog(messageText: response.message);
  // }

  Future<void> createNewAddress() async {
    final Map<String, dynamic> requestBody = getRequestBody();
    final response = await APIRepo.createNewAddress(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: response?.message ??
              AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    onSuccessAddingNewLocation(response);
  }

  onSuccessAddingNewLocation(APIResponse<void> response) {
    Get.back(result: true);
    AppDialogs.showSuccessDialog(messageText: response.message);
  }
  /*<----------- Patch location----------->*/

  // Future<void> patchLocation() async {
  //   final Map<String, dynamic> requestBody = getRequestBody();
  //   RawAPIResponse? response = await APIRepo.updateSavedLocation(requestBody);
  //   if (response == null) {
  //     AppDialogs.showErrorDialog(
  //         messageText: response?.message ??
  //             AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
  //     return;
  //   } else if (response.success) {
  //     AppDialogs.showErrorDialog(messageText: response.message);
  //     return;
  //   }
  //   log(response.toJson().toString());
  //   onSuccessUpdatingSavedLocation(response);
  // }

  // onSuccessUpdatingSavedLocation(RawAPIResponse response) {
  //   Get.back(result: true);
  //   AppDialogs.showSuccessDialog(messageText: response.message);
  // }

  Future<void> patchLocation() async {
    final Map<String, dynamic> requestBody = getRequestBody();
    final response = await APIRepo.updateSavedAddress(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: response?.message ??
              AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    onSuccessUpdatingSavedLocation(response);
  }

  onSuccessUpdatingSavedLocation(APIResponse<void> response) {
    Get.back(result: true);
    AppDialogs.showSuccessDialog(messageText: response.message);
  }

  Map<String, dynamic> getRequestBody() {
    final Map<String, dynamic> location = {
      'lat': savedLocationScreenParameter.locationModel.latitude,
      'lng': savedLocationScreenParameter.locationModel.longitude
    };
    final Map<String, dynamic> requestBody = {
      'name': selectedSaveAsOption?.name ?? 'Other',
      'address': savedLocationScreenParameter.locationModel.address,
      'location': location
    };
    if (locationID.isNotEmpty) {
      requestBody['_id'] = locationID;
    }
    if (selectedSaveAsOption?.name == 'Other') {
      requestBody['name'] = addressNameEditingController.text;
    }
    return requestBody;
  }

  void onLocationTap() async {
    dynamic result = await Get.toNamed(AppPageNames.selectLocationScreen,
        arguments: SelectLocationScreenParameters(
            locationModel: savedLocationScreenParameter.locationModel,
            screenTitle: locationID.isEmpty
                ? AppLanguageTranslation.savedLocationTransKey.toCurrentLanguage
                : AppLanguageTranslation
                    .updateLocationTransKey.toCurrentLanguage,
            showCurrentLocationButton: true));
    if (result is LocationModel) {
      savedLocationScreenParameter.locationModel = result;
      cameraPosition = LatLng(
          savedLocationScreenParameter.locationModel.latitude,
          savedLocationScreenParameter.locationModel.longitude);
      _markSelectedLocation();
      update();
    }
    buttonOkay = selectedSaveAsOption != null &&
        (selectedSaveAsOption != saveAsOptions[2] ||
            addressNameEditingController.text.isNotEmpty);
    update();
  }

  _markSelectedLocation() async {
    BitmapDescriptor selectedLocationIcon =
        await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), AppAssetImages.gpsSVG);
    googleMapMarkers.add(Marker(
        markerId: const MarkerId('selectedLocation'),
        position: LatLng(savedLocationScreenParameter.locationModel.latitude,
            savedLocationScreenParameter.locationModel.longitude),
        icon: selectedLocationIcon,
        anchor: const Offset(0.5, 0.565)));
    update();
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(cameraPosition.latitude, cameraPosition.longitude),
            zoom: zoomLevel)));
  }

/*<----------- Fetch screen navigation argument----------->*/
  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SavedLocationScreenParameter) {
      savedLocationScreenParameter = params;
      locationID = savedLocationScreenParameter.id;
      switch (params.othersText?.toLowerCase()) {
        case "home":
          onOptionTap(0);
          break;
        case "office":
          onOptionTap(1);
          break;
        default:
          onOptionTap(2);
          addressNameEditingController.text = params.othersText ?? '';
      }
      update();
      // String option = savedLocationScreenParameter.addressType;
      // if (option == 'Home') {
      //   selectedSaveAsOption = saveAsOptions[0];
      // } else if (option == 'Office') {
      //   selectedSaveAsOption = saveAsOptions[1];
      // } else if (option == 'Other') {
      //   selectedSaveAsOption = saveAsOptions[2];
      //   addressNameEditingController.text =
      //       savedLocationScreenParameter.othersText ?? '';
      //   othersClicked = true;
      // }
      // update();
    }
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameters();

    addressNameEditingController.addListener(() {
      if (selectedSaveAsOption?.name == 'Other' &&
          addressNameEditingController.text.isNotEmpty) {
        buttonOkay = true;
      } else {
        buttonOkay = false;
      }
      update();
    });
    super.onInit();
  }
}
