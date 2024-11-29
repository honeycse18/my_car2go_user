import 'dart:developer';

import 'package:car2gouser/models/api_responses/carpolling/all_categories_response.dart';
import 'package:car2gouser/models/api_responses/carpolling/pulling_offer_details_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/models/screenParameters/choose_you_need_screen_parameter.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestRideBottomSheetScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  RxInt seat = 0.obs;

  PullingOfferDetailsData requestDetails = PullingOfferDetailsData.empty();
  RxDouble rate = 0.0.obs;
  TextEditingController vehicleNumberController = TextEditingController();
  List<AllCategoriesDoc> categories = [];
  AllCategoriesDoc? selectedCategory;
  bool type = false;

  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  void updateSelectedStartDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void updateSelectedStartTime(TimeOfDay newTime) {
    selectedTime.value = newTime;
  }

  void onRateAddTap() {
    rate.value += 1;
    update();
  }

  void onRateRemoveTap() {
    rate.value -= 1;
    update();
  }

  void onSeatAddTap() {
    seat.value += 1;
    update();
  }

  void onSeatRemoveTap() {
    seat.value -= 1;
    update();
  }

/*<-----------Request ride ----------->*/
  Future<void> requestRide() async {
    final Map<String, dynamic> requestBody = {
      '_id': requestDetails.id,
      'seats': seat.value,
      'rate': rate.value,
    };
    if (type) {
      DateTime date = selectedDate.value;
      TimeOfDay time = selectedTime.value;
      DateTime combinedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      String dateTime = Helper.timeZoneSuffixedDateTimeFormat(combinedDateTime);
      requestBody['date'] = dateTime;
      requestBody['category'] = selectedCategory?.id ?? '';
      requestBody['vehicle_number'] = vehicleNumberController.text;
    }
    RawAPIResponse? response = await APIRepo.requestRide(requestBody);
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.success) {
      APIHelper.onFailure(response.message);
      return;
    }
    log(response.toJson().toString());
    _onSuccessPostRideRequest(response);
  }

  void _onSuccessPostRideRequest(RawAPIResponse response) {
    Get.back();
    AppDialogs.shareRideSuccessDialog(
        messageText: response.message,
        homeButtonTap: () async {
          // Get.offAllNamed(AppPageNames.zoomDrawerScreen);
          Helper.getBackToHomePage();
        });
  }

/*<-----------Get categories from API ----------->*/
  Future<void> getCategories() async {
    AllCategoriesResponse? response = await APIRepo.getAllCategories();
    if (response == null) {
      APIHelper.onError('No response found for this action!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingCategoriesList(response);
  }

  onSuccessRetrievingCategoriesList(AllCategoriesResponse response) {
    categories = response.data.docs;
    selectedCategory = categories.firstOrNull ?? AllCategoriesDoc.empty();
    update();
  }
/*<----------- Fetch screen navigation argument----------->*/

  void _getScreenParameter() {
    dynamic params = Get.arguments;
    if (params is OfferOverViewBottomsheetScreenParameters) {
      requestDetails = params.requestDetails;
      type = params.type != 'vehicle';
      rate.value = params.requestDetails.rate;
      seat = params.seat.obs;
      update();
      if (type) {
        getCategories();
      }
    }
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }
}
