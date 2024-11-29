import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';

/*<-------- Language helper ------->*/
class LanguageHelper {
  static String currentLanguageText(String translationKey) {
    final dynamic currentLanguageName =
        AppSingleton.instance.localBox.get(AppConstants.hiveDefaultLanguageKey);
    if (currentLanguageName is! String) {
      return fallbackText(translationKey);
    }
    final dynamic currentLanguageTranslations =
        AppSingleton.instance.localBox.get(currentLanguageName);
    if (currentLanguageTranslations is! Map<String, String>) {
      return fallbackText(translationKey);
    }
    final String? translatedText = currentLanguageTranslations[translationKey];
    if (translatedText == null) {
      return fallbackText(translationKey);
    }
    return translatedText;
  }

  static String fallbackText(String translationKey) =>
      AppLanguageTranslation.fallBackEnglishTranslation[translationKey] ?? '';
}
