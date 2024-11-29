import 'package:car2gouser/models/api_responses/user_details_response.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class CountryListResponse {
  bool error;
  String msg;
  List<UserDetailsCountry> data;

  CountryListResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory CountryListResponse.fromJson(Map<String, dynamic> json) {
    return CountryListResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: APIHelper.getSafeList(json['data'])
          .map((e) => UserDetailsCountry.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static CountryListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CountryListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CountryListResponse();
}
