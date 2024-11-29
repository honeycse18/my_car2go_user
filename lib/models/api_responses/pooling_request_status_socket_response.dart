import 'package:car2gouser/utils/helpers/api_helper.dart';

class PoolingRequestStatusSocketResponse {
  String request;
  String offer;
  String status;

  PoolingRequestStatusSocketResponse({
    this.request = '',
    this.offer = '',
    this.status = '',
  });

  factory PoolingRequestStatusSocketResponse.fromJson(
      Map<String, dynamic> json) {
    return PoolingRequestStatusSocketResponse(
      request: APIHelper.getSafeString(json['request']),
      offer: APIHelper.getSafeString(json['offer']),
      status: APIHelper.getSafeString(json['status']),
    );
  }

  Map<String, dynamic> toJson() => {
        'request': request,
        'offer': offer,
        'status': status,
      };

  static PoolingRequestStatusSocketResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PoolingRequestStatusSocketResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PoolingRequestStatusSocketResponse();
}
