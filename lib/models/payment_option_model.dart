class FakePaymentOptionModel {
  String name;
  String id;
  String paymentImage;
  FakePaymentOptionModel({
    required this.name,
    required this.id,
    required this.paymentImage,
  });
}

class SelectPaymentOptionModel {
  String viewAbleName;
  String value;
  String paymentImage;
  SelectPaymentOptionModel({
    this.viewAbleName = '',
    this.value = '',
    this.paymentImage = '',
  });
}

class OptionModel {
  String viewAbleName;
  String value;
  OptionModel({
    this.viewAbleName = '',
    this.value = '',
  });
}
