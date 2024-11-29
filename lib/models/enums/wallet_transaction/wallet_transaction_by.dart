import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';

enum WalletTransactionBy {
  user(AppConstants.walletTransactionByUser,
      AppLanguageTranslation.userTransKey),
  driver(AppConstants.walletTransactionByDriver,
      AppLanguageTranslation.driverTransKey),
  employee(AppConstants.walletTransactionByEmployee,
      AppLanguageTranslation.employeeTransKey),
  unknown('unknown', 'Unknown');

  final String stringValue;
  final String viewableTextTransKey;
  const WalletTransactionBy(this.stringValue, this.viewableTextTransKey);

  static WalletTransactionBy get defaultValue => WalletTransactionBy.unknown;

  factory WalletTransactionBy.fromString(String value) {
    final Map<String, WalletTransactionBy> stringToEnumMap = {
      WalletTransactionBy.user.stringValue: WalletTransactionBy.user,
      WalletTransactionBy.driver.stringValue: WalletTransactionBy.driver,
      WalletTransactionBy.employee.stringValue: WalletTransactionBy.employee,
    };
    return stringToEnumMap[value] ?? defaultValue;
  }
}
