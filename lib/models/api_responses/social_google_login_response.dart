import 'package:car2gouser/utils/helpers/api_helper.dart';

class SocialGoogleLoginResponse {
  bool error;
  String msg;
  String token;
  SocialGoogleLoginData data;

  SocialGoogleLoginResponse(
      {this.error = false, this.msg = '', this.token = '', required this.data});

  factory SocialGoogleLoginResponse.fromJson(Map<String, dynamic> json) {
    return SocialGoogleLoginResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      token: APIHelper.getSafeString(json['token']),
      data: SocialGoogleLoginData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'token': token,
        'data': data.toJson(),
      };

  factory SocialGoogleLoginResponse.empty() =>
      SocialGoogleLoginResponse(data: SocialGoogleLoginData());

  static SocialGoogleLoginResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SocialGoogleLoginResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SocialGoogleLoginResponse.empty();
}

class SocialGoogleLoginData {
  String id;
  String name;
  String email;
  String image;
  String phone;
  String role;
  String authType;
  String token;

  SocialGoogleLoginData({
    this.id = '',
    this.name = '',
    this.email = '',
    this.image = '',
    this.phone = '',
    this.role = '',
    this.authType = '',
    this.token = '',
  });

  factory SocialGoogleLoginData.fromJson(Map<String, dynamic> json) =>
      SocialGoogleLoginData(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        email: APIHelper.getSafeString(json['email']),
        image: APIHelper.getSafeString(json['image']),
        phone: APIHelper.getSafeString(json['phone']),
        role: APIHelper.getSafeString(json['role']),
        authType: APIHelper.getSafeString(json['auth_type']),
        token: APIHelper.getSafeString(json['token']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'image': image,
        'phone': phone,
        'role': role,
        'auth_type': authType,
        'token': token,
      };

  static SocialGoogleLoginData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SocialGoogleLoginData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SocialGoogleLoginData();
}
