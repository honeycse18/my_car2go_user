import 'package:car2gouser/utils/helpers/api_helper.dart';

class OtpVerificationResponse {
  bool error;
  String msg;
  OtpVerificationData data;

  OtpVerificationResponse(
      {this.error = false, this.msg = '', required this.data});

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerificationResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: OtpVerificationData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory OtpVerificationResponse.empty() => OtpVerificationResponse(
        data: OtpVerificationData(),
      );
  static OtpVerificationResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OtpVerificationResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OtpVerificationResponse.empty();
}

class OtpVerificationData {
  String token;

  OtpVerificationData({this.token = ''});

  factory OtpVerificationData.fromJson(Map<String, dynamic> json) =>
      OtpVerificationData(
        token: APIHelper.getSafeString(json['token']),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
      };

  static OtpVerificationData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OtpVerificationData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OtpVerificationData();
}
