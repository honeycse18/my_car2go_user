import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class NewRentSocketResponse {
  String uid;
  NewRentSocketUser user;
  String rent;
  NewRentSocketVehicle vehicle;
  NewRentSocketOwner owner;
  NewRentSocketDriver driver;
  DateTime date;
  String type;
  int rate;
  int quantity;
  int total;
  String status;
  String otp;
  NewRentSocketCurrency currency;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  NewRentSocketResponse({
    this.uid = '',
    required this.user,
    this.rent = '',
    required this.vehicle,
    required this.owner,
    required this.driver,
    required this.date,
    this.type = '',
    this.rate = 0,
    this.quantity = 0,
    this.total = 0,
    this.status = '',
    this.otp = '',
    required this.currency,
    this.id = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory NewRentSocketResponse.fromJson(Map<String, dynamic> json) {
    return NewRentSocketResponse(
      uid: APIHelper.getSafeString(json['uid']),
      user: NewRentSocketUser.getAPIResponseObjectSafeValue(json['user']),
      rent: APIHelper.getSafeString(json['rent']),
      vehicle:
          NewRentSocketVehicle.getAPIResponseObjectSafeValue(json['vehicle']),
      owner: NewRentSocketOwner.getAPIResponseObjectSafeValue(json['owner']),
      driver: NewRentSocketDriver.getAPIResponseObjectSafeValue(json['driver']),
      date: APIHelper.getSafeDateTime(json['date']),
      type: APIHelper.getSafeString(json['type']),
      rate: APIHelper.getSafeInt(json['rate']),
      quantity: APIHelper.getSafeInt(json['quantity']),
      total: APIHelper.getSafeInt(json['total']),
      status: APIHelper.getSafeString(json['status']),
      otp: APIHelper.getSafeString(json['otp']),
      currency:
          NewRentSocketCurrency.getAPIResponseObjectSafeValue(json['currency']),
      id: APIHelper.getSafeString(json['_id']),
      createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      v: APIHelper.getSafeInt(json['__v']),
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'user': user.toJson(),
        'rent': rent,
        'vehicle': vehicle.toJson(),
        'owner': owner.toJson(),
        'driver': driver.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'type': type,
        'rate': rate,
        'quantity': quantity,
        'total': total,
        'status': status,
        'otp': otp,
        'currency': currency.toJson(),
        '_id': id,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory NewRentSocketResponse.empty() => NewRentSocketResponse(
      user: NewRentSocketUser(),
      vehicle: NewRentSocketVehicle.empty(),
      owner: NewRentSocketOwner(),
      driver: NewRentSocketDriver(),
      currency: NewRentSocketCurrency(),
      date: AppComponents.defaultUnsetDateTime,
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static NewRentSocketResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewRentSocketResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewRentSocketResponse.empty();
}

class NewRentSocketVehicle {
  String id;
  String uid;
  String name;
  NewRentSocketCategory category;
  String model;
  String year;
  String maxPower;
  String maxSpeed;
  int capacity;
  String color;
  String fuelType;
  int mileage;
  String gearType;
  bool ac;

  NewRentSocketVehicle({
    this.id = '',
    this.uid = '',
    this.name = '',
    required this.category,
    this.model = '',
    this.year = '',
    this.maxPower = '',
    this.maxSpeed = '',
    this.capacity = 0,
    this.color = '',
    this.fuelType = '',
    this.mileage = 0,
    this.gearType = '',
    this.ac = false,
  });

  factory NewRentSocketVehicle.fromJson(Map<String, dynamic> json) =>
      NewRentSocketVehicle(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        category: NewRentSocketCategory.getAPIResponseObjectSafeValue(
            json['category']),
        model: APIHelper.getSafeString(json['model']),
        year: APIHelper.getSafeString(json['year']),
        maxPower: APIHelper.getSafeString(json['max_power']),
        maxSpeed: APIHelper.getSafeString(json['max_speed']),
        capacity: APIHelper.getSafeInt(json['capacity']),
        color: APIHelper.getSafeString(json['color']),
        fuelType: APIHelper.getSafeString(json['fuel_type']),
        mileage: APIHelper.getSafeInt(json['mileage']),
        gearType: APIHelper.getSafeString(json['gear_type']),
        ac: APIHelper.getSafeBool(json['ac']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'category': category.toJson(),
        'model': model,
        'year': year,
        'max_power': maxPower,
        'max_speed': maxSpeed,
        'capacity': capacity,
        'color': color,
        'fuel_type': fuelType,
        'mileage': mileage,
        'gear_type': gearType,
        'ac': ac,
      };

  factory NewRentSocketVehicle.empty() => NewRentSocketVehicle(
        category: NewRentSocketCategory(),
      );
  static NewRentSocketVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewRentSocketVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewRentSocketVehicle.empty();
}

class NewRentSocketCategory {
  String id;
  String uid;
  String name;
  String image;

  NewRentSocketCategory(
      {this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory NewRentSocketCategory.fromJson(Map<String, dynamic> json) =>
      NewRentSocketCategory(
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

  static NewRentSocketCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewRentSocketCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewRentSocketCategory();
}

class NewRentSocketCurrency {
  String id;
  String name;
  String code;
  String symbol;
  int rate;

  NewRentSocketCurrency(
      {this.id = '',
      this.name = '',
      this.code = '',
      this.symbol = '',
      this.rate = 0});

  factory NewRentSocketCurrency.fromJson(Map<String, dynamic> json) =>
      NewRentSocketCurrency(
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

  static NewRentSocketCurrency getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewRentSocketCurrency.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewRentSocketCurrency();
}

class NewRentSocketOwner {
  String id;
  String uid;
  String name;
  String email;
  String image;

  NewRentSocketOwner(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.email = '',
      this.image = ''});

  factory NewRentSocketOwner.fromJson(Map<String, dynamic> json) =>
      NewRentSocketOwner(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        email: APIHelper.getSafeString(json['email']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'email': email,
        'image': image,
      };

  static NewRentSocketOwner getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewRentSocketOwner.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewRentSocketOwner();
}

class NewRentSocketUser {
  String id;
  String uid;
  String name;
  String email;
  String image;

  NewRentSocketUser(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.email = '',
      this.image = ''});

  factory NewRentSocketUser.fromJson(Map<String, dynamic> json) =>
      NewRentSocketUser(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        email: APIHelper.getSafeString(json['email']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'email': email,
        'image': image,
      };

  static NewRentSocketUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewRentSocketUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewRentSocketUser();
}

class NewRentSocketDriver {
  String id;
  String uid;
  String name;
  String phone;
  String email;

  NewRentSocketDriver(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = ''});

  factory NewRentSocketDriver.fromJson(Map<String, dynamic> json) =>
      NewRentSocketDriver(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        phone: APIHelper.getSafeString(json['phone']),
        email: APIHelper.getSafeString(json['email']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
      };

  static NewRentSocketDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewRentSocketDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewRentSocketDriver();
}
