import 'doc.dart';

class WalletTransactionResponse {
  List<Doc>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  WalletTransactionResponse({
    this.docs,
    this.totalDocs,
    this.limit,
    this.page,
    this.totalPages,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  factory WalletTransactionResponse.fromJson(Map<String, dynamic> json) {
    return WalletTransactionResponse(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => Doc.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      page: json['page'] as int?,
      totalPages: json['totalPages'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
      hasPrevPage: json['hasPrevPage'] as bool?,
      hasNextPage: json['hasNextPage'] as bool?,
      prevPage: json['prevPage'] as dynamic,
      nextPage: json['nextPage'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'docs': docs?.map((e) => e.toJson()).toList(),
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
}
