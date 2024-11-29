import 'dart:developer';

import 'package:car2gouser/controller/menu_screen_controller/wallet_screen_controller.dart';
import 'package:car2gouser/models/api_responses/site_settings.dart';
import 'package:car2gouser/models/api_responses/top_up_response.dart';
import 'package:car2gouser/models/core_api_responses/api_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/models/fakeModel/fake_data.dart';
import 'package:car2gouser/models/payment_option_model.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TopUpScreenController extends GetxController {
  final walletScreenController = Get.find<WalletScreenController>();
  /*<----------- Initialize variables ----------->*/

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  TextEditingController topUpController = TextEditingController();
  SettingsPaymentGateway selectedPaymentOption = SettingsPaymentGateway();
  // int selectedPaymentMethodIndex = 0;
  // String id = '';
  // SelectPaymentOptionModel selectedPaymentOption = FakeData.topupOptionList[0];

  // int amount = 1;
  // DateTime selectedStartDate = DateTime.now();
  // TimeOfDay selectedStartTime = TimeOfDay.now();
  // final PageController imageController = PageController(keepPage: false);
  bool get shouldDisableTopUpButton =>
      double.tryParse(topUpController.text) == null ||
      selectedPaymentOption.name.isEmpty;

/*<-----------Topup wallet from API ----------->*/
  void onAmountTap(double amount) {
    topUpController.text = amount.toInt().toString();
  }

  Future<void> topUpWallet() async {
    Map<String, dynamic> requestBody = {
      'method': selectedPaymentOption.name.toLowerCase(),
      'type': 'user_topUp',
      'amount': double.tryParse(topUpController.text) ?? 0,
    };
    final response = await APIRepo.topUpWalletUpdated(requestBody: requestBody);
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    _onSuccessStartRentStatus(response);
  }

  void _onSuccessStartRentStatus(APIResponse<TopUpResponse> response) async {
    final didOpenSuccessfully =
        await Helper.openURLInBrowser(url: response.data.url);
    if (didOpenSuccessfully == false) {
      AppDialogs.showErrorDialog(
          messageText: 'Failed to open browser for payment');
    }
    walletScreenController.getWalletDetails();
    Get.back();
  }
/*<----------- Fetch screen navigation argument----------->*/

  @override
  void onInit() {
    topUpController.addListener(update);
    super.onInit();
  }

  @override
  void onClose() {
    topUpController.dispose();
    super.onClose();
  }
}
