import 'package:car2gouser/models/core_api_responses/paginated_data_response.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class FaqResponse {
  bool error;
  String msg;
  PaginatedDataResponse<FaqItems> data;

  FaqResponse({this.error = false, this.msg = '', required this.data});

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
        error: APIHelper.getSafeBool(json['error']),
        msg: APIHelper.getSafeString(json['msg']),
        data: PaginatedDataResponse.getSafeObject(
          json['data'],
          docFromJson: (data) => FaqItems.getAPIResponseObjectSafeValue(data),
        ),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory FaqResponse.empty() => FaqResponse(
        data: PaginatedDataResponse.empty(),
      );
  static FaqResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FaqResponse.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : FaqResponse.empty();
}

class FaqItems {
  String id;
  String question;
  String answer;
  DateTime createdAt;
  DateTime updatedAt;

  FaqItems({
    this.id = '',
    this.question = '',
    this.answer = '',
    required this.updatedAt,
    required this.createdAt,
  });

  factory FaqItems.fromJson(Map<String, dynamic> json) => FaqItems(
        id: APIHelper.getSafeString(json['_id']),
        question: APIHelper.getSafeString(json['question']),
        answer: APIHelper.getSafeString(json['answer']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'question': question,
        'answer': answer,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory FaqItems.empty() => FaqItems(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static FaqItems getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FaqItems.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : FaqItems.empty();
}
