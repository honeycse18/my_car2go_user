import 'dart:developer';
import 'package:car2gouser/models/core_api_responses/api_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewPasswordScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final GlobalKey<FormState> changePassFormKey = GlobalKey<FormState>();

  ///
  RxBool toggleHidePassword = true.obs;
  String token = '';
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  /// Toggle value of hide confirm password
  RxBool toggleHideConfirmPassword = true.obs;
  RxBool toggleAgreeTermsConditions = false.obs;

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onConfirmPasswordSuffixEyeButtonTap() {
    toggleHideConfirmPassword.value = !toggleHideConfirmPassword.value;
  }

  String? passwordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != confirmPasswordTextEditingController.text) {
        return AppLanguageTranslation
            .mustMatchWithConfirmPasswordTranskey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  void onSavePasswordButtonTap() {
    if (passwordTextEditingController.text.isEmpty ||
        passwordTextEditingController.text !=
            confirmPasswordTextEditingController.text) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .eitherFieldEmptyPasswordsdonnotMassTranskey.toCurrentLanguage);
      return;
    }
    if (changePassFormKey.currentState?.validate() == true) {
      createNewPass();
    }
  }
/* <---- Create new password ----> */

  Future<void> createNewPass() async {
    Map<String, dynamic> request = {
      'password': passwordTextEditingController.text,
      'confirm_password': confirmPasswordTextEditingController.text,
    };
    final response =
        await APIRepo.createNewPasswordUpdated(request, token: token);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    log(response.toJson((data) => {}).toString());
    onSuccessChangingPassword(response);
  }

  onSuccessChangingPassword(APIResponse<void> response) async {
    await AppDialogs.showPassChangedSuccessDialog(
        messageText: AppLanguageTranslation
            .passwordChangedSuccessfullyTransKey.toCurrentLanguage);
    Get.offNamed(AppPageNames.loginScreen);
  }
/*<----------- Fetch screen navigation argument----------->*/

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      token = params;
    }
    update();
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
