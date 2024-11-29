import 'dart:developer';

import 'package:car2gouser/models/car_rent_details_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/models/enum.dart';
import 'package:car2gouser/models/fakeModel/fake_data.dart';
import 'package:car2gouser/models/payment_option_model.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectPaymentMethodScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  int selectedPaymentMethodIndex = 0;
  String id = '';
  SelectPaymentOptionModel selectedPaymentOption =
      FakeData.paymentOptionList[0];

  int amount = 1;
  DateTime selectedStartDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  CarRentItem carRentDetails = CarRentItem.empty();
  RentCarStatusStatus messageTypeTab = RentCarStatusStatus.hourly;
  final PageController imageController = PageController(keepPage: false);

  double get getRate {
    switch (messageTypeTab) {
      case RentCarStatusStatus.hourly:
        return carRentDetails.prices.hourly.price;
      case RentCarStatusStatus.weekly:
        return carRentDetails.prices.weekly.price;
      case RentCarStatusStatus.monthly:
        return carRentDetails.prices.monthly.price;
      default:
        return 0;
    }
  }
  /*<----------- payment accept car rent request from API ----------->*/

  Future<void> paymentAcceptCarRentRequest() async {
    final Map<String, String> requestBody = {
      '_id': id,
      'method': selectedPaymentOption.value,
    };
    RawAPIResponse? response =
        await APIRepo.paymentAcceptCarRentRequest(requestBody);
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.success) {
      APIHelper.onFailure(response.message);
      return;
    }
    log(response.toJson().toString());
    selectedPaymentOption.value == 'paypal'
        ? _onSucessPaymentStatus(response)
        : _onSucessWalletPaymentStatus(response);
  }

  void _onSucessPaymentStatus(RawAPIResponse response) async {
    final didOpenSuccessfully =
        await Helper.openURLInBrowser(url: response.data);
    if (didOpenSuccessfully == false) {
      AppDialogs.showErrorDialog(
          messageText: 'Failed to open browser for payment');
    }
    update();
    // Get.offAllNamed(AppPageNames.zoomDrawerScreen, arguments: 2);
    Helper.getBackToHomePage();
    _initializeAfterDelay(response);
  }

  _onSucessWalletPaymentStatus(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.message);
    update();
    // Get.offAllNamed(AppPageNames.zoomDrawerScreen);
    Helper.getBackToHomePage();
  }

  _initializeAfterDelay(RawAPIResponse response) async {
    await Future.delayed(const Duration(seconds: 3));
    AppDialogs.showSuccessDialog(messageText: response.message);
    update();
  }

/*<----------- Fetch screen navigation argument----------->*/

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      id = argument;
      update();
    }
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
