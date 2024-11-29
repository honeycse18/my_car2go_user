import 'package:car2gouser/models/core_api_responses/paginated_data_response.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class RideHistoryResponse {
  bool error;
  String msg;
  PaginatedDataResponse<RideHistoryDoc> data;

  RideHistoryResponse({this.error = false, this.msg = '', required this.data});

  factory RideHistoryResponse.fromJson(Map<String, dynamic> json) {
    return RideHistoryResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: PaginatedDataResponse.getSafeObject(json['data'],
          docFromJson: (data) =>
              RideHistoryDoc.getAPIResponseObjectSafeValue(data)),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory RideHistoryResponse.empty() => RideHistoryResponse(
        data: PaginatedDataResponse.empty(),
      );
  static RideHistoryResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryResponse.empty();
}

class RideHistoryDoc {
  RideHistoryFrom from;
  RideHistoryTo to;
  RideHistoryDistance distance;
  RideHistoryDuration duration;
  String id;
  String uid;
  RideHistoryDriver driver;
  RideHistoryUser user;
  RideHistoryRide ride;
  RideHistoryCurrency currency;
  DateTime date;
  bool schedule;
  double total;
  String otp;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String cancelReason;

  RideHistoryDoc({
    required this.from,
    required this.to,
    required this.distance,
    required this.duration,
    required this.currency,
    this.id = '',
    this.uid = '',
    required this.driver,
    required this.user,
    required this.ride,
    required this.date,
    this.schedule = false,
    this.total = 0,
    this.otp = '',
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
    this.cancelReason = '',
  });

