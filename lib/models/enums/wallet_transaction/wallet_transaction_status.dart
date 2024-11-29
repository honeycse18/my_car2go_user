import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';

enum WalletTransactionStatus {
  pending(AppConstants.walletTransactionStatusPending,
      AppLanguageTranslation.pendingTransKey),
  accepted(AppConstants.walletTransactionStatusAccepted,
      AppLanguageTranslation.acceptedTransKey),
  rejected(AppConstants.walletTransactionStatusRejected,
      AppLanguageTranslation.rejectedTransKey),
  completed(AppConstants.walletTransactionStatusCompleted,
      AppLanguageTranslation.completeTranskey),
  paid(AppConstants.walletTransactionStatusPaid,
      AppLanguageTranslation.paidTranskey),
  failed(AppConstants.walletTransactionStatusFailed,
      AppLanguageTranslation.carpoolingTransKey),
  cancelled(AppConstants.walletTransactionStatusCancelled,
      AppLanguageTranslation.userTopUpTransKey),
  refunded(AppConstants.walletTransactionStatusRefunded,
      AppLanguageTranslation.userTopUpTransKey),
  processing(AppConstants.walletTransactionStatusProcessing,
      AppLanguageTranslation.userTopUpTransKey),
  unknown('unknown', 'Unknown');

  final String stringValue;
  final String viewableTextTransKey;
  const WalletTransactionStatus(this.stringValue, this.viewableTextTransKey);

  static WalletTransactionStatus get defaultValue =>
      WalletTransactionStatus.unknown;

  factory WalletTransactionStatus.fromString(String value) {
    final Map<String, WalletTransactionStatus> stringToEnumMap = {
      WalletTransactionStatus.pending.stringValue:
          WalletTransactionStatus.pending,
      WalletTransactionStatus.accepted.stringValue:
          WalletTransactionStatus.accepted,
      WalletTransactionStatus.rejected.stringValue:
          WalletTransactionStatus.rejected,
      WalletTransactionStatus.completed.stringValue:
          WalletTransactionStatus.completed,
      WalletTransactionStatus.paid.stringValue: WalletTransactionStatus.paid,
      WalletTransactionStatus.failed.stringValue:
          WalletTransactionStatus.failed,
      WalletTransactionStatus.cancelled.stringValue:
          WalletTransactionStatus.cancelled,
      WalletTransactionStatus.refunded.stringValue:
          WalletTransactionStatus.refunded,
      WalletTransactionStatus.processing.stringValue:
          WalletTransactionStatus.processing,
    };
    return stringToEnumMap[value] ?? defaultValue;
  }
}
