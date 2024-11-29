import 'package:car2gouser/utils/helpers/api_helper.dart';

class OtpRequestResponse {
  bool error;
  String msg;
  String data;

  OtpRequestResponse({this.error = false, this.msg = '', this.data = ''});

  factory OtpRequestResponse.fromJson(Map<String, dynamic> json) {
    return OtpRequestResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: APIHelper.getSafeString(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data,
      };

  static OtpRequestResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OtpRequestResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OtpRequestResponse();
}
