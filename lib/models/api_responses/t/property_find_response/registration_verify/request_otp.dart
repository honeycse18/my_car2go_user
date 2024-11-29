import 'package:car2gouser/utils/helpers/api_helper.dart';

class RequestOtp {
  String type;
  String identifier;

  RequestOtp({this.type = '', this.identifier = ''});

  factory RequestOtp.fromJson(Map<String, dynamic> json) => RequestOtp(
        type: APIHelper.getSafeString(json['type']),
        identifier: APIHelper.getSafeString(json['identifier']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'identifier': identifier,
      };

  static RequestOtp getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RequestOtp.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : RequestOtp();
}
