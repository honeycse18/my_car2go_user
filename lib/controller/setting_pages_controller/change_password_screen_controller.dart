import 'dart:math';

import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordCreateController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  bool toggleHideOldPassword = true;
  bool toggleHideNewPassword = true;

  bool toggleHideConfirmPassword = true;

  bool isPasswordOver8Characters = false;

  bool isPasswordHasAtLeastSingleNumberDigit = false;

  TextEditingController newPassword1EditingController = TextEditingController();
  TextEditingController currentPasswordEditingController =
      TextEditingController();
  TextEditingController newPassword2EditingController = TextEditingController();

  bool detectPasswordNumber(String passwordText) =>
      passwordText.contains(RegExp(r'[0-9]'));
  String? passwordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != newPassword2EditingController.text) {
        return AppLanguageTranslation
            .mustMatchWithConfirmPasswordTranskey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  String? confirmPasswordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != newPassword1EditingController.text) {
        return AppLanguageTranslation
            .passwordDoesnotMatchTranskey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  bool passMatched() {
    return newPassword1EditingController.text ==
        newPassword2EditingController.text;
  }

  void onSavePasswordButtonTap() {
    if (signUpFormKey.currentState?.validate() ?? false) {
      if (passMatched()) {
        sendPass();
      } else {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .passwordDoesnotMatchTranskey.toCurrentLanguage);
      }
    }
  }

//forget password

  Future<void> forgetPassword() async {
    final Map<String, dynamic> requestBody = {
      'email': currentPasswordEditingController.text,
    };
    final response = await APIRepo.forgetPasswordUpdated(requestBody);
    if (response == null) {
      APIHelper.onError(response?.message);

      return;
    } else if (response.success) {
      APIHelper.onError(response.message);
      return;
    }
    log(response.toJson((data) => data.toJson()).toString() as num);
    onSuccessSavePassword();
  }

  /*<----------- Send password for changing old password ----------->*/

  Future<void> sendPass() async {
    final Map<String, dynamic> requestBody = {
      'old_password': currentPasswordEditingController.text,
      'new_password': newPassword1EditingController.text,
      'confirm_password': newPassword2EditingController.text,
    };
    final response = await APIRepo.updatePassword(requestBody);
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.success) {
      APIHelper.onError(response.message);
      return;
    }
    log(response.toJson().toString() as num);
    onSuccessSavePassword();
  }

  void onSuccessSavePassword() {
    BuildContext? context = Get.context;
    if (context != null) {
      Get.offNamed(AppPageNames.passwordChangedScreen);
    }
  }

  onSuccess() {}
/* <---- Initial state ----> */

  @override
  void onInit() {
    newPassword1EditingController = TextEditingController();

    super.onInit();
  }
}
