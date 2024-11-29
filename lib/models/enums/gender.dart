import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';

enum Gender {
  male(AppConstants.genderMale, AppLanguageTranslation.maleTransKey),
  female(AppConstants.genderFemale, AppLanguageTranslation.femaleTransKey),
  other(AppConstants.genderOther, AppLanguageTranslation.otherTransKey),
  unknown('unknown', 'Unknown');

  final String stringValue;
  final String viewableTextTransKey;
  const Gender(this.stringValue, this.viewableTextTransKey);

  static Gender get defaultValue => unknown;
  static List<Gender> get list => [male, female, other];

  static Gender toEnumValue(String value) {
    final Map<String, Gender> stringToEnumMap = {
      Gender.male.stringValue: Gender.male,
      Gender.female.stringValue: Gender.female,
      Gender.other.stringValue: Gender.other,
    };
    return stringToEnumMap[value] ?? Gender.unknown;
  }
}
