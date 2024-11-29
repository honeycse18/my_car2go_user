class Payment {
  String? status;
  String? paymentMethod;

  Payment({this.status, this.paymentMethod});

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        status: json['status'] as String?,
        paymentMethod: json['payment_method'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'payment_method': paymentMethod,
      };
}
