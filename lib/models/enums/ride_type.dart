import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';

enum RideType {
  rideNow(AppConstants.rideTypeRideNow, AppLanguageTranslation.rideNowTransKey),
  shareRide(AppConstants.rideTypeShareRide,
      AppLanguageTranslation.scheduleRideTransKey),
  carpooling(AppConstants.rideTypeCarpooling,
      AppLanguageTranslation.shareRideTransKey),
  unknown('unknown', 'Unknown');

  final String stringValue;
  final String viewableTextTransKey;
  const RideType(this.stringValue, this.viewableTextTransKey);

  static RideType get defaultValue => unknown;

  factory RideType.fromString(String value) {
    final Map<String, RideType> stringToEnumMap = {
      RideType.rideNow.stringValue: RideType.rideNow,
      RideType.shareRide.stringValue: RideType.shareRide,
      RideType.carpooling.stringValue: RideType.carpooling,
    };
    return stringToEnumMap[value] ?? defaultValue;
  }
}
