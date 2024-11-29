import 'package:car2gouser/utils/helpers/api_helper.dart';

class LiveLocationResponse {
  bool error;
  String msg;
  LiveLoc data;

  LiveLocationResponse({this.error = false, this.msg = '', required this.data});

  factory LiveLocationResponse.fromJson(Map<String, dynamic> json) {
    return LiveLocationResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: LiveLoc.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory LiveLocationResponse.empty() => LiveLocationResponse(
        data: LiveLoc(),
      );
  static LiveLocationResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LiveLocationResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : LiveLocationResponse.empty();
}

class LiveLoc {
  double lat;
  double lng;

  LiveLoc({this.lat = 0, this.lng = 0});

  factory LiveLoc.fromJson(Map<String, dynamic> json) => LiveLoc(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static LiveLoc getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LiveLoc.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : LiveLoc();
}
