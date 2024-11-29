import 'datum.dart';

class PropertyFindResponse {
  bool? error;
  String? msg;
  List<Datum>? data;

  PropertyFindResponse({this.error, this.msg, this.data});

  factory PropertyFindResponse.fromJson(Map<String, dynamic> json) {
    return PropertyFindResponse(
      error: json['error'] as bool?,
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
