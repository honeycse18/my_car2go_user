import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class PostPoolingRequestResponse {
  bool error;
  String msg;
  PostPullingRequestData data;

  PostPoolingRequestResponse(
      {this.error = false, this.msg = '', required this.data});

  factory PostPoolingRequestResponse.fromJson(Map<String, dynamic> json) {
    return PostPoolingRequestResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: PostPullingRequestData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory PostPoolingRequestResponse.empty() => PostPoolingRequestResponse(
        data: PostPullingRequestData.empty(),
      );
  static PostPoolingRequestResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PostPoolingRequestResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PostPoolingRequestResponse.empty();
}

class PostPullingRequestData {
  String user;
  DateTime date;
  String type;
  PostPullingRequestFrom from;
  PostPullingRequestTo to;
  PostPullingRequestLocation location;
  int seats;
  int rate;
  String status;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  PostPullingRequestData({
    this.user = '',
    required this.date,
    this.type = '',
    required this.from,
    required this.to,
    required this.location,
    this.seats = 0,
    this.rate = 0,
    this.status = '',
    this.id = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory PostPullingRequestData.fromJson(Map<String, dynamic> json) =>
      PostPullingRequestData(
        user: APIHelper.getSafeString(json['user']),
        date: APIHelper.getSafeDateTime(json['date']),
        type: APIHelper.getSafeString(json['type']),
        from:
            PostPullingRequestFrom.getAPIResponseObjectSafeValue(json['from']),
        to: PostPullingRequestTo.getAPIResponseObjectSafeValue(json['to']),
        location: PostPullingRequestLocation.getAPIResponseObjectSafeValue(
            json['location']),
        seats: APIHelper.getSafeInt(json['seats']),
        rate: APIHelper.getSafeInt(json['rate']),
        status: APIHelper.getSafeString(json['status']),
        id: APIHelper.getSafeString(json['_id']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
        v: APIHelper.getSafeInt(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        'user': user,
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'type': type,
        'from': from.toJson(),
        'to': to.toJson(),
        'location': location.toJson(),
        'seats': seats,
        'rate': rate,
        'status': status,
        '_id': id,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory PostPullingRequestData.empty() => PostPullingRequestData(
      date: AppComponents.defaultUnsetDateTime,
      from: PostPullingRequestFrom.empty(),
      to: PostPullingRequestTo.empty(),
      location: PostPullingRequestLocation(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static PostPullingRequestData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PostPullingRequestData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PostPullingRequestData.empty();
}

class PostPullingRequestTo {
  String address;
  PostPullingRequestLocation location;

  PostPullingRequestTo({this.address = '', required this.location});

  factory PostPullingRequestTo.fromJson(Map<String, dynamic> json) =>
      PostPullingRequestTo(
        address: APIHelper.getSafeString(json['address']),
        location: PostPullingRequestLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory PostPullingRequestTo.empty() => PostPullingRequestTo(
        location: PostPullingRequestLocation(),
      );
  static PostPullingRequestTo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PostPullingRequestTo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PostPullingRequestTo.empty();
}

class PostPullingRequestLocation {
  double lat;
  double lng;

  PostPullingRequestLocation({this.lat = 0, this.lng = 0});

  factory PostPullingRequestLocation.fromJson(Map<String, dynamic> json) =>
      PostPullingRequestLocation(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static PostPullingRequestLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PostPullingRequestLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PostPullingRequestLocation();
}

class PostPullingRequestFrom {
  String address;
  PostPullingRequestLocation location;

  PostPullingRequestFrom({this.address = '', required this.location});

  factory PostPullingRequestFrom.fromJson(Map<String, dynamic> json) =>
      PostPullingRequestFrom(
        address: APIHelper.getSafeString(json['address']),
        location: PostPullingRequestLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory PostPullingRequestFrom.empty() => PostPullingRequestFrom(
        location: PostPullingRequestLocation(),
      );
  static PostPullingRequestFrom getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PostPullingRequestFrom.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PostPullingRequestFrom.empty();
}
