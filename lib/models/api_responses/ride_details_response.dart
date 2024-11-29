import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class RideDetailsResponse {
  bool error;
  String msg;
  RideDetailsData data;

  RideDetailsResponse({this.error = false, this.msg = '', required this.data});

  factory RideDetailsResponse.fromJson(Map<String, dynamic> json) {
    return RideDetailsResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: RideDetailsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory RideDetailsResponse.empty() => RideDetailsResponse(
        data: RideDetailsData.empty(),
      );
  static RideDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsResponse.empty();
}

class RideDetailsData {
  RideDetailsFrom from;
  RideDetailsTo to;
  RideDetailsDistance distance;
  RideDetailsDuration duration;
  String id;
  RideDetailsDriver driver;
  RideDetailsUser user;
  RideDetailsRide ride;
  double total;
  String otp;
  Payment payment;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String cancelReason;

  RideDetailsData(
      {required this.from,
      required this.to,
      required this.distance,
      required this.duration,
      this.id = '',
      required this.driver,
      required this.user,
      required this.payment,
      required this.ride,
      this.total = 0,
      this.otp = '',
      this.status = '',
      required this.createdAt,
      required this.updatedAt,
      this.cancelReason = ''});

  factory RideDetailsData.fromJson(Map<String, dynamic> json) =>
      RideDetailsData(
        from: RideDetailsFrom.getAPIResponseObjectSafeValue(json['from']),
        to: RideDetailsTo.getAPIResponseObjectSafeValue(json['to']),
        distance:
            RideDetailsDistance.getAPIResponseObjectSafeValue(json['distance']),
        duration:
            RideDetailsDuration.getAPIResponseObjectSafeValue(json['duration']),
        id: APIHelper.getSafeString(json['_id']),
        payment: Payment.getAPIResponseObjectSafeValue(json['payment']),
        driver: RideDetailsDriver.getAPIResponseObjectSafeValue(json['driver']),
        user: RideDetailsUser.getAPIResponseObjectSafeValue(json['user']),
        ride: RideDetailsRide.getAPIResponseObjectSafeValue(json['ride']),
        total: APIHelper.getSafeDouble(json['total']),
        otp: APIHelper.getSafeString(json['otp']),
        status: APIHelper.getSafeString(json['status']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
        cancelReason: APIHelper.getSafeString(json['cancel_reason']),
      );

  Map<String, dynamic> toJson() => {
        'from': from.toJson(),
        'to': to.toJson(),
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        '_id': id,
        'driver': driver.toJson(),
        'user': user.toJson(),
        'ride': ride.toJson(),
        'total': total,
        'otp': otp,
        'status': status,
        'payment': payment.toJson(),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'cancel_reason': cancelReason,
      };

  factory RideDetailsData.empty() => RideDetailsData(
      from: RideDetailsFrom.empty(),
      to: RideDetailsTo.empty(),
      distance: RideDetailsDistance(),
      payment: Payment(),
      duration: RideDetailsDuration(),
      driver: RideDetailsDriver(),
      user: RideDetailsUser(),
      ride: RideDetailsRide.empty(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static RideDetailsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsData.empty();
}

class Payment {
  String method;
  String status;
  String transactionId;
  double amount;

  Payment({
    this.method = '',
    this.status = '',
    this.amount = 0,
    this.transactionId = '',
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        method: APIHelper.getSafeString(json['method']),
        status: APIHelper.getSafeString(json['status']),
        transactionId: APIHelper.getSafeString(json['transaction_id']),
        amount: APIHelper.getSafeDouble(json['amount']),
      );

  Map<String, dynamic> toJson() => {
        'method': method,
        'status': status,
        'transaction_id': transactionId,
        'amount': amount,
      };

  static Payment getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Payment.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Payment();
}

class RideDetailsDistance {
  String text;
  int value;

  RideDetailsDistance({this.text = '', this.value = 0});

  factory RideDetailsDistance.fromJson(Map<String, dynamic> json) =>
      RideDetailsDistance(
        text: APIHelper.getSafeString(json['text']),
        value: APIHelper.getSafeInt(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static RideDetailsDistance getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsDistance.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsDistance();
}

class RideDetailsDriver {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  RideDetailsDriver({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory RideDetailsDriver.fromJson(Map<String, dynamic> json) =>
      RideDetailsDriver(
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

  static RideDetailsDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsDriver();
}

class RideDetailsDuration {
  String text;
  int value;

  RideDetailsDuration({this.text = '', this.value = 0});

  factory RideDetailsDuration.fromJson(Map<String, dynamic> json) =>
      RideDetailsDuration(
        text: APIHelper.getSafeString(json['text']),
        value: APIHelper.getSafeInt(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static RideDetailsDuration getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsDuration.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsDuration();
}

class RideDetailsFrom {
  RideDetailsLocation location;
  String address;

  RideDetailsFrom({required this.location, this.address = ''});

  factory RideDetailsFrom.fromJson(Map<String, dynamic> json) =>
      RideDetailsFrom(
        location:
            RideDetailsLocation.getAPIResponseObjectSafeValue(json['location']),
        address: APIHelper.getSafeString(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'address': address,
      };

  factory RideDetailsFrom.empty() => RideDetailsFrom(
        location: RideDetailsLocation(),
      );
  static RideDetailsFrom getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsFrom.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsFrom.empty();
}

class RideDetailsTo {
  RideDetailsLocation location;
  String address;

  RideDetailsTo({required this.location, this.address = ''});

  factory RideDetailsTo.fromJson(Map<String, dynamic> json) => RideDetailsTo(
        location:
            RideDetailsLocation.getAPIResponseObjectSafeValue(json['location']),
        address: APIHelper.getSafeString(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'address': address,
      };

  factory RideDetailsTo.empty() => RideDetailsTo(
        location: RideDetailsLocation(),
      );
  static RideDetailsTo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsTo.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsTo.empty();
}

class RideDetailsLocation {
  double lat;
  double lng;

  RideDetailsLocation({this.lat = 0, this.lng = 0});

  factory RideDetailsLocation.fromJson(Map<String, dynamic> json) =>
      RideDetailsLocation(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static RideDetailsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsLocation();
}

class RideDetailsRide {
  String id;
  RideDetailsVehicle vehicle;

  RideDetailsRide({this.id = '', required this.vehicle});

  factory RideDetailsRide.fromJson(Map<String, dynamic> json) =>
      RideDetailsRide(
        id: APIHelper.getSafeString(json['_id']),
        vehicle:
            RideDetailsVehicle.getAPIResponseObjectSafeValue(json['vehicle']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
      };

  factory RideDetailsRide.empty() => RideDetailsRide(
        vehicle: RideDetailsVehicle(),
      );
  static RideDetailsRide getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsRide.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsRide.empty();
}

class RideDetailsVehicle {
  String id;
  String name;
  String model;
  List<String> images;
  int capacity;
  String color;

  RideDetailsVehicle({
    this.id = '',
    this.name = '',
    this.model = '',
    this.images = const [],
    this.capacity = 0,
    this.color = '',
  });

  factory RideDetailsVehicle.fromJson(Map<String, dynamic> json) =>
      RideDetailsVehicle(
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

  static RideDetailsVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsVehicle();
}

class RideDetailsUser {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  RideDetailsUser(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = ''});

  factory RideDetailsUser.fromJson(Map<String, dynamic> json) =>
      RideDetailsUser(
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

  static RideDetailsUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideDetailsUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideDetailsUser();
}
