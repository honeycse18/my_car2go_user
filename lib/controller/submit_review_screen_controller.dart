import 'dart:developer';

import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/models/screenParameters/submit_review_screen_parameter.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SubmitReviewBottomSheetScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  final GlobalKey<FormState> submitReviewFormKey = GlobalKey<FormState>();
  SubmitReviewScreenParameter? submitReview;
  TextEditingController commentTextEditingController = TextEditingController();

  RxDouble rating = 0.0.obs;

  void setRating(double value) {
    rating.value = value;
    update();
  }

  /*<----------- Submit rent review from API ----------->*/
  Future<void> submitRentReview() async {
    Map<String, dynamic> requestBody = {
      'object': submitReview!.id,
      'type': submitReview!.type,
      'rating': rating.value,
      'comment': commentTextEditingController.text
    };
    RawAPIResponse? response = await APIRepo.submitReviews(requestBody);
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.success) {
      APIHelper.onFailure(response.message);
      return;
    }
    log(response.toJson().toString());
    _onSucessSendMessage(response);
  }

  void _onSucessSendMessage(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(
        messageText: AppLanguageTranslation
            .reviewSubmittedSuccessfullyTransKey.toCurrentLanguage);
    Get.back(result: true);
  }
/*<----------- Fetch screen navigation argument----------->*/

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SubmitReviewScreenParameter) {
      submitReview = params;
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
