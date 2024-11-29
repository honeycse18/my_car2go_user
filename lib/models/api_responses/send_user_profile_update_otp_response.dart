import 'package:car2gouser/utils/helpers/api_helper.dart';

class SendUserProfileUpdateOtpResponse {
  String action;
  String email;

  SendUserProfileUpdateOtpResponse({this.action = '', this.email = ''});

  factory SendUserProfileUpdateOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendUserProfileUpdateOtpResponse(
      action: APIHelper.getSafeString(json['action']),
      email: APIHelper.getSafeString(json['email']),
    );
  }

  Map<String, dynamic> toJson() => {
        'action': action,
        'email': email,
      };

  static SendUserProfileUpdateOtpResponse getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SendUserProfileUpdateOtpResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SendUserProfileUpdateOtpResponse();
}
