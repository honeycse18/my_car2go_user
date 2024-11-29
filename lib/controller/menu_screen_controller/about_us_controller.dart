import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:car2gouser/models/api_responses/about_us_response.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';

class AboutUsScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  AboutUsData aboutUsTextItem = AboutUsData.empty();
/*<-----------Get about us text from API ----------->*/
  Future<void> getAboutUsText() async {
    AboutUsResponse? response = await APIRepo.getAboutUsText();
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

  onSuccessRetrievingCategoriesList(AboutUsResponse response) {
    aboutUsTextItem = response.data;
    update();
  }

  @override
  void onInit() {
    getAboutUsText();
    super.onInit();
  }
}
