import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/constants/app_components.dart';

class SupportTextResponse {
  bool error;
  String msg;
  SupportTextItem data;

  SupportTextResponse({this.error = false, this.msg = '', required this.data});

  factory SupportTextResponse.fromJson(Map<String, dynamic> json) {
    return SupportTextResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: SupportTextItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory SupportTextResponse.empty() =>
      SupportTextResponse(data: SupportTextItem.empty());
  static SupportTextResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SupportTextResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SupportTextResponse.empty();
}

class SupportTextItem {
  String id;
  String title;
  String slug;
  String contentType;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  SupportTextItem({
    this.id = '',
    this.title = '',
    this.slug = '',
    this.contentType = '',
    this.content = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory SupportTextItem.fromJson(Map<String, dynamic> json) =>
      SupportTextItem(
        id: APIHelper.getSafeString(json['_id']),
        title: APIHelper.getSafeString(json['title']),
        slug: APIHelper.getSafeString(json['slug']),
        contentType: APIHelper.getSafeString(json['content_type']),
        content: APIHelper.getSafeString(json['content']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'slug': slug,
        'content_type': contentType,
        'content': content,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory SupportTextItem.empty() => SupportTextItem(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static SupportTextItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SupportTextItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SupportTextItem.empty();
}
