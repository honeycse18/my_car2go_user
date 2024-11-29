import 'package:car2gouser/utils/helpers/api_helper.dart';

class DeleteAddressResponse {
  bool success;
  int statusCode;
  String message;

  DeleteAddressResponse(
      {this.success = false, this.statusCode = 0, this.message = ''});

  factory DeleteAddressResponse.fromJson(Map<String, dynamic> json) {
    return DeleteAddressResponse(
      success: APIHelper.getSafeBool(json['success']),
      statusCode: APIHelper.getSafeInt(json['statusCode']),
      message: APIHelper.getSafeString(json['message']),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'statusCode': statusCode,
        'message': message,
      };

  static DeleteAddressResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeleteAddressResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DeleteAddressResponse();
}
