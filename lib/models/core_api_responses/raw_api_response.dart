import 'package:car2gouser/models/core_api_responses/api_error_details_response.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class RawAPIResponse {
  bool success;
  int statusCode;
  String message;
  String errorMessage;
  APIErrorDetails errorDetails;
  dynamic data;

  RawAPIResponse({
    required this.errorDetails,
    this.success = false,
    this.statusCode = -1,
    this.message = '',
    this.errorMessage = '',
    this.data,
  });
  factory RawAPIResponse.empty() =>
      RawAPIResponse(errorDetails: APIErrorDetails());

  factory RawAPIResponse.fromJson(Map<String, dynamic> json) {
    return RawAPIResponse(
      success: APIHelper.getSafeBool(json['success']),
      statusCode: APIHelper.getSafeInt(json['statusCode']),
      message: APIHelper.getSafeString(json['message']),
      errorMessage: APIHelper.getSafeString(json['errorMessage']),
      errorDetails: APIErrorDetails.getSafeObject(json['errorDetails']),
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'statusCode': statusCode,
        'message': message,
        'errorMessage': errorMessage,
        'errorDetails': errorDetails.toJson(),
        'data': data,
      };

  static RawAPIResponse getAPIResponseObjectSafeValue<D>(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RawAPIResponse.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : RawAPIResponse.empty();
}
