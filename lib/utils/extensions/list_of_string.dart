import 'package:car2gouser/utils/helpers/helpers.dart';

extension ListOfStringExtensions on List<String> {
  String safeFirst({String defaultValue = ''}) =>
      Helper.getFirstSafeString(this, defaultValue: defaultValue);
}
