import 'package:car2gouser/utils/helpers/api_helper.dart';

class Login {
  User user;
  String accessToken;

  Login({required this.user, this.accessToken = ''});

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        user: User.getSafeObject(json['user']),
        accessToken: APIHelper.getSafeString(json['accessToken']),
      );

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'accessToken': accessToken,
      };

  factory Login.empty() => Login(
        user: User(),
      );
  static Login getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Login.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Login.empty();
}

class User {
  String id;
  String name;
  String email;
  String role;

  User({this.id = '', this.name = '', this.email = '', this.role = ''});

  factory User.fromJson(Map<String, dynamic> json) => User(
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

  static User getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? User.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : User();
}
