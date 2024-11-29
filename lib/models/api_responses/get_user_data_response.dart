import 'package:car2gouser/utils/helpers/api_helper.dart';

class GetUserDataResponse {
  bool error;
  String msg;
  GetUserData data;

  GetUserDataResponse({this.error = false, this.msg = '', required this.data});

  factory GetUserDataResponse.fromJson(Map<String, dynamic> json) {
    return GetUserDataResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: GetUserData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory GetUserDataResponse.empty() => GetUserDataResponse(
        data: GetUserData(),
      );
  static GetUserDataResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? GetUserDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : GetUserDataResponse.empty();
}

class GetUserData {
  String id;
  String uid;
  String name;
  String email;
  String image;
  String role;

  GetUserData(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.email = '',
      this.image = '',
      this.role = ''});

  factory GetUserData.fromJson(Map<String, dynamic> json) => GetUserData(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        email: APIHelper.getSafeString(json['email']),
        image: APIHelper.getSafeString(json['image']),
        role: APIHelper.getSafeString(json['role']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'email': email,
        'image': image,
        'role': role,
      };

  static GetUserData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? GetUserData.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : GetUserData();
}
