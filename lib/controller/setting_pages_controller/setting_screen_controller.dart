import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:get/get.dart';

class SettingsScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  RxBool toggleNotification = true.obs;
  String get currentLanguageText {
    final dynamic currentLanguageName =
        AppSingleton.instance.localBox.get(AppConstants.hiveDefaultLanguageKey);
    if (currentLanguageName is String) {
      return currentLanguageName;
    }
    return '';
  }
}
