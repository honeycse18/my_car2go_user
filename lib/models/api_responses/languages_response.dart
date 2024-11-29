import 'package:car2gouser/utils/helpers/api_helper.dart';

class LanguagesResponse {
  bool error;
  String msg;
  List<Language> data;

  LanguagesResponse({this.error = false, this.msg = '', this.data = const []});

  factory LanguagesResponse.fromJson(Map<String, dynamic> json) {
    return LanguagesResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: APIHelper.getSafeList(json['data'])
          .map((e) => Language.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static LanguagesResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LanguagesResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : LanguagesResponse();
}

class Language {
  String id;
  String name;
  String code;
  String flag;
  bool active;
  bool isDefault;

  Language({
    this.id = '',
    this.name = '',
    this.code = '',
    this.flag = '',
    this.active = false,
    this.isDefault = false,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        code: APIHelper.getSafeString(json['code']),
        flag: APIHelper.getSafeString(json['flag']),
        active: APIHelper.getSafeBool(json['active']),
        isDefault: APIHelper.getSafeBool(json['default']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'flag': flag,
        'active': active,
        'default': isDefault,
      };

  static Language getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Language.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Language();
}
