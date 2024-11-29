import 'package:car2gouser/utils/helpers/api_helper.dart';

class PoolingNewRequestSocketResponse {
  String offer;

  PoolingNewRequestSocketResponse({this.offer = ''});

  factory PoolingNewRequestSocketResponse.fromJson(Map<String, dynamic> json) {
    return PoolingNewRequestSocketResponse(
      offer: APIHelper.getSafeString(json['offer']),
    );
  }

  Map<String, dynamic> toJson() => {
        'offer': offer,
      };

  static PoolingNewRequestSocketResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PoolingNewRequestSocketResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PoolingNewRequestSocketResponse();
}
