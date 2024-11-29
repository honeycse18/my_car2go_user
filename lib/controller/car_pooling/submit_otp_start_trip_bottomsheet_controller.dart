import 'dart:developer';

import 'package:action_slider/action_slider.dart';
import 'package:car2gouser/models/api_responses/carpolling/pulling_offer_details_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitOtpStartRideBottomSheetController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  bool isSuccess = false;
  ActionSliderController actionSliderController = ActionSliderController();
  PullingOfferDetailsRequest requestDetails =
      PullingOfferDetailsRequest.empty();

  TextEditingController otpTextEditingController = TextEditingController();
  String rideId = '';
  /*<----------- Accept reject ride request ----------->*/

  Future<void> acceptRejectRideRequest() async {
    Map<String, dynamic> requestBody = {
      '_id': requestDetails.id,
      'status': 'started',
      'otp': otpTextEditingController.text,
    };
    RawAPIResponse? response =
        await APIRepo.startRideWithSubmitOtp(requestBody);
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.success) {
      APIHelper.onFailure(response.message);
      return;
    }
    log(response.toJson().toString());
    await AppDialogs.showSuccessDialog(messageText: response.message);
    _onSuccessStartRideRequest(response);
  }

  _onSuccessStartRideRequest(RawAPIResponse response) async {
    isSuccess = true;
    Get.back(result: true);
    return;
  }
/*<----------- Fetch screen navigation argument----------->*/

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is PullingOfferDetailsRequest) {
      requestDetails = argument;
      update();
    }
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }

  @override
  void dispose() {
    actionSliderController.dispose();
    otpTextEditingController.dispose();
    super.dispose();
  }
}
