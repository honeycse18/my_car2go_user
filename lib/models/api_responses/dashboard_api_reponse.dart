import 'package:car2gouser/utils/helpers/api_helper.dart';

class DashboardApiResponse {
  bool error;
  String msg;
  DashBoardData data;

  DashboardApiResponse({this.error = false, this.msg = '', required this.data});

  factory DashboardApiResponse.fromJson(Map<String, dynamic> json) {
    return DashboardApiResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: DashBoardData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory DashboardApiResponse.empty() =>
      DashboardApiResponse(data: DashBoardData());
  static DashboardApiResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashboardApiResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DashboardApiResponse.empty();
}

class DashBoardData {
  String id;
  int rides;
  int distance;
  int duration;

  DashBoardData(
      {this.id = '', this.rides = 0, this.distance = 0, this.duration = 0});

  factory DashBoardData.fromJson(Map<String, dynamic> json) => DashBoardData(
        id: APIHelper.getSafeString(json['_id']),
        rides: APIHelper.getSafeInt(json['rides']),
        distance: APIHelper.getSafeInt(json['distance']),
        duration: APIHelper.getSafeInt(json['duration']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'rides': rides,
        'distance': distance,
        'duration': duration,
      };

  static DashBoardData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashBoardData.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : DashBoardData();
}
