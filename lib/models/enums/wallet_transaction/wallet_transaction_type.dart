import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';

enum WalletTransactionType {
  subscription(AppConstants.walletTransactionTypeSubscription,
      AppLanguageTranslation.subscriptionTransKey),
  trip(AppConstants.walletTransactionTypeTrip,
      AppLanguageTranslation.tripTransKey),
  carpooling(AppConstants.walletTransactionTypeCarpooling,
      AppLanguageTranslation.carpoolingTransKey),
  userTopUp(AppConstants.walletTransactionTypeUserTopUp,
      AppLanguageTranslation.userTopUpTransKey),
  driverTopUp(AppConstants.walletTransactionTypeDriverTopUp,
      AppLanguageTranslation.driverTopUpTransKey),
  withdraw(AppConstants.walletTransactionTypeDriverWithdraw,
      AppLanguageTranslation.withdrawTransKey),
  tripCancellation(AppConstants.walletTransactionTypeDriverTripCancellation,
      AppLanguageTranslation.driverTopUpTransKey),
  carpoolingCancellation(
      AppConstants.walletTransactionTypeDriverCarpoolingCancellation,
      AppLanguageTranslation.driverTopUpTransKey),
  unknown('unknown', 'Unknown');

  final String stringValue;
  final String viewableTextTransKey;
  const WalletTransactionType(this.stringValue, this.viewableTextTransKey);

  static WalletTransactionType get defaultValue =>
      WalletTransactionType.unknown;

  factory WalletTransactionType.fromString(String value) {
    final Map<String, WalletTransactionType> stringToEnumMap = {
      WalletTransactionType.subscription.stringValue:
          WalletTransactionType.subscription,
      WalletTransactionType.trip.stringValue: WalletTransactionType.trip,
      WalletTransactionType.carpooling.stringValue:
          WalletTransactionType.carpooling,
      WalletTransactionType.userTopUp.stringValue:
          WalletTransactionType.userTopUp,
      WalletTransactionType.driverTopUp.stringValue:
          WalletTransactionType.driverTopUp,
      WalletTransactionType.withdraw.stringValue:
          WalletTransactionType.withdraw,
      WalletTransactionType.tripCancellation.stringValue:
          WalletTransactionType.tripCancellation,
      WalletTransactionType.carpoolingCancellation.stringValue:
          WalletTransactionType.carpoolingCancellation,
    };
    return stringToEnumMap[value] ?? defaultValue;
  }
}
