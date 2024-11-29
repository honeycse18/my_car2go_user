import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class CouponCodeListResponse {
  bool error;
  String msg;
  List<CouponList> data;

  CouponCodeListResponse(
      {this.error = false, this.data = const [], this.msg = ''});

  factory CouponCodeListResponse.fromJson(Map<String, dynamic> json) {
    return CouponCodeListResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: APIHelper.getSafeList(json['data'] as List<dynamic>?)
          .map((e) => CouponList.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static CouponCodeListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CouponCodeListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CouponCodeListResponse();
}

class CouponList {
  String id;
  String code;
  double value;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime startDuration;
  DateTime endDuration;
  double couponMinimumAmount;

  CouponList({
    this.id = '',
    this.code = '',
    this.value = 0,
    this.type = '',
    required this.createdAt,
    required this.updatedAt,
    required this.startDuration,
    required this.endDuration,
    this.couponMinimumAmount = 0,
  });

  factory CouponList.fromJson(Map<String, dynamic> json) => CouponList(
        id: APIHelper.getSafeString(json['_id']),
        code: APIHelper.getSafeString(json['code']),
        value: APIHelper.getSafeDouble(json['value']),
        type: APIHelper.getSafeString(json['type']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
        startDuration: APIHelper.getSafeDateTime(json['start_duration']),
        endDuration: APIHelper.getSafeDateTime(json['end_duration']),
        couponMinimumAmount:
            APIHelper.getSafeDouble(json['coupon_minimum_amount']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'code': code,
        'value': value,
        'type': type,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'start_duration': APIHelper.toServerDateTimeFormattedStringFromDateTime(
            startDuration),
        'end_duration':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDuration),
        'coupon_minimum_amount': couponMinimumAmount,
      };

  factory CouponList.empty() => CouponList(
        createdAt: AppComponents.defaultUnsetDateTime,
        endDuration: AppComponents.defaultUnsetDateTime,
        startDuration: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static CouponList getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CouponList.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : CouponList.empty();
}
