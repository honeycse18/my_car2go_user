import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class AllCategoriesResponse {
  bool error;
  String msg;
  AllCategoriesData data;

  AllCategoriesResponse(
      {this.error = false, this.msg = '', required this.data});

  factory AllCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return AllCategoriesResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: AllCategoriesData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory AllCategoriesResponse.empty() => AllCategoriesResponse(
        data: AllCategoriesData(),
      );
  static AllCategoriesResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AllCategoriesResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AllCategoriesResponse.empty();
}

class AllCategoriesData {
  int page;
  int limit;
  int totalDocs;
  int totalPages;
  List<AllCategoriesDoc> docs;
  bool hasNextPage;
  bool hasPrevPage;

  AllCategoriesData({
    this.page = 0,
    this.limit = 0,
    this.totalDocs = 0,
    this.totalPages = 0,
    this.docs = const [],
    this.hasNextPage = false,
    this.hasPrevPage = false,
  });

  factory AllCategoriesData.fromJson(Map<String, dynamic> json) =>
      AllCategoriesData(
        page: APIHelper.getSafeInt(json['page']),
        limit: APIHelper.getSafeInt(json['limit']),
        totalDocs: APIHelper.getSafeInt(json['totalDocs']),
        totalPages: APIHelper.getSafeInt(json['totalPages']),
        docs: APIHelper.getSafeList(json['docs'])
            .map((e) => AllCategoriesDoc.fromJson(e))
            .toList(),
        hasNextPage: APIHelper.getSafeBool(json['hasNextPage']),
        hasPrevPage: APIHelper.getSafeBool(json['hasPrevPage']),
      );

  Map<String, dynamic> toJson() => {
        'page': page,
        'limit': limit,
        'totalDocs': totalDocs,
        'totalPages': totalPages,
        'docs': docs.map((e) => e.toJson()).toList(),
        'hasNextPage': hasNextPage,
        'hasPrevPage': hasPrevPage,
      };

  static AllCategoriesData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AllCategoriesData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AllCategoriesData();
}

class AllCategoriesDoc {
  String id;
  String uid;
  String name;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String image;
  int baseFare;
  int minFare;
  int perKm;
  int perMin;

  AllCategoriesDoc({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
    this.image = '',
    this.baseFare = 0,
    this.minFare = 0,
    this.perKm = 0,
    this.perMin = 0,
  });

  factory AllCategoriesDoc.fromJson(Map<String, dynamic> json) =>
      AllCategoriesDoc(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        name: APIHelper.getSafeString(json['name']),
        active: APIHelper.getSafeBool(json['active']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
        v: APIHelper.getSafeInt(json['__v']),
        image: APIHelper.getSafeString(json['image']),
        baseFare: APIHelper.getSafeInt(json['base_fare']),
        minFare: APIHelper.getSafeInt(json['min_fare']),
        perKm: APIHelper.getSafeInt(json['per_km']),
        perMin: APIHelper.getSafeInt(json['per_min']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
        'image': image,
        'base_fare': baseFare,
        'min_fare': minFare,
        'per_km': perKm,
        'per_min': perMin,
      };

  factory AllCategoriesDoc.empty() => AllCategoriesDoc(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static AllCategoriesDoc getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AllCategoriesDoc.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AllCategoriesDoc.empty();
}
