import 'package:car2gouser/models/core_api_responses/paginated_data_response.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class ShareRideHistoryResponse {
  bool error;
  String msg;
  PaginatedDataResponse<ShareRideHistoryDoc> data;

  ShareRideHistoryResponse(
      {this.error = false, this.msg = '', required this.data});

  factory ShareRideHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ShareRideHistoryResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: PaginatedDataResponse.getSafeObject(json['data'],
          docFromJson: (data) =>
              ShareRideHistoryDoc.getAPIResponseObjectSafeValue(data)),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory ShareRideHistoryResponse.empty() => ShareRideHistoryResponse(
        data: PaginatedDataResponse.empty(),
      );
  static ShareRideHistoryResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ShareRideHistoryResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ShareRideHistoryResponse.empty();
}

class ShareRideHistoryDoc {
  String id;
  ShareRideHistoryOffer offer;
  int seats;
  int rate;
  String status;
  DateTime createdAt;
  ShareRideHistoryUser user;
  DateTime date;
  String type;
  ShareRideHistoryFrom from;
  ShareRideHistoryTo to;
  int available;
  int pending;

  ShareRideHistoryDoc({
    this.id = '',
    required this.offer,
    this.seats = 0,
    this.rate = 0,
    this.status = '',
    required this.createdAt,
    required this.user,
    required this.date,
    this.type = '',
    required this.from,
    required this.to,
    this.available = 0,
    this.pending = 0,
  });

  factory ShareRideHistoryDoc.fromJson(Map<String, dynamic> json) =>
      ShareRideHistoryDoc(
        id: APIHelper.getSafeString(json['_id']),
        offer:
            ShareRideHistoryOffer.getAPIResponseObjectSafeValue(json['offer']),
        seats: APIHelper.getSafeInt(json['seats']),
        rate: APIHelper.getSafeInt(json['rate']),
        status: APIHelper.getSafeString(json['status']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        user: ShareRideHistoryUser.getAPIResponseObjectSafeValue(json['user']),
        date: APIHelper.getSafeDateTime(json['date']),
        type: APIHelper.getSafeString(json['type']),
        from: ShareRideHistoryFrom.getAPIResponseObjectSafeValue(json['from']),
        to: ShareRideHistoryTo.getAPIResponseObjectSafeValue(json['to']),
        available: APIHelper.getSafeInt(json['available']),
        pending: APIHelper.getSafeInt(json['pending']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'offer': offer.toJson(),
        'seats': seats,
        'rate': rate,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'user': user.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'type': type,
        'from': from.toJson(),
        'to': to.toJson(),
        'available': available,
        'pending': pending,
      };

  factory ShareRideHistoryDoc.empty() => ShareRideHistoryDoc(
      offer: ShareRideHistoryOffer.empty(),
      createdAt: AppComponents.defaultUnsetDateTime,
      date: AppComponents.defaultUnsetDateTime,
      from: ShareRideHistoryFrom.empty(),
      to: ShareRideHistoryTo.empty(),
      user: ShareRideHistoryUser());
  static ShareRideHistoryDoc getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ShareRideHistoryDoc.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ShareRideHistoryDoc.empty();
}

class ShareRideHistoryTo {
  String address;
  ShareRideHistoryLocation location;

  ShareRideHistoryTo({this.address = '', required this.location});

  factory ShareRideHistoryTo.fromJson(Map<String, dynamic> json) =>
      ShareRideHistoryTo(
        address: APIHelper.getSafeString(json['address']),
        location: ShareRideHistoryLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory ShareRideHistoryTo.empty() => ShareRideHistoryTo(
        location: ShareRideHistoryLocation(),
      );
  static ShareRideHistoryTo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ShareRideHistoryTo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ShareRideHistoryTo.empty();
}

class ShareRideHistoryOffer {
  String id;
  ShareRideHistoryUser user;
  DateTime date;
  String type;
  ShareRideHistoryFrom from;
  ShareRideHistoryTo to;
  int seats;
  int rate;
  String status;
  DateTime createdAt;

  ShareRideHistoryOffer({
    this.id = '',
    required this.user,
    required this.date,
    this.type = '',
    required this.from,
    required this.to,
    this.seats = 0,
    this.rate = 0,
    this.status = '',
    required this.createdAt,
  });

  factory ShareRideHistoryOffer.fromJson(Map<String, dynamic> json) =>
      ShareRideHistoryOffer(
        id: APIHelper.getSafeString(json['_id']),
        user: ShareRideHistoryUser.getAPIResponseObjectSafeValue(json['user']),
        date: APIHelper.getSafeDateTime(json['date']),
        type: APIHelper.getSafeString(json['type']),
        from: ShareRideHistoryFrom.getAPIResponseObjectSafeValue(json['from']),
        to: ShareRideHistoryTo.getAPIResponseObjectSafeValue(json['to']),
        seats: APIHelper.getSafeInt(json['seats']),
        rate: APIHelper.getSafeInt(json['rate']),
        status: APIHelper.getSafeString(json['status']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'type': type,
        'from': from.toJson(),
        'to': to.toJson(),
        'seats': seats,
        'rate': rate,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
      };

  factory ShareRideHistoryOffer.empty() => ShareRideHistoryOffer(
      user: ShareRideHistoryUser(),
      date: AppComponents.defaultUnsetDateTime,
      from: ShareRideHistoryFrom.empty(),
      to: ShareRideHistoryTo.empty(),
      createdAt: AppComponents.defaultUnsetDateTime);
  static ShareRideHistoryOffer getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ShareRideHistoryOffer.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ShareRideHistoryOffer.empty();
}

class ShareRideHistoryFrom {
  String address;
  ShareRideHistoryLocation location;

  ShareRideHistoryFrom({this.address = '', required this.location});

  factory ShareRideHistoryFrom.fromJson(Map<String, dynamic> json) =>
      ShareRideHistoryFrom(
        address: APIHelper.getSafeString(json['address']),
        location: ShareRideHistoryLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory ShareRideHistoryFrom.empty() => ShareRideHistoryFrom(
        location: ShareRideHistoryLocation(),
      );
  static ShareRideHistoryFrom getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ShareRideHistoryFrom.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ShareRideHistoryFrom.empty();
}

class ShareRideHistoryLocation {
  double lat;
  double lng;

  ShareRideHistoryLocation({this.lat = 0, this.lng = 0});

  factory ShareRideHistoryLocation.fromJson(Map<String, dynamic> json) =>
      ShareRideHistoryLocation(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static ShareRideHistoryLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ShareRideHistoryLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ShareRideHistoryLocation();
}

class ShareRideHistoryUser {
  String id;
  String name;
  String phone;
  String image;

  ShareRideHistoryUser(
      {this.id = '', this.name = '', this.phone = '', this.image = ''});

  factory ShareRideHistoryUser.fromJson(Map<String, dynamic> json) =>
      ShareRideHistoryUser(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        phone: APIHelper.getSafeString(json['phone']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'phone': phone,
        'image': image,
      };

  static ShareRideHistoryUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ShareRideHistoryUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ShareRideHistoryUser();
}
