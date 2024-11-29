import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';

enum WalletTransactionMode {
  deposit(AppConstants.walletTransactionModeDeposit,
      AppLanguageTranslation.depositTransKey),
  expense(AppConstants.walletTransactionModeExpense,
      AppLanguageTranslation.expenseTransKey),
  unknown('unknown', 'Unknown');

  final String stringValue;
  final String viewableTextTransKey;
  const WalletTransactionMode(this.stringValue, this.viewableTextTransKey);

  static WalletTransactionMode get defaultValue =>
      WalletTransactionMode.unknown;

  factory WalletTransactionMode.fromString(String value) {
    final Map<String, WalletTransactionMode> stringToEnumMap = {
      WalletTransactionMode.deposit.stringValue: WalletTransactionMode.deposit,
      WalletTransactionMode.expense.stringValue: WalletTransactionMode.expense,
    };
    return stringToEnumMap[value] ?? defaultValue;
  }
}
