import 'package:car2gouser/utils/helpers/api_helper.dart';

class PaginatedDataResponse<T> {
  List<T> docs;
  int totalDocs;
  int limit;
  int page;
  int totalPages;
  int pagingCounter;
  bool hasPrevPage;
  bool hasNextPage;
  int prevPage;
  int nextPage;

  PaginatedDataResponse({
    this.docs = const [],
    this.totalDocs = 0,
    this.limit = 0,
    this.page = 0,
    this.totalPages = 0,
    this.pagingCounter = 0,
    this.hasPrevPage = false,
    this.hasNextPage = false,
    this.prevPage = 0,
    this.nextPage = 0,
  });

  factory PaginatedDataResponse.fromJson(Map<String, dynamic> json,
          {required T Function(Object?) docFromJson}) =>
      PaginatedDataResponse(
        docs: APIHelper.getSafeList(json['docs'])
            .map<T>((e) => docFromJson(e))
            .toList(),
        totalDocs: APIHelper.getSafeInt(json['totalDocs']),
        limit: APIHelper.getSafeInt(json['limit']),
        page: APIHelper.getSafeInt(json['page']),
        totalPages: APIHelper.getSafeInt(json['totalPages']),
        pagingCounter: APIHelper.getSafeInt(json['pagingCounter']),
        hasPrevPage: APIHelper.getSafeBool(json['hasPrevPage']),
        hasNextPage: APIHelper.getSafeBool(json['hasNextPage']),
        prevPage: APIHelper.getSafeInt(json['prevPage']),
        nextPage: APIHelper.getSafeInt(json['nextPage']),
      );

  factory PaginatedDataResponse.empty() => PaginatedDataResponse<T>();

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) docToJson) => {
        'docs': docs.map((e) => docToJson(e)).toList(),
        'totalDocs': totalDocs,
        'limit': limit,
        'page': page,
        'totalPages': totalPages,
        'pagingCounter': pagingCounter,
        'hasPrevPage': hasPrevPage,
        'hasNextPage': hasNextPage,
        'prevPage': prevPage,
        'nextPage': nextPage,
      };

  static PaginatedDataResponse<T> getSafeObject<T>(Object? unsafeResponseValue,
          {required T Function(Object?) docFromJson}) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PaginatedDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>,
              docFromJson: docFromJson)
          : PaginatedDataResponse.empty();
}
