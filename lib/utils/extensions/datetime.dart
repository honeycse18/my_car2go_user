import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:intl/intl.dart';

extension ServerDateTime on DateTime {
  String formatted(String pattern) => DateFormat(pattern).format(this);
  String toServerDateTime() =>
      APIHelper.toServerDateTimeFormattedStringFromDateTime(this);
}
