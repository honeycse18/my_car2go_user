import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';

enum WalletTransactionFrom {
  trip(AppConstants.walletTransactionFromTrip,
      AppLanguageTranslation.tripTransKey),
  carpooling(AppConstants.walletTransactionFromCarpooling,
      AppLanguageTranslation.carpoolingTransKey),
  topUp(AppConstants.walletTransactionFromTopUp,
      AppLanguageTranslation.userTopUpTransKey),
  tripCancellation(AppConstants.walletTransactionFromTripCancellation,
      AppLanguageTranslation.driverTopUpTransKey),
  carpoolingCancellation(
      AppConstants.walletTransactionFromCarpoolingCancellation,
      AppLanguageTranslation.driverTopUpTransKey),
  unknown('unknown', 'Unknown');

  final String stringValue;
  final String viewableTextTransKey;
  const WalletTransactionFrom(this.stringValue, this.viewableTextTransKey);

  static WalletTransactionFrom get defaultValue =>
      WalletTransactionFrom.unknown;

  factory WalletTransactionFrom.fromString(String value) {
    final Map<String, WalletTransactionFrom> stringToEnumMap = {
      WalletTransactionFrom.trip.stringValue: WalletTransactionFrom.trip,
      WalletTransactionFrom.carpooling.stringValue:
          WalletTransactionFrom.carpooling,
      WalletTransactionFrom.topUp.stringValue: WalletTransactionFrom.topUp,
      WalletTransactionFrom.tripCancellation.stringValue:
          WalletTransactionFrom.tripCancellation,
      WalletTransactionFrom.carpoolingCancellation.stringValue:
          WalletTransactionFrom.carpoolingCancellation,
    };
    return stringToEnumMap[value] ?? defaultValue;
  }
}
