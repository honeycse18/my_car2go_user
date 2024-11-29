import 'package:car2gouser/utils/helpers/api_helper.dart';

class APIErrorDetails {
  int statusCode;
  String errorMessage;

  APIErrorDetails({this.statusCode = -1, this.errorMessage = ''});

  factory APIErrorDetails.fromJson(Map<String, dynamic> json) =>
      APIErrorDetails(
        statusCode: APIHelper.getSafeInt(json['statusCode']),
        errorMessage: APIHelper.getSafeString(json['errorMessage']),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'errorMessage': errorMessage,
      };

  static APIErrorDetails getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? APIErrorDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : APIErrorDetails();

  bool get isNotSet => statusCode == -1 && errorMessage.isEmpty;
  bool get isSet => isNotSet == false;
}
