import 'package:car2gouser/controller/profile_screen_controller.dart';
import 'package:car2gouser/models/bottom_sheet_paramers/profile_entry_gender_bottom_sheet_parameter.dart';
import 'package:car2gouser/models/enums/otp_verify_purpose.dart';
import 'package:car2gouser/models/enums/profile_field_name.dart';
import 'package:car2gouser/models/screenParameters/verification_screen_parameter.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileFieldBottomsheetController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final profileScreenController = Get.find<MyAccountScreenController>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  String initialText = '';

  final textController = TextEditingController();

  CountryCode currentCountryCode = AppSingleton.instance.currentCountryCode;
  ProfileFieldName profileFieldName = ProfileFieldName.unknown;

  String get fullPhoneNumber =>
      '${currentCountryCode.dialCode}${textController.text}';

  String get getTitleName {
    switch (profileFieldName) {
      case ProfileFieldName.name:
        return 'Edit Full Name';
      case ProfileFieldName.email:
        return 'Edit Email';
      case ProfileFieldName.phone:
        return 'Edit Phone number';
      case ProfileFieldName.address:
        return 'Edit Address';
      default:
        return 'Edit';
    }
  }

  String get getSubtitleName {
    switch (profileFieldName) {
      case ProfileFieldName.name:
        return 'This name will be visible to other users across the app.';
      case ProfileFieldName.email:
        return ' This email will be used for login and important notifications.';
      case ProfileFieldName.phone:
        return 'This number may be used for verification and important updates.';
      case ProfileFieldName.address:
        return 'Update the address';
      default:
        return 'Edit';
    }
  }

  void onCountryCodeChanged(CountryCode countryCode) {
    currentCountryCode = countryCode;
    AppSingleton.instance.currentCountryCode = countryCode;
    update();
  }

  // // Function to update full name
  void onSubmitButtonTap() {
    switch (profileFieldName) {
      case ProfileFieldName.name:
        updateProfileFullName();
        return;
      case ProfileFieldName.email:
        updateEmailAddress();
        return;
      case ProfileFieldName.phone:
        updatePhoneNumber();
        return;
      case ProfileFieldName.address:
        updateProfileAddress();
        return;
      default:
    }
  }

  void updateProfileFullName() =>
      updateProfileEntry(request: {'name': textController.text});

  void updateProfileAddress() =>
      updateProfileEntry(request: {'address': textController.text});

  Future<void> updateEmailAddress() async {
    final requestBody = {
      'email': textController.text,
      'action': 'profile_update'
    };
    isLoading = true;
    final response = await APIRepo.sendUserProfileOTP(requestBody: requestBody);
    isLoading = false;
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForUpdatingProfileImageTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    Helper.showSnackBar('Please verify the email to update');
    final result = await Get.toNamed(AppPageNames.verificationScreen,
        arguments: VerificationScreenParameter(
            purpose: OtpVerifyPurpose.profileUpdate,
            isIdentifierTypeEmail: false,
            identifier: textController.text,
            profileUpdateDetails: requestBody));
    if (result is bool && result) {
      Get.back(result: true);
      AppDialogs.showSuccessDialog(messageText: 'Profile successfully updated');
    }
    return;
  }

  Future<void> updatePhoneNumber() async {
    isLoading = true;
    final requestBody = {'phone': fullPhoneNumber, 'action': 'profile_update'};
    final response = await APIRepo.sendUserProfileOTP(requestBody: requestBody);
    isLoading = false;
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForUpdatingProfileImageTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    Helper.showSnackBar('Please verify the phone number to update');
    final result = await Get.toNamed(AppPageNames.verificationScreen,
        arguments: VerificationScreenParameter(
            purpose: OtpVerifyPurpose.profileUpdate,
            isIdentifierTypeEmail: false,
            identifier: fullPhoneNumber,
            profileUpdateDetails: requestBody));
    if (result is bool && result) {
      Get.back(result: true);
      AppDialogs.showSuccessDialog(messageText: 'Profile successfully updated');
    }
    return;
  }

  Future<void> updateProfileEntry(
      {required Map<String, dynamic> request}) async {
    isLoading = true;
    final response = await profileScreenController.updateProfile(
        request: request, showDialog: false);
    isLoading = false;
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .noResponseForUpdatingProfileImageTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    Get.back(result: true);
    await AppDialogs.showSuccessDialog(messageText: response.message);
    return;
  }

  void onContinueButtonTap() {
    Get.back(
        result:
            initialText == textController.text ? null : textController.text);
  }

  void _setPhoneNumber(String phoneNumber) {
    final phoneNumberParts = Helper.separatePhoneAndDialCode(phoneNumber);
    final dialCode = phoneNumberParts?.dialCode ?? '';
    phoneNumber = phoneNumberParts?.strippedPhoneNumber ?? '';
    if (dialCode.isNotEmpty) {
      currentCountryCode = CountryCode.fromDialCode(dialCode);
    }
    textController.text = phoneNumber;
    update();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is ProfileEntryTextFieldBottomSheetParameter) {
      initialText = argument.initialValue;
      profileFieldName = argument.profileFieldName;
      if (profileFieldName == ProfileFieldName.phone) {
        _setPhoneNumber(initialText);
      } else {
        textController.text = initialText;
      }
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
