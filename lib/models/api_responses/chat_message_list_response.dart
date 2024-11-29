import 'package:car2gouser/models/core_api_responses/paginated_data_response.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class ChatMessageListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<ChatMessageListItem> data;

  ChatMessageListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory ChatMessageListResponse.fromJson(Map<String, dynamic> json) {
    return ChatMessageListResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: PaginatedDataResponse.getSafeObject(
        json['data'],
        docFromJson: (data) =>
            ChatMessageListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory ChatMessageListResponse.empty() => ChatMessageListResponse(
        data: PaginatedDataResponse.empty(),
      );
  static ChatMessageListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChatMessageListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ChatMessageListResponse.empty();
}

class ChatMessageListItem {
  String id;
  From from;
  To to;
  String message;
  bool read;
  DateTime createdAt;
  DateTime updatedAt;

  ChatMessageListItem({
    this.id = '',
    required this.from,
    required this.to,
    this.message = '',
    this.read = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatMessageListItem.fromJson(Map<String, dynamic> json) =>
      ChatMessageListItem(
        id: APIHelper.getSafeString(json['_id']),
        from: From.getAPIResponseObjectSafeValue(json['from']),
        to: To.getAPIResponseObjectSafeValue(json['to']),
        message: APIHelper.getSafeString(json['message']),
        read: APIHelper.getSafeBool(json['read']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'from': from.toJson(),
        'to': to.toJson(),
        'message': message,
        'read': read,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory ChatMessageListItem.empty() => ChatMessageListItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        from: From(),
        to: To(),
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static ChatMessageListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChatMessageListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ChatMessageListItem.empty();
}

class From {
  String id;
  String uid;
  String name;
  String image;

  From({this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory From.fromJson(Map<String, dynamic> json) => From(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'image': image,
      };

  static From getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? From.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : From();
}

class To {
  String id;
  String uid;
  String name;
  String image;

  To({this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory To.fromJson(Map<String, dynamic> json) => To(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'image': image,
      };

  static To getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? To.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : To();
}
