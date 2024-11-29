import 'dart:developer';
import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:get/get.dart';
import 'package:car2gouser/models/api_responses/languages_response.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class LanguageScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  List<Language> languages = [];
  Language selectedLanguage = Language();

  void onLanguageTap(Language language) async {
    selectedLanguage = language;
    await AppSingleton.instance.localBox
        .put(AppConstants.hiveDefaultLanguageKey, language.name);
    update();
  }

  /*<----------- Get Languages from API----------->*/

  Future<void> getLanguages() async {
    LanguagesResponse? response = await APIRepo.fetchLanguages();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetLanguages(response);
  }

  void _onSuccessGetLanguages(LanguagesResponse response) async {
    languages = response.data.where((language) => language.active).toList();
    final dynamic currentLanguageName =
        AppSingleton.instance.localBox.get(AppConstants.hiveDefaultLanguageKey);
    if (currentLanguageName is String) {
      final Language? foundLanguage = languages
          .firstWhereOrNull((language) => language.name == currentLanguageName);
      if (foundLanguage != null) {
        selectedLanguage = foundLanguage;
      }
    }
    update();
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    getLanguages();
    super.onInit();
  }
}
