import 'package:car2gouser/utils/helpers/api_helper.dart';

class FindAccountResponse {
  bool error;
  String msg;
  FindAccountData data;

  FindAccountResponse({this.error = false, this.msg = '', required this.data});

  factory FindAccountResponse.fromJson(Map<String, dynamic> json) {
    return FindAccountResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: FindAccountData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory FindAccountResponse.empty() => FindAccountResponse(
        data: FindAccountData(),
      );
  static FindAccountResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FindAccountResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : FindAccountResponse.empty();
}

class FindAccountData {
  bool account;
  String role;

  FindAccountData({this.account = false, this.role = ''});

  factory FindAccountData.fromJson(Map<String, dynamic> json) =>
      FindAccountData(
        account: APIHelper.getSafeBool(json['account']),
        role: APIHelper.getSafeString(json['role']),
      );

  Map<String, dynamic> toJson() => {
        'account': account,
        'role': role,
      };

  static FindAccountData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FindAccountData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : FindAccountData();
}

class FindAccountDataRefactored {
  String id;
  String name;

  FindAccountDataRefactored({this.id = '', this.name = ''});

  factory FindAccountDataRefactored.fromJson(Map<String, dynamic> json) =>
      FindAccountDataRefactored(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static FindAccountDataRefactored getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FindAccountDataRefactored.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : FindAccountDataRefactored();
}
