import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';

enum WalletTransactionPaymentStatus {
  pending(AppConstants.walletTransactionPaymentStatusPending,
      AppLanguageTranslation.pendingTransKey),
  paid(AppConstants.walletTransactionPaymentStatusPaid,
      AppLanguageTranslation.paidTranskey),
  cancelled(AppConstants.walletTransactionPaymentStatusCancelled,
      AppLanguageTranslation.userTopUpTransKey),
  failed(AppConstants.walletTransactionPaymentStatusFailed,
      AppLanguageTranslation.carpoolingTransKey),
  unknown('unknown', 'Unknown');

  final String stringValue;
  final String viewableTextTransKey;
  const WalletTransactionPaymentStatus(
      this.stringValue, this.viewableTextTransKey);

  static WalletTransactionPaymentStatus get defaultValue =>
      WalletTransactionPaymentStatus.unknown;

  factory WalletTransactionPaymentStatus.fromString(String value) {
    final Map<String, WalletTransactionPaymentStatus> stringToEnumMap = {
      WalletTransactionPaymentStatus.pending.stringValue:
          WalletTransactionPaymentStatus.pending,
      WalletTransactionPaymentStatus.paid.stringValue:
          WalletTransactionPaymentStatus.paid,
      WalletTransactionPaymentStatus.failed.stringValue:
          WalletTransactionPaymentStatus.failed,
      WalletTransactionPaymentStatus.cancelled.stringValue:
          WalletTransactionPaymentStatus.cancelled,
    };
    return stringToEnumMap[value] ?? defaultValue;
  }
}
