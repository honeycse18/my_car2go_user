import 'package:car2gouser/utils/helpers/api_helper.dart';

class ForgetPasswordResponse {
  String type;
  String identifier;

  ForgetPasswordResponse({this.type = '', this.identifier = ''});

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponse(
      type: APIHelper.getSafeString(json['type']),
      identifier: APIHelper.getSafeString(json['identifier']),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'identifier': identifier,
      };

  static ForgetPasswordResponse getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ForgetPasswordResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ForgetPasswordResponse();
}
