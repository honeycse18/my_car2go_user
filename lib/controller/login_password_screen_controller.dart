import 'dart:developer';

import 'package:car2gouser/models/api_responses/login_response.dart';
import 'package:car2gouser/models/api_responses/otp_request_response.dart';
import 'package:car2gouser/models/api_responses/profile_details.dart';
import 'package:car2gouser/models/api_responses/t/login/login.dart';
import 'package:car2gouser/models/api_responses/t/property_find_response/registration_verify/request_otp.dart';
import 'package:car2gouser/models/core_api_responses/api_response.dart';
import 'package:car2gouser/models/enums/otp_verify_purpose.dart';
import 'package:car2gouser/models/screenParameters/sign_up_screen_parameter.dart';
import 'package:car2gouser/models/screenParameters/verification_screen_parameter.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_local_stored_keys.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LogInPasswordSCreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  RxBool toggleHidePassword = true.obs;
  TextEditingController passwordTextEditingController = TextEditingController();
  SignUpScreenParameter? screenParameter;
  Map<String, dynamic> credentials = {};
  String phoneNumber = '';
  CountryCode selectedCountryCode = AppSingleton.instance.currentCountryCode;
  bool isEmail = false;

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onForgotPasswordButtonTap() {
    forgotPassword();
  }

  void _setPhoneNumber(String phoneNumber) {
    final phoneNumberParts = Helper.separatePhoneAndDialCode(phoneNumber);
    final dialCode = phoneNumberParts?.dialCode ?? '';
    phoneNumber = phoneNumberParts?.strippedPhoneNumber ?? '';
    if (dialCode.isNotEmpty) {
      selectedCountryCode = CountryCode.fromDialCode(dialCode);
    }
    update();
  }
  /*<----------- Forgot password ----------->*/

  Future<void> forgotPassword() async {
    String key = 'phone';
    String value = '';
    if (isEmail) {
      value = credentials['email'];
      key = 'email';
    } else {
      value = credentials['phone'];
    }
    Map<String, dynamic> requestBody = {
      key: value,
      'action': 'forgot_password'
    };
    final request = {
      'identifier': isEmail ? credentials['email'] : credentials['phone'],
      'action': 'forget_password',
    };
    final APIResponse<RequestOtp>? response =
        await APIRepo.requestForgotPasswordOTPUpdated(request);
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.error) {
      APIHelper.onFailure('Error', response.message);
      return;
    }
    log(response.toJson((data) => data.toJson()).toString());
    _onSuccessSendingOTP(response, value, request);
  }

  void _onSuccessSendingOTP(APIResponse<RequestOtp> response, String data,
      Map<String, dynamic> requestBody) {
/*     Map<String, dynamic> forgetPasswordData = {
      // 'theData': data,
      'isEmail': screenParameter!.isEmail ? true : false,
      'isForRegistration': false,
      'action': 'forgot_password',
      'resendCode': requestBody
    };
    if (isEmail) {
      forgetPasswordData["email"] = data;
    } else {
      forgetPasswordData["phone"] = data;
    } */
    Get.offNamed(AppPageNames.verificationScreen,
        arguments: VerificationScreenParameter(
            purpose: OtpVerifyPurpose.forgetPassword,
            identifier: isEmail ? credentials['email'] : credentials['phone'],
            isIdentifierTypeEmail: isEmail,
            forgetPasswordDetails: requestBody));
  }

  void onLoginButtonTap() {
    // login();
    // TODO: Call this on updated API
    loginUpdated();
  }
  /*<----------- Login ----------->*/

  Future<void> login() async {
    credentials['password'] = passwordTextEditingController.text;
    LoginResponse? response = await APIRepo.login(credentials);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessLogin(response);
  }

  /*<----------- Success login ----------->*/
  Future<void> _onSuccessLogin(LoginResponse response) async {
    final token = response.data.token;
    await GetStorage().write(LocalStoredKeyName.loggedInUserToken, token);
    _getLoggedInUserDetails(token);
  }

  Future<void> loginUpdated() async {
    final String identifier;
    if (isEmail) {
      identifier = credentials['email'];
    } else {
      identifier = credentials['phone'];
    }
    final APIResponse<Login>? response = await APIRepo.loginUpdated({
      'identifier': identifier,
      'password': passwordTextEditingController.text,
      'role': AppConstants.userRoleUser,
    });
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    log(response
        .toJson(
          (data) => data.toJson(),
        )
        .toString());
    final token = response.data.accessToken;
    await GetStorage().write(LocalStoredKeyName.loggedInUserToken, token);
    _getLoggedInUserDetails(token);
  }

  /*<----------- Get Loggedin user details ----------->*/
  Future<void> _getLoggedInUserDetails(String token) async {
    final bool isSuccess = await Helper.updateSavedUserDetails();
    if (isSuccess == false) {
      return;
    }
    Get.offAllNamed(AppPageNames.zoomDrawerScreen);
    log('Login');
  }

  void _onSuccessGetLoggedInUserDetails(
      APIResponse<ProfileDetails> response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    Get.offAllNamed(AppPageNames.zoomDrawerScreen);
    log('Login');
  }
/*<----------- Fetch screen navigation argument----------->*/

  void _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SignUpScreenParameter) {
      screenParameter = params;
      String key = 'phone';
      if (screenParameter!.isEmail) {
        key = 'email';
        isEmail = true;
      }
      credentials[key] = screenParameter!.theValue;
      if (screenParameter!.isEmail == false) {
        _setPhoneNumber(credentials['phone']);
      }
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
