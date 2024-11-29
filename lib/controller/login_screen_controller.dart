import 'dart:convert';
import 'dart:developer';

import 'package:car2gouser/models/api_responses/profile_details.dart';
import 'package:car2gouser/models/core_api_responses/api_response.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:car2gouser/models/api_responses/find_account_response.dart';
import 'package:car2gouser/models/api_responses/social_google_login_response.dart';
import 'package:car2gouser/models/api_responses/user_details_response.dart';
import 'package:car2gouser/models/screenParameters/sign_up_screen_parameter.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_local_stored_keys.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/utils/helpers/social_auth.dart';

class LoginScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  bool phoneMethod = false;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('BD');
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    AppSingleton.instance.currentCountryCode = countryCode;
    update();
  }
/* <---- Continue button tap ----> */

  void onContinueButtonTap() {
    // findAccount();
    // TODO: Call this on updated API
    findAccountUpdated();
    // findAccount();
  }
/* <---- Method button tap ----> */

  void onMethodButtonTap() {
    phoneMethod = !phoneMethod;
    update();
  }
/* <---- Google Login Button Tap Action  ----> */

  void onGoogleSignButtonTap() async {
    final UserCredential? uc = await SocialAuth().signInWithGoogle();
    log(uc?.credential?.accessToken?.toString() ?? '');
    log(uc?.user?.uid.toString() ?? '');
    final idToken = await uc?.user?.getIdToken();
    log(idToken.toString());
    googleLogin(idToken ?? '');
  }
/* <---- Google Login ----> */

  Future<void> googleLogin(String accessToken) async {
    final Map<String, Object> requestBody = {
      'access_token': accessToken,
      'role': AppConstants.userRoleUser,
    };
    String requestBodyJson = jsonEncode(requestBody);
    SocialGoogleLoginResponse? response =
        await APIRepo.socialGoogleLoginVerify(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    _onSuccessGoogleLogin(response);
  }

  void _onSuccessGoogleLogin(SocialGoogleLoginResponse response) async {
    final String token =
        response.token.isNotEmpty ? response.token : response.data.token;
    await GetStorage().write(LocalStoredKeyName.loggedInUserToken, token);
    _getLoggedInUserDetails(token);
  }
/* <---- Get Logged User Details From Api----> */

  Future<void> _getLoggedInUserDetails(String token) async {
    UserDetailsResponse? response = await APIRepo.getUserDetails(token: token);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    _onSuccessGetLoggedInUserDetails(response);
  }

  void _onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data as ProfileDetails);
    BuildContext? context = Get.context;
    if (context != null) {
      Get.offAllNamed(AppPageNames.zoomDrawerScreen);
      log('Login');
    }
  }
/* 
  Future<void> getLoggedUserDetails(String token) async {
    UserDetailsResponse? response = await APIRepo.getUserDetails(token: token);
    if (response == null) {
      onErrorGetLoggedInUserDetails(response);
      return;
    } else if (response.error) {
      onFailureGetLoggedInUserDetails(response);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onErrorGetLoggedInUserDetails(UserDetailsResponse? response) {
    APIHelper.onError(response?.msg);
  }

  void onFailureGetLoggedInUserDetails(UserDetailsResponse response) {
    APIHelper.onFailure(response.msg);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    BuildContext? context = Get.context;
    if (context != null) {
      Get.offAllNamed(AppPageNames.zoomDrawerScreen);
    }
  } */

  String getPhoneFormatted() {
    return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
  }
/* <---- Find Account ----> */

  Future<void> findAccount() async {
    String key = 'email';
    String value = emailTextEditingController.text;
    if (phoneMethod) {
      key = 'phone';
      value = getPhoneFormatted();
    }
    final Map<String, dynamic> requestBody = {
      key: value,
    };
    FindAccountResponse? response = await APIRepo.findAccount(requestBody);
    if (response == null) {
      // Get.snackbar('Found Empty Response', response?.msg??'');
      APIHelper.onError(response?.msg ?? '');
      return;
    } else if (response.error) {
      APIHelper.onNewFailure('Found No Response', response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessFindingAccount(response);
  }

  void _onSuccessFindingAccount(FindAccountResponse response) {
    bool hasAccount = response.data.account;
    log(response.data.role);
    if (hasAccount) {
      if (response.data.role == AppConstants.userRoleUser) {
        Get.toNamed(AppPageNames.logInPasswordScreen,
            arguments: SignUpScreenParameter(
                isEmail: !phoneMethod,
                theValue: phoneMethod
                    ? getPhoneFormatted()
                    : emailTextEditingController.text));
      } else {
        Get.snackbar(
            AppLanguageTranslation.alreadyRegisteredTranskey.toCurrentLanguage,
            AppLanguageTranslation
                .alreadyHaveAccountWithThisCredentialTranskey.toCurrentLanguage,
            backgroundColor: AppColors.backgroundColor.withOpacity(0.5),
            overlayBlur: 2,
            snackStyle: SnackStyle.FLOATING,
            overlayColor: Colors.transparent);
        return;
      }
    } else {
      Get.toNamed(AppPageNames.registrationScreen,
          arguments: SignUpScreenParameter(
              isEmail: !phoneMethod,
              countryCode: currentCountryCode,
              theValue: phoneMethod
                  ? phoneTextEditingController.text
                  : emailTextEditingController.text));
    }
  }

  Future<void> findAccountUpdated() async {
    // String key = 'email';
    const String key = 'identifier';
    String value = emailTextEditingController.text;
    if (phoneMethod) {
      // key = 'phone';
      value = getPhoneFormatted();
    }
    final Map<String, dynamic> requestBody = {
      key: value,
    };
    final APIResponse<FindAccountDataRefactored>? response =
        await APIRepo.findAccountUpdated(requestBody);
    if (response == null) {
      // Get.snackbar('Found Empty Response', response?.msg??'');
      APIHelper.onError(response?.message ?? '');
      return;
    } else if (response.error) {
      final isAccountDoesNotExists = response.statusCode == 404 ||
          response.errorDetails.errorMessage == 'User not found !';
      if (isAccountDoesNotExists) {
        APIHelper.onNewFailure('Create your account to get started', '');
        Get.toNamed(AppPageNames.registrationScreen,
            arguments: SignUpScreenParameter(
                isEmail: !phoneMethod,
                countryCode: currentCountryCode,
                theValue: phoneMethod
                    ? phoneTextEditingController.text
                    : emailTextEditingController.text));

        return;
      }
      APIHelper.onNewFailure('Found No Response', response.message);
      return;
    }
    log(response.toJson((data) => data.toJson()).toString());

    // On success
    Get.toNamed(AppPageNames.logInPasswordScreen,
        arguments: SignUpScreenParameter(
            isEmail: !phoneMethod,
            theValue: phoneMethod
                ? getPhoneFormatted()
                : emailTextEditingController.text));
  }

  void _getScreenParameters() {
    if (Get.arguments != null) {
      final SignUpScreenParameter parameter = Get.arguments;
      if (parameter.isEmail) {
        emailTextEditingController.text = parameter.theValue;
        phoneMethod = false;
      } else {
        phoneTextEditingController.text = parameter.theValue;
        currentCountryCode =
            parameter.countryCode ?? CountryCode.fromCountryCode('UK');
        phoneMethod = true;
      }
    }
    update();
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
