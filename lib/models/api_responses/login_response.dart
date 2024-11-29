import 'package:car2gouser/utils/helpers/api_helper.dart';

class LoginResponse {
  bool error;
  String msg;
  LoginData data;

  LoginResponse({this.error = false, this.msg = '', required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        error: APIHelper.getSafeBool(json['error']),
        msg: APIHelper.getSafeString(json['msg']),
        data: LoginData.getSafeObject(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory LoginResponse.empty() => LoginResponse(
        data: LoginData(),
      );
  static LoginResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LoginResponse.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : LoginResponse.empty();
}

class LoginData {
  String token;
  String role;

  LoginData({this.token = '', this.role = ''});

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: APIHelper.getSafeString(json['token']),
        role: APIHelper.getSafeString(json['role']),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'role': role,
      };

  static LoginData getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LoginData.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : LoginData();
}

class LoginDataUpdated {
  LoginDataUpdatedUser user;
  String accessToken;

  LoginDataUpdated({required this.user, this.accessToken = ''});

  factory LoginDataUpdated.empty() =>
      LoginDataUpdated(user: LoginDataUpdatedUser());

  factory LoginDataUpdated.fromJson(Map<String, dynamic> json) {
    return LoginDataUpdated(
      user: LoginDataUpdatedUser.getSafeObject(json['user']),
      accessToken: APIHelper.getSafeString(json['accessToken']),
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'accessToken': accessToken,
      };

  static LoginDataUpdated getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LoginDataUpdated.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : LoginDataUpdated.empty();
}

class LoginDataUpdatedUser {
  String id;
  String name;
  String email;
  String role;

  LoginDataUpdatedUser(
      {this.id = '', this.name = '', this.email = '', this.role = ''});

  factory LoginDataUpdatedUser.fromJson(Map<String, dynamic> json) =>
      LoginDataUpdatedUser(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        email: APIHelper.getSafeString(json['email']),
        role: APIHelper.getSafeString(json['role']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'role': role,
      };

  static LoginDataUpdatedUser getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LoginDataUpdatedUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : LoginDataUpdatedUser();
}
