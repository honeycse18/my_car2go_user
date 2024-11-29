import 'dart:developer';

import 'package:car2gouser/models/api_responses/saved_location_list_response.dart';
import 'package:car2gouser/models/api_responses/t/property_find_response/location.dart';
import 'package:car2gouser/models/api_responses/t/saved_Location/address_list_response/address_list_response.dart';
import 'package:car2gouser/models/core_api_responses/api_list_response.dart';
import 'package:car2gouser/models/core_api_responses/api_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/models/location_model.dart';
import 'package:car2gouser/models/screenParameters/saved_location_screen_parameter.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:get/get.dart';

class SavedLocationsScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  String test = 'Working';
  List<SavedAddressItem> savedLocations = [];

/* <---- Add location button tap ----> */
  void onAddLocationButtonTap() async {
    await Get.toNamed(AppPageNames.addLocationScreen);
    getSavedAddressList();
  }

/* <---- Edit location button tap ----> */
  void onEditLocationButtonTap(SavedAddressItem location) async {
    dynamic res = await Get.toNamed(AppPageNames.addLocationScreen,
        arguments: SavedLocationScreenParameter(
            id: location.id,
            othersText: location.name,
            locationModel: LocationModel(
                latitude: location.location.lat,
                longitude: location.location.lng,
                address: location.address)),
        preventDuplicates: true);
    if (res is bool && true) {
      getSavedAddressList();
    }
  }

/* <---- Get save location list from API ----> */
  // Future<void> getSavedLocationList() async {
  //   SavedLocationListResponse? response = await APIRepo.getSavedLocationList();
  //   if (response == null) {
  //     APIHelper.onError(
  //         AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
  //     return;
  //   } else if (response.error) {
  //     APIHelper.onFailure(response.msg);
  //     return;
  //   }
  //   log(response.toJson().toString());
  //   onSuccessGettingSavedLocationList(response);
  // }

  // onSuccessGettingSavedLocationList(SavedLocationListResponse response) {
  //   savedLocations = response.data;
  //   update();
  // }

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
    savedLocations = response.data;
    update();
  }

/* <---- Delete button tap ----> */
  void onDeleteButtonTap(String id) {
    deleteSavedAddress(id);
  }

/* <---- Delete saved location from API ----> */
  // Future<void> deleteSavedLocation(String id) async {
  //   RawAPIResponse? response = await APIRepo.deleteSavedLocation(id: id);
  //   if (response == null) {
  //     AppDialogs.showErrorDialog(
  //         messageText:
  //             AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
  //     return;
  //   } else if (response.success) {
  //     AppDialogs.showErrorDialog(messageText: response.message);
  //     return;
  //   }
  //   log(response.toJson().toString());
  //   onSuccessDeletingSavedLocation(response);
  // }

  // onSuccessDeletingSavedLocation(RawAPIResponse response) async {
  //   await AppDialogs.showSuccessDialog(messageText: response.message);
  //   await getSavedLocationList();
  //   update();
  // }

  Future<void> deleteSavedAddress(String id) async {
    final response = await APIRepo.deleteSavedAddress(id: id);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    onSuccessDeletingSavedLocation(response);
  }

  onSuccessDeletingSavedLocation(APIResponse<RawAPIResponse> response) {
    AppDialogs.showSuccessDialog(messageText: response.message);
    getSavedAddressList();
    update();
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    getSavedAddressList();
    super.onInit();
  }
}
