import 'package:car2gouser/models/enums/wallet_transaction/wallet_transaction_by.dart';
import 'package:car2gouser/models/enums/wallet_transaction/wallet_transaction_from.dart';
import 'package:car2gouser/models/enums/wallet_transaction/wallet_transaction_mode.dart';
import 'package:car2gouser/models/enums/wallet_transaction/wallet_transaction_status.dart';
import 'package:car2gouser/models/enums/wallet_transaction/wallet_transaction_type.dart';
import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class WalletDetails {
  List<WalletTransaction> transactions;
  WalletCurrentBalance currentBalance;
  double totalEarning;
  double totalWithdraw;

  WalletDetails({
    this.transactions = const [],
    required this.currentBalance,
    this.totalEarning = 0,
    this.totalWithdraw = 0,
  });
  factory WalletDetails.empty() =>
      WalletDetails(currentBalance: WalletCurrentBalance());

  factory WalletDetails.fromJson(Map<String, dynamic> json) => WalletDetails(
        transactions: APIHelper.getSafeList(json['transactions'])
            .map((e) => WalletTransaction.getSafeObject(e))
            .toList(),
        currentBalance:
            WalletCurrentBalance.getSafeObject(json['current_balance']),
        totalEarning: APIHelper.getSafeDouble(json['total_earning'], 0),
        totalWithdraw: APIHelper.getSafeDouble(json['total_withdraw'], 0),
      );

  Map<String, dynamic> toJson() => {
        'transactions': transactions.map((e) => e.toJson()).toList(),
        'current_balance': currentBalance.toJson(),
        'total_earning': totalEarning,
        'total_withdraw': totalWithdraw,
      };

  static WalletDetails getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletDetails.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : WalletDetails.empty();
}

class WalletTransaction {
  String id;
  double amount;
  String withdrawMethod;
  String bankName;
  List<WalletTransactionWithdrawalDetail> withdrawalDetails;
  String status;
  String from;
  WalletTransactionPayment payment;
  String by;
  String type;
  String transactionId;
  DateTime createdAt;
  String mode;

  WalletTransaction({
    this.id = '',
    this.amount = 0,
    this.withdrawMethod = '',
    this.bankName = '',
    this.withdrawalDetails = const [],
    this.status = '',
    this.from = '',
    required this.payment,
    this.by = '',
    this.type = '',
    this.transactionId = '',
    required this.createdAt,
    this.mode = '',
  });
  factory WalletTransaction.empty() => WalletTransaction(
      payment: WalletTransactionPayment(),
      createdAt: AppConstants.defaultUnsetDateTime);

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      WalletTransaction(
        id: APIHelper.getSafeString(json['_id']),
        amount: APIHelper.getSafeDouble(json['amount'], 0),
        withdrawMethod: APIHelper.getSafeString(json['withdraw_method']),
        bankName: APIHelper.getSafeString(json['bank_name']),
        withdrawalDetails: APIHelper.getSafeList(json['withdrawal_details'])
            .map((e) => WalletTransactionWithdrawalDetail.getSafeObject(e))
            .toList(),
        status: APIHelper.getSafeString(json['status']),
        from: APIHelper.getSafeString(json['from']),
        payment: WalletTransactionPayment.getSafeObject(json['payment']),
        by: APIHelper.getSafeString(json['by']),
        type: APIHelper.getSafeString(json['type']),
        transactionId: APIHelper.getSafeString(json['transaction_id']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        mode: APIHelper.getSafeString(json['mode']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'amount': amount,
        'withdraw_method': withdrawMethod,
        'bank_name': bankName,
        'withdrawal_details': withdrawalDetails.map((e) => e.toJson()).toList(),
        'status': status,
        'from': from,
        'payment': payment.toJson(),
        'by': by,
        'type': type,
        'transaction_id': transactionId,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'mode': mode,
      };

  static WalletTransaction getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletTransaction.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletTransaction.empty();
  WalletTransactionStatus get statusAsEnum =>
      WalletTransactionStatus.fromString(status);
  WalletTransactionFrom get fromAsEnum =>
      WalletTransactionFrom.fromString(from);
  WalletTransactionBy get byAsEnum => WalletTransactionBy.fromString(by);
  WalletTransactionType get typeAsEnum =>
      WalletTransactionType.fromString(type);
  WalletTransactionMode get modeAsEnum =>
      WalletTransactionMode.fromString(mode);
  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => isEmpty == false;
}

class WalletTransactionPayment {
  String status;
  String paymentMethod;

  WalletTransactionPayment({this.status = '', this.paymentMethod = ''});

  factory WalletTransactionPayment.fromJson(Map<String, dynamic> json) =>
      WalletTransactionPayment(
        status: APIHelper.getSafeString(json['status']),
        paymentMethod: APIHelper.getSafeString(json['payment_method']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'payment_method': paymentMethod,
      };

  static WalletTransactionPayment getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletTransactionPayment.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletTransactionPayment();
}

class WalletTransactionWithdrawalDetail {
  String key;
  String value;
  String type;
  String id;

  WalletTransactionWithdrawalDetail(
      {this.key = '', this.value = '', this.type = '', this.id = ''});

  factory WalletTransactionWithdrawalDetail.fromJson(
      Map<String, dynamic> json) {
    return WalletTransactionWithdrawalDetail(
      key: APIHelper.getSafeString(json['key']),
      value: APIHelper.getSafeString(json['value']),
      type: APIHelper.getSafeString(json['type']),
      id: APIHelper.getSafeString(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
        'type': type,
        '_id': id,
      };

  static WalletTransactionWithdrawalDetail getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletTransactionWithdrawalDetail.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletTransactionWithdrawalDetail();
}

class WalletCurrentBalance {
  double total;

  WalletCurrentBalance({this.total = 0});

  factory WalletCurrentBalance.fromJson(Map<String, dynamic> json) {
    return WalletCurrentBalance(
      total: APIHelper.getSafeDouble(json['total'], 0),
    );
  }

  Map<String, dynamic> toJson() => {
        'total': total,
      };

  static WalletCurrentBalance getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletCurrentBalance.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletCurrentBalance();
}
