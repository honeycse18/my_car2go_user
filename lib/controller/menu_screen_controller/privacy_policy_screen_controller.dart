import 'dart:developer';

import 'package:car2gouser/models/api_responses/support_text_response.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:get/get.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';

class PrivacyPolicyScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  SupportTextItem supportTextItem = SupportTextItem.empty();
/* <---- Get support text from API ----> */

  Future<void> getSupportText() async {
    SupportTextResponse? response =
        await APIRepo.getSupportText(slug: 'privacy_policy');
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingCategoriesList(response);
  }

  onSuccessRetrievingCategoriesList(SupportTextResponse response) {
    supportTextItem = response.data;
    update();
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    getSupportText();

    super.onInit();
  }
}
