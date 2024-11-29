import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class PoolingRequestDetailsResponse {
  bool error;
  String msg;
  PullingRequestDetailsData data;

  PoolingRequestDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory PoolingRequestDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PoolingRequestDetailsResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data:
          PullingRequestDetailsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory PoolingRequestDetailsResponse.empty() =>
      PoolingRequestDetailsResponse(
        data: PullingRequestDetailsData.empty(),
      );
  static PoolingRequestDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PoolingRequestDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PoolingRequestDetailsResponse.empty();
}

class PullingRequestDetailsData {
  String id;
  PullingRequestDetailsOffer offer;
  int seats;
  int rate;
  String otp;
  PullingRequestDetailsCategory category;
  String status;
  DateTime createdAt;
  int available;
  PullingRequestDetailsCurrency currency;
  PullingRequestDetailsPayment payment;

  PullingRequestDetailsData(
      {this.id = '',
      required this.offer,
      this.seats = 0,
      this.rate = 0,
      this.otp = '',
      required this.category,
      this.status = '',
      required this.createdAt,
      this.available = 0,
      required this.currency,
      required this.payment});

  factory PullingRequestDetailsData.fromJson(Map<String, dynamic> json) =>
      PullingRequestDetailsData(
        id: APIHelper.getSafeString(json['_id']),
        offer: PullingRequestDetailsOffer.getAPIResponseObjectSafeValue(
            json['offer']),
        seats: APIHelper.getSafeInt(json['seats']),
        rate: APIHelper.getSafeInt(json['rate']),
        otp: APIHelper.getSafeString(json['otp']),
        category: PullingRequestDetailsCategory.getAPIResponseObjectSafeValue(
            json['category']),
        status: APIHelper.getSafeString(json['status']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        available: APIHelper.getSafeInt(json['available']),
        currency: PullingRequestDetailsCurrency.getAPIResponseObjectSafeValue(
            json['currency']),
        payment: PullingRequestDetailsPayment.getAPIResponseObjectSafeValue(
            json['payment']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'offer': offer.toJson(),
        'seats': seats,
        'rate': rate,
        'otp': otp,
        'category': category.toJson(),
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'available': available,
        'currency': currency.toJson(),
        'payment': payment.toJson(),
      };

  factory PullingRequestDetailsData.empty() => PullingRequestDetailsData(
        offer: PullingRequestDetailsOffer.empty(),
        category: PullingRequestDetailsCategory(),
        createdAt: AppComponents.defaultUnsetDateTime,
        currency: PullingRequestDetailsCurrency(),
        payment: PullingRequestDetailsPayment(),
      );
  static PullingRequestDetailsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingRequestDetailsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingRequestDetailsData.empty();
}

class PullingRequestDetailsCategory {
  String id;
  String name;
  String image;

  PullingRequestDetailsCategory(
      {this.id = '', this.name = '', this.image = ''});

  factory PullingRequestDetailsCategory.fromJson(Map<String, dynamic> json) =>
      PullingRequestDetailsCategory(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
      };

  static PullingRequestDetailsCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingRequestDetailsCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingRequestDetailsCategory();
}

class PullingRequestDetailsOffer {
  String id;
  PullingRequestDetailsUser user;
  DateTime date;
  String type;
  PullingRequestDetailsFrom from;
  PullingRequestDetailsTo to;
  int seats;
  int rate;
  PullingRequestDetailsCategory category;
  String vehicleNumber;
  String status;
  DateTime createdAt;
  List<PullingRequestDetailsRequest> requests;
  int available;

  PullingRequestDetailsOffer({
    this.id = '',
    required this.user,
    required this.date,
    this.type = '',
    required this.from,
    required this.to,
    this.seats = 0,
    this.rate = 0,
    required this.category,
    this.vehicleNumber = '',
    this.status = '',
    required this.createdAt,
    this.requests = const [],
    this.available = 0,
  });

  factory PullingRequestDetailsOffer.fromJson(Map<String, dynamic> json) =>
      PullingRequestDetailsOffer(
        id: APIHelper.getSafeString(json['_id']),
        user: PullingRequestDetailsUser.getAPIResponseObjectSafeValue(
            json['user']),
        date: APIHelper.getSafeDateTime(json['date']),
        type: APIHelper.getSafeString(json['type']),
        from: PullingRequestDetailsFrom.getAPIResponseObjectSafeValue(
            json['from']),
        to: PullingRequestDetailsTo.getAPIResponseObjectSafeValue(json['to']),
        seats: APIHelper.getSafeInt(json['seats']),
        rate: APIHelper.getSafeInt(json['rate']),
        category: PullingRequestDetailsCategory.getAPIResponseObjectSafeValue(
            json['category']),
        vehicleNumber: APIHelper.getSafeString(json['vehicle_number']),
        status: APIHelper.getSafeString(json['status']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        requests: APIHelper.getSafeList(json['requests'])
            .map((e) =>
                PullingRequestDetailsRequest.getAPIResponseObjectSafeValue(e))
            .toList(),
        available: APIHelper.getSafeInt(json['available']),
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
        'category': category.toJson(),
        'vehicle_number': vehicleNumber,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'requests': requests.map((e) => e.toJson()).toList(),
        'available': available,
      };

  factory PullingRequestDetailsOffer.empty() => PullingRequestDetailsOffer(
      user: PullingRequestDetailsUser(),
      date: AppComponents.defaultUnsetDateTime,
      category: PullingRequestDetailsCategory(),
      createdAt: AppComponents.defaultUnsetDateTime,
      from: PullingRequestDetailsFrom.empty(),
      to: PullingRequestDetailsTo.empty());
  static PullingRequestDetailsOffer getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingRequestDetailsOffer.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingRequestDetailsOffer.empty();
}

class PullingRequestDetailsTo {
  String address;
  PullingRequestDetailsLocation location;

  PullingRequestDetailsTo({this.address = '', required this.location});

  factory PullingRequestDetailsTo.fromJson(Map<String, dynamic> json) =>
      PullingRequestDetailsTo(
        address: APIHelper.getSafeString(json['address']),
        location: PullingRequestDetailsLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory PullingRequestDetailsTo.empty() => PullingRequestDetailsTo(
        location: PullingRequestDetailsLocation(),
      );
  static PullingRequestDetailsTo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingRequestDetailsTo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingRequestDetailsTo.empty();
}

class PullingRequestDetailsFrom {
  String address;
  PullingRequestDetailsLocation location;

  PullingRequestDetailsFrom({this.address = '', required this.location});

  factory PullingRequestDetailsFrom.fromJson(Map<String, dynamic> json) =>
      PullingRequestDetailsFrom(
        address: APIHelper.getSafeString(json['address']),
        location: PullingRequestDetailsLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory PullingRequestDetailsFrom.empty() => PullingRequestDetailsFrom(
        location: PullingRequestDetailsLocation(),
      );
  static PullingRequestDetailsFrom getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingRequestDetailsFrom.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingRequestDetailsFrom.empty();
}

class PullingRequestDetailsLocation {
  double lat;
  double lng;

  PullingRequestDetailsLocation({this.lat = 0, this.lng = 0});

  factory PullingRequestDetailsLocation.fromJson(Map<String, dynamic> json) =>
      PullingRequestDetailsLocation(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static PullingRequestDetailsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingRequestDetailsLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingRequestDetailsLocation();
}

class PullingRequestDetailsRequest {
  String id;
  PullingRequestDetailsUser user;
  int seats;
  String status;

  PullingRequestDetailsRequest(
      {this.id = '', required this.user, this.seats = 0, this.status = ''});

  factory PullingRequestDetailsRequest.fromJson(Map<String, dynamic> json) =>
      PullingRequestDetailsRequest(
        id: APIHelper.getSafeString(json['_id']),
        user: PullingRequestDetailsUser.getAPIResponseObjectSafeValue(
            json['user']),
        seats: APIHelper.getSafeInt(json['seats']),
        status: APIHelper.getSafeString(json['status']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user.toJson(),
        'seats': seats,
        'status': status,
      };

  factory PullingRequestDetailsRequest.empty() => PullingRequestDetailsRequest(
        user: PullingRequestDetailsUser(),
      );
  static PullingRequestDetailsRequest getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingRequestDetailsRequest.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingRequestDetailsRequest.empty();
}

class PullingRequestDetailsUser {
  String id;
  String name;
  String phone;
  String image;

  PullingRequestDetailsUser(
      {this.id = '', this.name = '', this.phone = '', this.image = ''});

  factory PullingRequestDetailsUser.fromJson(Map<String, dynamic> json) =>
      PullingRequestDetailsUser(
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

  static PullingRequestDetailsUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingRequestDetailsUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingRequestDetailsUser();
}

class PullingRequestDetailsCurrency {
  String id;
  String name;
  String code;
  String symbol;
  int rate;

  PullingRequestDetailsCurrency(
      {this.id = '',
      this.name = '',
      this.code = '',
      this.symbol = '',
      this.rate = 0});

  factory PullingRequestDetailsCurrency.fromJson(Map<String, dynamic> json) =>
      PullingRequestDetailsCurrency(
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

  static PullingRequestDetailsCurrency getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingRequestDetailsCurrency.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingRequestDetailsCurrency();
}

class PullingRequestDetailsPayment {
  String method;
  String status;
  String transactionId;

  PullingRequestDetailsPayment(
      {this.method = '', this.status = '', this.transactionId = ''});

  factory PullingRequestDetailsPayment.fromJson(Map<String, dynamic> json) =>
      PullingRequestDetailsPayment(
        method: APIHelper.getSafeString(json['method']),
        status: APIHelper.getSafeString(json['status']),
        transactionId: APIHelper.getSafeString(json['transaction_id']),
      );

  Map<String, dynamic> toJson() => {
        'method': method,
        'status': status,
        'transaction_id': transactionId,
      };

  static PullingRequestDetailsPayment getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingRequestDetailsPayment.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingRequestDetailsPayment();
}
