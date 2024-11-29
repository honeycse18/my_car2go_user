import 'dart:developer';

import 'package:car2gouser/models/api_responses/contact_us_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';

class ContactUsScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  ContactUsDataItem contactUsAdminDetails = ContactUsDataItem.empty();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  String? nameFormValidator(String? name) {
    if (name != null) {
      if (name.isEmpty) {
        return AppLanguageTranslation.canNotEmptyTransKey.toCurrentLanguage;
      }
      if (name.length < 3) {
        return AppLanguageTranslation.minimumLengthTransKey.toCurrentLanguage;
      }
    }
    return null;
  }

  String? messageFormValidator(String? message) {
    if (message != null) {
      if (message.isEmpty) {
        return AppLanguageTranslation.canNotEmptyTransKey.toCurrentLanguage;
      }
      if (message.length < 3) {
        return AppLanguageTranslation.minimumLengthTransKey.toCurrentLanguage;
      }
    }
    return null;
  }
/* <---- Get contact us details from API----> */

  Future<void> getContactUsDetails() async {
    ContactUsResponse? response = await APIRepo.getContactUsDetails();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessContactUsDetails(response);
  }

  void onSuccessContactUsDetails(ContactUsResponse response) {
    contactUsAdminDetails = response.data;
    update();
  }

  Future<void> postContactUsSms() async {
    final Map<String, String> requestBody = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'subject': subjectController.text,
      'message': messageController.text
    };
    RawAPIResponse? response = await APIRepo.postContactUsMessage(requestBody);
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.success) {
      APIHelper.onFailure(response.message);
      return;
    }
    log(response.toJson().toString());

    _onSuccessAcceptCarRentRequest(response);
  }

  void _onSuccessAcceptCarRentRequest(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.message);
    emailController.clear();
    nameController.clear();
    phoneController.clear();
    subjectController.clear();
    messageController.clear();
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    getContactUsDetails();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