  factory RideHistoryDoc.fromJson(Map<String, dynamic> json) => RideHistoryDoc(
        from: RideHistoryFrom.getAPIResponseObjectSafeValue(json['from']),
        to: RideHistoryTo.getAPIResponseObjectSafeValue(json['to']),
        distance:
            RideHistoryDistance.getAPIResponseObjectSafeValue(json['distance']),
        duration:
            RideHistoryDuration.getAPIResponseObjectSafeValue(json['duration']),
        id: APIHelper.getSafeString(json['_id']),
        driver: RideHistoryDriver.getAPIResponseObjectSafeValue(json['driver']),
        currency:
            RideHistoryCurrency.getAPIResponseObjectSafeValue(json['currency']),
        user: RideHistoryUser.getAPIResponseObjectSafeValue(json['user']),
        ride: RideHistoryRide.getAPIResponseObjectSafeValue(json['ride']),
        date: APIHelper.getSafeDateTime(json['date']),
        schedule: APIHelper.getSafeBool(json['schedule']),
        total: APIHelper.getSafeDouble(json['total']),
        otp: APIHelper.getSafeString(json['otp']),
        status: APIHelper.getSafeString(json['status']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
        v: APIHelper.getSafeInt(json['__v']),
        cancelReason: APIHelper.getSafeString(json['cancel_reason']),
      );

  Map<String, dynamic> toJson() => {
        'from': from.toJson(),
        'to': to.toJson(),
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        'currency': currency.toJson(),
        '_id': id,
        'driver': driver.toJson(),
        'user': user.toJson(),
        'ride': ride.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'schedule': schedule,
        'total': total,
        'otp': otp,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
        'cancel_reason': cancelReason,
      };

  factory RideHistoryDoc.empty() => RideHistoryDoc(
      from: RideHistoryFrom.empty(),
      to: RideHistoryTo.empty(),
      distance: RideHistoryDistance(),
      duration: RideHistoryDuration(),
      currency: RideHistoryCurrency(),
      driver: RideHistoryDriver(),
      user: RideHistoryUser(),
      ride: RideHistoryRide(),
      date: AppComponents.defaultUnsetDateTime,
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static RideHistoryDoc getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryDoc.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryDoc.empty();
}

class RideHistoryDistance {
  String text;
  int value;

  RideHistoryDistance({this.text = '', this.value = 0});

  factory RideHistoryDistance.fromJson(Map<String, dynamic> json) =>
      RideHistoryDistance(
        text: APIHelper.getSafeString(json['text']),
        value: APIHelper.getSafeInt(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static RideHistoryDistance getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryDistance.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryDistance();
}

class RideHistoryDriver {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  RideHistoryDriver({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory RideHistoryDriver.fromJson(Map<String, dynamic> json) =>
      RideHistoryDriver(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        phone: APIHelper.getSafeString(json['phone']),
        email: APIHelper.getSafeString(json['email']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
      };

  static RideHistoryDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryDriver();
}

class RideHistoryDuration {
  String text;
  int value;

  RideHistoryDuration({this.text = '', this.value = 0});

  factory RideHistoryDuration.fromJson(Map<String, dynamic> json) =>
      RideHistoryDuration(
        text: APIHelper.getSafeString(json['text']),
        value: APIHelper.getSafeInt(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static RideHistoryDuration getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryDuration.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryDuration();
}

class RideHistoryFrom {
  RideHistoryLocation location;
  String address;

  RideHistoryFrom({required this.location, this.address = ''});

  factory RideHistoryFrom.fromJson(Map<String, dynamic> json) =>
      RideHistoryFrom(
        location:
            RideHistoryLocation.getAPIResponseObjectSafeValue(json['location']),
        address: APIHelper.getSafeString(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'address': address,
      };

  factory RideHistoryFrom.empty() => RideHistoryFrom(
        location: RideHistoryLocation(),
      );
  static RideHistoryFrom getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryFrom.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryFrom.empty();
}

class RideHistoryLocation {
  double lat;
  double lng;

  RideHistoryLocation({this.lat = 0, this.lng = 0});

  factory RideHistoryLocation.fromJson(Map<String, dynamic> json) =>
      RideHistoryLocation(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static RideHistoryLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryLocation();
}

class RideHistoryTo {
  RideHistoryLocation location;
  String address;

  RideHistoryTo({required this.location, this.address = ''});

  factory RideHistoryTo.fromJson(Map<String, dynamic> json) => RideHistoryTo(
        location:
            RideHistoryLocation.getAPIResponseObjectSafeValue(json['location']),
        address: APIHelper.getSafeString(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'address': address,
      };

  factory RideHistoryTo.empty() => RideHistoryTo(
        location: RideHistoryLocation(),
      );
  static RideHistoryTo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryTo.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryTo.empty();
}

/* class RideHistoryRide {
  String id;
  String name;
  String model;
  List<String> images;
  int capacity;
  String color;
  // RideHistoryVehicle vehicle;

  RideHistoryRide({
    this.id = '',
    this.name = '',
    this.model = '',
    this.images = const [],
    this.capacity = 0,
    this.color = '',
  });

  factory RideHistoryRide.fromJson(Map<String, dynamic> json) =>
      RideHistoryRide(
        id: APIHelper.getSafeStringValue(json['_id']),
        vehicle:
            RideHistoryVehicle.getAPIResponseObjectSafeValue(json['vehicle']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
      };

  factory RideHistoryRide.empty() => RideHistoryRide(
        vehicle: RideHistoryVehicle(),
      );
  static RideHistoryRide getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryRide.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryRide.empty();
} */

class RideHistoryRide {
  String id;
  String name;
  String model;
  List<String> images;
  int capacity;
  String color;

  RideHistoryRide({
    this.id = '',
    this.name = '',
    this.model = '',
    this.images = const [],
    this.capacity = 0,
    this.color = '',
  });

  factory RideHistoryRide.fromJson(Map<String, dynamic> json) =>
      RideHistoryRide(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        model: APIHelper.getSafeString(json['model']),
        images: APIHelper.getSafeList(json['images'])
            .map((e) => APIHelper.getSafeString(e))
            .toList(),
        capacity: APIHelper.getSafeInt(json['capacity']),
        color: APIHelper.getSafeString(json['color']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'model': model,
        'images': images,
        'capacity': capacity,
        'color': color,
      };

  static RideHistoryRide getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryRide.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryRide();
}

class RideHistoryCurrency {
  String id;
  String name;
  String code;
  String symbol;
  int rate;

  RideHistoryCurrency({
    this.id = '',
    this.name = '',
    this.code = '',
    this.symbol = '',
    this.rate = 0,
  });

  factory RideHistoryCurrency.fromJson(Map<String, dynamic> json) =>
      RideHistoryCurrency(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        code: APIHelper.getSafeString(json['code']),
        symbol: APIHelper.getSafeString(json['symbol']),
        rate: APIHelper.getSafeInt(json['rate']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'symbol': symbol,
        'rate': rate,
      };

  static RideHistoryCurrency getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryCurrency.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryCurrency();
}

class RideHistoryUser {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  RideHistoryUser(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = ''});

  factory RideHistoryUser.fromJson(Map<String, dynamic> json) =>
      RideHistoryUser(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        phone: APIHelper.getSafeString(json['phone']),
        email: APIHelper.getSafeString(json['email']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
      };

  static RideHistoryUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideHistoryUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideHistoryUser();
}
