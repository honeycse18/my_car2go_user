import 'package:car2gouser/models/core_api_responses/paginated_data_response.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class WalletTransactionHistoryResponse {
  bool error;
  String msg;
  PaginatedDataResponse<TransactionHistoryItems> data;

  WalletTransactionHistoryResponse(
      {this.error = false, this.msg = '', required this.data});

  factory WalletTransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return WalletTransactionHistoryResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: PaginatedDataResponse.getSafeObject(
        json['data'],
        docFromJson: (data) =>
            TransactionHistoryItems.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory WalletTransactionHistoryResponse.empty() =>
      WalletTransactionHistoryResponse(
        data: PaginatedDataResponse.empty(),
      );
  static WalletTransactionHistoryResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletTransactionHistoryResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletTransactionHistoryResponse.empty();
}

class TransactionHistoryItems {
  String id;
  String uid;
  String status;
  DateTime createdAt;
  double amount;
  String transactionId;
  String type;
  String method;

  TransactionHistoryItems({
    this.id = '',
    this.uid = '',
    this.status = '',
    required this.createdAt,
    this.amount = 0,
    this.type = '',
    this.method = '',
    this.transactionId = '',
  });

  factory TransactionHistoryItems.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryItems(
        id: APIHelper.getSafeString(json['_id']),
        uid: APIHelper.getSafeString(json['uid']),
        status: APIHelper.getSafeString(json['status']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        amount: APIHelper.getSafeDouble(json['amount']),
        transactionId: APIHelper.getSafeString(json['transaction_id']),
        type: APIHelper.getSafeString(json['type']),
        method: APIHelper.getSafeString(json['method']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'amount': amount,
        'transaction_id': transactionId,
        'type': type,
        'method': method,
      };

  factory TransactionHistoryItems.empty() =>
      TransactionHistoryItems(createdAt: AppComponents.defaultUnsetDateTime);
  static TransactionHistoryItems getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TransactionHistoryItems.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : TransactionHistoryItems.empty();
}
