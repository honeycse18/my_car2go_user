import 'dart:developer';

import 'package:car2gouser/models/api_responses/t/property_find_response/registration_verify/request_otp.dart';
import 'package:car2gouser/models/core_api_responses/api_response.dart';
import 'package:car2gouser/models/enums/gender.dart';
import 'package:car2gouser/models/enums/otp_verify_purpose.dart';
import 'package:car2gouser/models/screenParameters/sign_up_screen_parameter.dart';
import 'package:car2gouser/models/screenParameters/verification_screen_parameter.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegistrationScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  final RxBool isDropdownOpen = false.obs;
  SignUpScreenParameter? screenParameter;
  bool isEmail = true;
  RxBool toggleHidePassword = true.obs;
  // String? selectedGender;
  Gender? selectedGender;
  // List<String> genderOptions = ["Male", "Female", "Other"];

  RxBool toggleHideConfirmPassword = true.obs;
  RxBool toggleAgreeTermsConditions = false.obs;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('BD');

  bool validateSignUp() {
    if ((signUpFormKey.currentState?.validate() == true) == false) {
      return false;
    }
    if (checkEmpty(passwordTextEditingController) ||
        (passwordTextEditingController.text !=
            confirmPasswordTextEditingController.text)) {
      AppDialogs.showErrorDialog(messageText: 'Passwords don\'t match!');
      return false;
    }
    return true;
  }

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    AppSingleton.instance.currentCountryCode = countryCode;
    update();
  }

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

/*   void selectGender(String gender) {
    selectedGender.value = gender;
    isDropdownOpen.value = false;
  } */

  void onGenderChange(Gender? newGender) {
    selectedGender = newGender;
    // isDropdownOpen.value = false;
    update();
  }

  String? addressFormValidator(String? text) {
    if (text == null) {
      return "Enter your address";
    }
    if (text.isEmpty) {
      return "Address cannot be empty";
    }
    return null;
  }

  String? passwordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  String? confirmPasswordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != passwordTextEditingController.text) {
        return AppLanguageTranslation
            .passwordDoesnotMatchTranskey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onConfirmPasswordSuffixEyeButtonTap() {
    toggleHideConfirmPassword.value = !toggleHideConfirmPassword.value;
  }

  bool isFieldFillupped() {
    return signUpFormKey.currentState?.validate() ?? false;
  }

  void onToggleAgreeTermsConditions(bool? value) {
    if (isFieldFillupped()) {
      toggleAgreeTermsConditions.value = value ?? false;
    }
    update();
  }

  bool checkEmpty(TextEditingController controller) {
    return controller.text.isEmpty;
  }
/* <---- Continue button tap ----> */

  void onContinueButtonTap() {
    if (validateSignUp()) {
      if (!toggleAgreeTermsConditions.value) {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .youMustAgreeTermsConditionsFirstTranskey.toCurrentLanguage);
        return;
      }
      String key = 'phone';
      String value = getPhoneFormatted();
      if (isEmail) {
        key = 'email';
        value = emailTextEditingController.text;
      }
      Map<String, dynamic> requestBodyForOTP = {
        key: value,
        'action': 'registration',
      };
      requestForOTP(requestBodyForOTP);
    }
  }

/* <---- Request for OTP from API ----> */

  Future<void> requestForOTP(Map<String, dynamic> data) async {
    final identifier =
        isEmail ? emailTextEditingController.text : getPhoneFormatted();
    final request = {'identifier': identifier, 'action': 'signup'};
    final response = await APIRepo.requestOTPUpdated(request);
    if (response == null) {
      APIHelper.onError('No response for requesting otp!');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    log(response
        .toJson(
          (data) => data.toJson(),
        )
        .toString());
    _onSuccessSendingOTP(response);
  }

  String getPhoneFormatted() {
    return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
  }

  void _onSuccessSendingOTP(APIResponse<RequestOtp> response) {
    Map<String, dynamic> registrationData = {
      'name': nameTextEditingController.text,
      // 'phone': getPhoneFormatted(),
      'email': emailTextEditingController.text,
      'password': passwordTextEditingController.text,
      // 'confirm_password': confirmPasswordTextEditingController.text,
      'role': 'user',
      'address': addressController.text,
      'gender': selectedGender?.stringValue,
      // 'isEmail': isEmail,
      'type': isEmail ? 'email' : 'phone',
      // 'isForRegistration': true,
      // 'action': 'registration',
    };
    Get.toNamed(AppPageNames.verificationScreen,
        arguments: VerificationScreenParameter(
            purpose: OtpVerifyPurpose.signUp,
            identifier:
                isEmail ? emailTextEditingController.text : getPhoneFormatted(),
            isIdentifierTypeEmail: isEmail,
            signUpDetails: registrationData));
  }
/*<----------- Fetch screen navigation argument----------->*/

  void _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SignUpScreenParameter) {
      screenParameter = params;
      isEmail = screenParameter!.isEmail;
      if (screenParameter!.isEmail) {
        emailTextEditingController.text = screenParameter!.theValue;
      } else {
        phoneTextEditingController.text = screenParameter!.theValue;
        currentCountryCode =
            screenParameter!.countryCode ?? CountryCode.fromCountryCode('BD');
      }
    }
    update();
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameters();
    passwordTextEditingController.addListener(() => update());
    super.onInit();
  }

  @override
  void onClose() {
    emailTextEditingController.dispose();
    phoneTextEditingController.dispose();
    nameTextEditingController.dispose();
    addressController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.onClose();
  }
}
