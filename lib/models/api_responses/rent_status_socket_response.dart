import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class RentStatusSocketResponse {
  RentStatusSocketCurrency currency;
  RentStatusPayment payment;
  String id;
  String uid;
  RentStatusSocketUser user;
  String rent;
  String vehicle;
  RentStatusSocketOwner owner;
  NewRentSocketDriver driver;
  DateTime date;
  String type;
  int rate;
  int quantity;
  int total;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String cancelReason;

  RentStatusSocketResponse({
    required this.currency,
    required this.payment,
    this.id = '',
    this.uid = '',
    required this.user,
    this.rent = '',
    this.vehicle = '',
    required this.owner,
    required this.driver,
    required this.date,
    this.type = '',
    this.rate = 0,
    this.quantity = 0,
    this.total = 0,
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
    this.cancelReason = '',
  });

  factory RentStatusSocketResponse.fromJson(Map<String, dynamic> json) {
    return RentStatusSocketResponse(
      currency: RentStatusSocketCurrency.getAPIResponseObjectSafeValue(
          json['currency']),
      payment: RentStatusPayment.getAPIResponseObjectSafeValue(json['payment']),
      id: APIHelper.getSafeString(json['_id']),
      uid: APIHelper.getSafeString(json['uid']),
      user: RentStatusSocketUser.getAPIResponseObjectSafeValue(json['user']),
      rent: APIHelper.getSafeString(json['rent']),
      vehicle: APIHelper.getSafeString(json['vehicle']),
      owner: RentStatusSocketOwner.getAPIResponseObjectSafeValue(json['owner']),
      driver: NewRentSocketDriver.getAPIResponseObjectSafeValue(json['driver']),
      date: APIHelper.getSafeDateTime(json['date']),
      type: APIHelper.getSafeString(json['type']),
      rate: APIHelper.getSafeInt(json['rate']),
      quantity: APIHelper.getSafeInt(json['quantity']),
      total: APIHelper.getSafeInt(json['total']),
      status: APIHelper.getSafeString(json['status']),
      createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      v: APIHelper.getSafeInt(json['__v']),
      cancelReason: APIHelper.getSafeString(json['cancel_reason']),
    );
  }

  Map<String, dynamic> toJson() => {
        'currency': currency.toJson(),
        'payment': payment.toJson(),
        '_id': id,
        'uid': uid,
        'user': user.toJson(),
        'rent': rent,
        'vehicle': vehicle,
        'owner': owner.toJson(),
        'driver': driver.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'type': type,
        'rate': rate,
        'quantity': quantity,
        'total': total,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
        'cancel_reason': cancelReason,
      };

  factory RentStatusSocketResponse.empty() => RentStatusSocketResponse(
      currency: RentStatusSocketCurrency(),
      payment: RentStatusPayment(),
      user: RentStatusSocketUser(),
      driver: NewRentSocketDriver(),
      owner: RentStatusSocketOwner(),
      date: AppComponents.defaultUnsetDateTime,
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static RentStatusSocketResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentStatusSocketResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentStatusSocketResponse.empty();
}

class RentStatusSocketCurrency {
  String id;
  String name;
  String code;
  String symbol;
  int rate;

  RentStatusSocketCurrency(
      {this.id = '',
      this.name = '',
      this.code = '',
      this.symbol = '',
      this.rate = 0});

  factory RentStatusSocketCurrency.fromJson(Map<String, dynamic> json) =>
      RentStatusSocketCurrency(
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

  static RentStatusSocketCurrency getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentStatusSocketCurrency.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentStatusSocketCurrency();
}

class RentStatusSocketOwner {
  String id;
  String uid;

  RentStatusSocketOwner({this.id = '', this.uid = ''});

  factory RentStatusSocketOwner.fromJson(Map<String, dynamic> json) =>
      RentStatusSocketOwner(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
      };

  static RentStatusSocketOwner getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentStatusSocketOwner.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentStatusSocketOwner();
}

class RentStatusPayment {
  String method;
  String status;
  String transactionId;
  int amount;

  RentStatusPayment(
      {this.method = '',
      this.status = '',
      this.transactionId = '',
      this.amount = 0});

  factory RentStatusPayment.fromJson(Map<String, dynamic> json) =>
      RentStatusPayment(
        method: APIHelper.getSafeString(json['method']),
        status: APIHelper.getSafeString(json['status']),
        transactionId: APIHelper.getSafeString(json['transaction_id']),
        amount: APIHelper.getSafeInt(json['amount']),
      );

  Map<String, dynamic> toJson() => {
        'method': method,
        'status': status,
        'transaction_id': transactionId,
        'amount': amount,
      };

  static RentStatusPayment getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentStatusPayment.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentStatusPayment();
}

class RentStatusSocketUser {
  String id;
  String uid;

  RentStatusSocketUser({this.id = '', this.uid = ''});

  factory RentStatusSocketUser.fromJson(Map<String, dynamic> json) =>
      RentStatusSocketUser(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
      };

  static RentStatusSocketUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentStatusSocketUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentStatusSocketUser();
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
