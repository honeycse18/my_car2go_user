import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class HireSocketResponse {
  String uid;
  NewHireSocketHireBy hireBy;
  NewHireSocketDriver driver;
  String pickup;
  NewHireSocketStart start;
  NewHireSocketEnd end;
  int amount;
  String type;
  String status;
  String otp;
  NewHireSocketCurrency currency;
  String id;
  List<dynamic> breaks;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  HireSocketResponse({
    this.uid = '',
    required this.hireBy,
    required this.driver,
    this.pickup = '',
    required this.start,
    required this.end,
    this.amount = 0,
    this.type = '',
    this.status = '',
    this.otp = '',
    required this.currency,
    this.id = '',
    this.breaks = const [],
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory HireSocketResponse.fromJson(Map<String, dynamic> json) {
    return HireSocketResponse(
      uid: APIHelper.getSafeString(json['uid']),
      hireBy:
          NewHireSocketHireBy.getAPIResponseObjectSafeValue(json['hire_by']),
      driver: NewHireSocketDriver.getAPIResponseObjectSafeValue(json['driver']),
      pickup: APIHelper.getSafeString(json['pickup']),
      start: NewHireSocketStart.fromJson(json['start'] as Map<String, dynamic>),
      end: NewHireSocketEnd.fromJson(json['end'] as Map<String, dynamic>),
      amount: APIHelper.getSafeInt(json['amount']),
      type: APIHelper.getSafeString(json['type']),
      status: APIHelper.getSafeString(json['status']),
      otp: APIHelper.getSafeString(json['otp']),
      currency:
          NewHireSocketCurrency.getAPIResponseObjectSafeValue(json['currency']),
      id: APIHelper.getSafeString(json['_id']),
      breaks: APIHelper.getSafeList(json['breaks']).map((e) => e).toList(),
      createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      v: APIHelper.getSafeInt(json['__v']),
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'hire_by': hireBy.toJson(),
        'driver': driver.toJson(),
        'pickup': pickup,
        'start': start.toJson(),
        'end': end.toJson(),
        'amount': amount,
        'type': type,
        'status': status,
        'otp': otp,
        'currency': currency.toJson(),
        '_id': id,
        'breaks': breaks,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory HireSocketResponse.empty() => HireSocketResponse(
      hireBy: NewHireSocketHireBy(),
      driver: NewHireSocketDriver(),
      start: NewHireSocketStart.empty(),
      end: NewHireSocketEnd.empty(),
      currency: NewHireSocketCurrency(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static HireSocketResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? HireSocketResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : HireSocketResponse.empty();
}

class NewHireSocketCurrency {
  String id;
  String name;
  String code;
  String symbol;
  int rate;

  NewHireSocketCurrency(
      {this.id = '',
      this.name = '',
      this.code = '',
      this.symbol = '',
      this.rate = 0});

  factory NewHireSocketCurrency.fromJson(Map<String, dynamic> json) =>
      NewHireSocketCurrency(
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

  static NewHireSocketCurrency getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewHireSocketCurrency.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewHireSocketCurrency();
}

class NewHireSocketDriver {
  String id;
  String uid;
  String name;
  String phone;
  String email;

  NewHireSocketDriver(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = ''});

  factory NewHireSocketDriver.fromJson(Map<String, dynamic> json) =>
      NewHireSocketDriver(
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

  static NewHireSocketDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewHireSocketDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewHireSocketDriver();
}

class NewHireSocketEnd {
  DateTime date;
  DateTime time;

  NewHireSocketEnd({required this.date, required this.time});

  factory NewHireSocketEnd.fromJson(Map<String, dynamic> json) =>
      NewHireSocketEnd(
        date: APIHelper.getSafeDateTime(json['date']),
        time: APIHelper.getSafeDateTime(json['time']),
      );

  Map<String, dynamic> toJson() => {
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'time': APIHelper.toServerDateTimeFormattedStringFromDateTime(time),
      };

  factory NewHireSocketEnd.empty() => NewHireSocketEnd(
      date: AppComponents.defaultUnsetDateTime,
      time: AppComponents.defaultUnsetDateTime);
  static NewHireSocketEnd getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewHireSocketEnd.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewHireSocketEnd.empty();
}

class NewHireSocketHireBy {
  String id;
  String uid;
  String name;
  String email;

  NewHireSocketHireBy(
      {this.id = '', this.uid = '', this.name = '', this.email = ''});

  factory NewHireSocketHireBy.fromJson(Map<String, dynamic> json) =>
      NewHireSocketHireBy(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        email: APIHelper.getSafeString(json['email']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'email': email,
      };

  static NewHireSocketHireBy getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewHireSocketHireBy.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewHireSocketHireBy();
}

class NewHireSocketStart {
  DateTime date;
  DateTime time;

  NewHireSocketStart({required this.date, required this.time});

  factory NewHireSocketStart.fromJson(Map<String, dynamic> json) =>
      NewHireSocketStart(
        date: APIHelper.getSafeDateTime(json['date']),
        time: APIHelper.getSafeDateTime(json['time']),
      );

  Map<String, dynamic> toJson() => {
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'time': APIHelper.toServerDateTimeFormattedStringFromDateTime(time),
      };

  factory NewHireSocketStart.empty() => NewHireSocketStart(
      date: AppComponents.defaultUnsetDateTime,
      time: AppComponents.defaultUnsetDateTime);
  static NewHireSocketStart getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NewHireSocketStart.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NewHireSocketStart.empty();
}
