import 'package:car2gouser/utils/helpers/api_helper.dart';

class EarningApiResponse {
  bool error;
  String msg;
  List<Datum> data;

  EarningApiResponse({this.error = false, this.msg = '', this.data = const []});

  factory EarningApiResponse.fromJson(Map<String, dynamic> json) {
    return EarningApiResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: APIHelper.getSafeList(json['data'])
          .map((e) => Datum.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static EarningApiResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? EarningApiResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : EarningApiResponse();
}

class Datum {
  String id;
  int trips;
  double total;

  Datum({this.id = '', this.trips = 0, this.total = 0});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: APIHelper.getSafeString(json['_id']),
        trips: APIHelper.getSafeInt(json['trips']),
        total: APIHelper.getSafeDouble(json['total']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'trips': trips,
        'total': total,
      };

  static Datum getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Datum.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Datum();
}
