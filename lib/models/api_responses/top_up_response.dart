import 'package:car2gouser/utils/helpers/api_helper.dart';

class TopUpResponse {
  String id;
  String url;

  TopUpResponse({this.id = '', this.url = ''});

  factory TopUpResponse.fromJson(Map<String, dynamic> json) => TopUpResponse(
        id: APIHelper.getSafeString(json['id']),
        url: APIHelper.getSafeString(json['url']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
      };

  static TopUpResponse getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TopUpResponse.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : TopUpResponse();
}
