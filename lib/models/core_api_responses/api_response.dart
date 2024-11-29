import 'package:car2gouser/models/core_api_responses/api_error_details_response.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class APIResponse<T> {
  APIResponse({
    required this.data,
    required this.errorDetails,
    this.success = false,
    this.statusCode = -1,
    this.message = '',
    this.errorMessage = '',
  });

  factory APIResponse.empty({required T emptyData}) =>
      APIResponse<T>(data: emptyData, errorDetails: APIErrorDetails());

  factory APIResponse.fromJson(
    Map<String, dynamic> json, {
    required T Function(dynamic unsafeData) getDataSafeObject,
  }) =>
      APIResponse<T>(
        success: APIHelper.getSafeBool(json['success']),
        statusCode: APIHelper.getSafeInt(json['statusCode']),
        message: APIHelper.getSafeString(json['message']),
        errorMessage: APIHelper.getSafeString(json['errorMessage']),
        errorDetails: APIErrorDetails.getSafeObject(json['errorDetails']),
        data: getDataSafeObject(json['data']),
      );

  factory APIResponse.getSafeObject({
    required T emptyObject,
    required T Function(dynamic data) dataFromJson,
    required dynamic unsafeObject,
  }) =>
      APIHelper.isAPIResponseObjectSafe(unsafeObject)
          ? APIResponse<T>.fromJson(
              unsafeObject as Map<String, dynamic>,
              getDataSafeObject: dataFromJson,
            )
          : APIResponse<T>.empty(emptyData: emptyObject);

  bool success;
  int statusCode;
  String message;
  String errorMessage;
  APIErrorDetails errorDetails;
  final T data;

  Map<String, dynamic> toJson(
    Map<String, dynamic> Function(T data) dataToJson,
  ) =>
      {
        'success': success,
        'statusCode': statusCode,
        'message': message,
        'errorMessage': errorMessage,
        'errorDetails': errorDetails.toJson(),
        'data': dataToJson(data),
      };

  bool get error => success == false;
}
