import 'package:car2gouser/models/core_api_responses/api_error_details_response.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class APIListResponse<T> {
  APIListResponse({
    required this.errorDetails,
    this.success = false,
    this.statusCode = -1,
    this.message = '',
    this.errorMessage = '',
    this.data = const [],
  });
  factory APIListResponse.empty() =>
      APIListResponse(errorDetails: APIErrorDetails());

  factory APIListResponse.fromJson(
    Map<String, dynamic> json, {
    required T Function(dynamic unsafeData) getDataSafeObject,
  }) =>
      APIListResponse<T>(
        data: APIHelper.getSafeList<dynamic>(json['data'])
            .map<T>(getDataSafeObject)
            .toList(),
        success: APIHelper.getSafeBool(json['success']),
        statusCode: APIHelper.getSafeInt(json['statusCode']),
        message: APIHelper.getSafeString(json['message']),
        errorMessage: APIHelper.getSafeString(json['errorMessage']),
        errorDetails: APIErrorDetails.getSafeObject(json['errorDetails']),
      );

  factory APIListResponse.getSafeObject({
    required T Function(dynamic data) dataFromJson,
    dynamic unsafeObject,
  }) =>
      APIHelper.isAPIResponseObjectSafe(unsafeObject)
          ? APIListResponse.fromJson(
              unsafeObject as Map<String, dynamic>,
              getDataSafeObject: dataFromJson,
            )
          : APIListResponse.empty();

  final List<T> data;
  bool success;
  int statusCode;
  String message;
  String errorMessage;
  APIErrorDetails errorDetails;

  Map<String, dynamic> toJson(
    Map<String, dynamic> Function(T data) dataToJson,
  ) =>
      {
        'success': success,
        'statusCode': statusCode,
        'message': message,
        'errorMessage': errorMessage,
        'errorDetails': errorDetails.toJson(),
        'data': data.map(dataToJson),
      };
  bool get error => success == false;
}
