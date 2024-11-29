import 'package:car2gouser/utils/helpers/api_helper.dart';

class ForgotPasswordVerifyOTP {
  String email;
  String phone;
  String accessToken;

  ForgotPasswordVerifyOTP(
      {this.email = '', this.phone = '', this.accessToken = ''});

  factory ForgotPasswordVerifyOTP.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordVerifyOTP(
        email: APIHelper.getSafeString(json['email']),
        phone: APIHelper.getSafeString(json['phone']),
        accessToken: APIHelper.getSafeString(json['accessToken']),
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'phone': phone,
        'accessToken': accessToken,
      };

  static ForgotPasswordVerifyOTP getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ForgotPasswordVerifyOTP.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ForgotPasswordVerifyOTP();
}
