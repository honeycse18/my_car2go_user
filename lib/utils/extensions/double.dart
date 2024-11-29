import 'package:car2gouser/utils/helpers/helpers.dart';

extension DoubleExtensions on double {
  getCurrencyFormattedText({decimalDigits = 2}) =>
      Helper.getCurrencyFormattedWithDecimalAmountText(this, decimalDigits);
}
