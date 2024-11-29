import 'package:car2gouser/utils/helpers/api_helper.dart';

class RecentLocationResponse {
  bool error;
  String msg;
  List<RecentLocationsData> data;

  RecentLocationResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory RecentLocationResponse.fromJson(Map<String, dynamic> json) {
    return RecentLocationResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: APIHelper.getSafeList(json['data'])
          .map((e) => RecentLocationsData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static RecentLocationResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RecentLocationResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RecentLocationResponse();
}

class RecentLocationsData {
  String address;
  RecentLocationsLocation location;

  RecentLocationsData({this.address = '', required this.location});

  factory RecentLocationsData.fromJson(Map<String, dynamic> json) =>
      RecentLocationsData(
        address: APIHelper.getSafeString(json['address']),
        location: RecentLocationsLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory RecentLocationsData.empty() => RecentLocationsData(
        location: RecentLocationsLocation(),
      );
  static RecentLocationsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RecentLocationsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RecentLocationsData.empty();
}

class RecentLocationsLocation {
  double lat;
  double lng;

  RecentLocationsLocation({this.lat = 0, this.lng = 0});

  factory RecentLocationsLocation.fromJson(Map<String, dynamic> json) =>
      RecentLocationsLocation(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static RecentLocationsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RecentLocationsLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RecentLocationsLocation();
}
