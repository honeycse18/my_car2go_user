import 'payment.dart';

class Doc {
  String? id;
  int? amount;
  String? status;
  String? from;
  Payment? payment;
  String? transactionId;
  DateTime? createdAt;
  String? mode;

  Doc({
    this.id,
    this.amount,
    this.status,
    this.from,
    this.payment,
    this.transactionId,
    this.createdAt,
    this.mode,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json['_id'] as String?,
        amount: json['amount'] as int?,
        status: json['status'] as String?,
        from: json['from'] as String?,
        payment: json['payment'] == null
            ? null
            : Payment.fromJson(json['payment'] as Map<String, dynamic>),
        transactionId: json['transaction_id'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        mode: json['mode'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'amount': amount,
        'status': status,
        'from': from,
        'payment': payment?.toJson(),
        'transaction_id': transactionId,
        'createdAt': createdAt?.toIso8601String(),
        'mode': mode,
      };
}
