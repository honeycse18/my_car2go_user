import 'package:car2gouser/utils/helpers/api_helper.dart';

class RegistrationResponse {
  bool error;
  String msg;
  RegistrationData data;

  RegistrationResponse({this.error = false, this.msg = '', required this.data});

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationResponse(
        error: APIHelper.getSafeBool(json['error']),
        msg: APIHelper.getSafeString(json['msg']),
        data: RegistrationData.getAPIResponseObjectSafeValue(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory RegistrationResponse.empty() => RegistrationResponse(
        data: RegistrationData(),
      );
  static RegistrationResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RegistrationResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RegistrationResponse.empty();
}

class RegistrationData {
  String token;
  String role;

  RegistrationData({this.token = '', this.role = ''});

  factory RegistrationData.fromJson(Map<String, dynamic> json) =>
      RegistrationData(
        token: APIHelper.getSafeString(json['token']),
        role: APIHelper.getSafeString(json['role']),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'role': role,
      };

  static RegistrationData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RegistrationData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RegistrationData();
}

class RegistrationDataUpdated {
  String accessToken;

  RegistrationDataUpdated({this.accessToken = ''});

  factory RegistrationDataUpdated.fromJson(Map<String, dynamic> json) =>
      RegistrationDataUpdated(
        accessToken: APIHelper.getSafeString(json['accessToken']),
      );

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
      };

  static RegistrationDataUpdated getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RegistrationDataUpdated.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RegistrationDataUpdated();
}
