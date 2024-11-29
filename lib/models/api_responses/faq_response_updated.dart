import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class FaqResponseUpdated {
  String id;
  String title;
  String description;
  String faqFor;
  DateTime createdAt;
  DateTime updatedAt;

  FaqResponseUpdated({
    this.id = '',
    this.title = '',
    this.description = '',
    this.faqFor = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory FaqResponseUpdated.fromJson(Map<String, dynamic> json) =>
      FaqResponseUpdated(
        id: APIHelper.getSafeString(json['_id']),
        title: APIHelper.getSafeString(json['title']),
        description: APIHelper.getSafeString(json['description']),
        faqFor: APIHelper.getSafeString(json['for']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'for': faqFor,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory FaqResponseUpdated.empty() => FaqResponseUpdated(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static FaqResponseUpdated getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FaqResponseUpdated.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : FaqResponseUpdated.empty();
}
