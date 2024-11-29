import 'package:car2gouser/models/core_api_responses/paginated_data_response.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class MessageUserListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<MessageUserListItem> data;

  MessageUserListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory MessageUserListResponse.fromJson(Map<String, dynamic> json) {
    return MessageUserListResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: PaginatedDataResponse.getSafeObject(
        json['data'],
        docFromJson: (data) =>
            MessageUserListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory MessageUserListResponse.empty() => MessageUserListResponse(
        data: PaginatedDataResponse.empty(),
      );
  static MessageUserListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MessageUserListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MessageUserListResponse.empty();
}

class MessageUserListItem {
  String id;
  String message;
  DateTime createdAt;
  bool read;
  bool mine;
  User user;

  MessageUserListItem(
      {this.id = '',
      this.message = '',
      required this.createdAt,
      this.read = false,
      this.mine = false,
      required this.user});

  factory MessageUserListItem.fromJson(Map<String, dynamic> json) =>
      MessageUserListItem(
        id: APIHelper.getSafeString(json['_id']),
        message: APIHelper.getSafeString(json['message']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        read: APIHelper.getSafeBool(json['read']),
        mine: APIHelper.getSafeBool(json['mine']),
        user: User.getAPIResponseObjectSafeValue(json['user']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'message': message,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'read': read,
        'mine': mine,
        'user': user.toJson(),
      };

  factory MessageUserListItem.empty() => MessageUserListItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        user: User(),
      );
  static MessageUserListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MessageUserListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MessageUserListItem.empty();
}

class User {
  String uid;
  String name;
  String image;

  User({this.uid = '', this.name = '', this.image = ''});

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'image': image,
      };

  static User getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? User.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : User();
}
