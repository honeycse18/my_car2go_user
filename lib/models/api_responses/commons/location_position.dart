import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class LocationPosition {
  double lat;
  double lng;

  LocationPosition(
      {this.lat = AppConstants.unknownLatLongValue,
      this.lng = AppConstants.unknownLatLongValue});

  factory LocationPosition.fromJson(Map<String, dynamic> json) =>
      LocationPosition(
        lat: APIHelper.getSafeDouble(
            json['lat'], AppConstants.unknownLatLongValue),
        lng: APIHelper.getSafeDouble(
            json['lng'], AppConstants.unknownLatLongValue),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static LocationPosition getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LocationPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : LocationPosition();

  bool get isUnset =>
      lat == AppConstants.unknownLatLongValue ||
      lng == AppConstants.unknownLatLongValue;

  bool get isSet => isUnset == false;
}
