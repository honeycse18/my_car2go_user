// import 'fake_models/bid_category_model.dart';

import 'package:car2gouser/models/fakeModel/intro_content_model.dart';
import 'package:car2gouser/models/payment_option_model.dart';
import 'package:car2gouser/models/ui/graph.dart';

class FakeData {
  // Intro screens
  static List<IntroContent> introContents = [
    IntroContent(
        localSVGImageLocation: 'assets/images/intro1.png',
        slogan: 'Anywhere you are',
        content:
            'Whether you\'re in the heart of the city or off the beaten path Car2go brings the seamless travel to your fingertips.'),
    IntroContent(
        localSVGImageLocation: 'assets/images/intro2.png',
        slogan: 'At anytime',
        content:
            'Whether it\'s the crack of dawn or the depths of the night, our app is your 24/7 gateway to effortless transportation'),
    IntroContent(
        localSVGImageLocation: 'assets/images/intro3.png',
        slogan: 'Book your car',
        content:
            'Just a few taps, and your car is on its way. Seamlessly designed car2go empowers you to secure your ride with ease and efficiency'),
  ];
  static var paymentOptionList = <SelectPaymentOptionModel>[
    SelectPaymentOptionModel(
        paymentImage:
            'https://icons.iconarchive.com/icons/flat-icons.com/flat/512/Wallet-icon.png',
        value: 'wallet',
        viewAbleName: 'Wallet'),
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/8808/8808875.png',
        value: 'cash',
        viewAbleName: 'Cash'),
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/174/174861.png',
        value: 'paypal',
        viewAbleName: 'PayPal'),
  ];

  static var topupOptionList = <SelectPaymentOptionModel>[
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/5968/5968382.png',
        value: 'stripe',
        viewAbleName: 'Stripe'),
    SelectPaymentOptionModel(
        paymentImage: 'https://cdn-icons-png.flaticon.com/512/174/174861.png',
        value: 'paypal',
        viewAbleName: 'PayPal'),

    /*SelectPaymentOptionModel(
        paymentImage: 'assets/images/stripe1.png',
        value: 'stripe',
        viewAbleName: 'Stripe'),
    SelectPaymentOptionModel(
        paymentImage: 'assets/images/money_1.png',
        value: 'paypal',
        viewAbleName: 'PayPal'), */
  ];

  static var paymentOptionLists = <SelectPaymentOptionModel>[
    SelectPaymentOptionModel(
        paymentImage: 'assets/images/wallet_1.png',
        value: 'wallet',
        viewAbleName: 'Wallet'),
    SelectPaymentOptionModel(
        paymentImage: 'assets/images/cash-payment_1.png',
        value: 'cash',
        viewAbleName: 'Cash'),
    SelectPaymentOptionModel(
        paymentImage: 'assets/images/money_1.png',
        value: 'paypal',
        viewAbleName: 'PayPal'),
  ];

  static var PaymentOptionList = <OptionModel>[
    OptionModel(value: 'driving_license', viewAbleName: 'Driving License'),
    OptionModel(value: 'passport', viewAbleName: 'Passport'),
    OptionModel(value: 'id_card', viewAbleName: 'Identity Card'),
  ];
  static var cancelRideReason = <FakeCancelRideReason>[
    FakeCancelRideReason(reasonName: 'Change in plans '),
    FakeCancelRideReason(reasonName: 'Found alternative transportation '),
    FakeCancelRideReason(reasonName: 'Driver availability '),
    FakeCancelRideReason(reasonName: 'Cost Concerns '),
    FakeCancelRideReason(reasonName: 'Booking Mistake '),
    FakeCancelRideReason(reasonName: 'Family or Personal Emergencies '),
    FakeCancelRideReason(reasonName: 'Emergency Situations '),
    FakeCancelRideReason(reasonName: 'Other'),
  ];
  static var chatMessage = <Messages>[
    Messages(chat: 'Hi'),
    Messages(chat: 'Hello'),
    Messages(
        chat:
            'gsfag fgaf agfsg agfsagf asfgaslkgfskafg asfgsafalsfgsafgsf asysalfsiffffffffffff fffffffffff'),
    Messages(
        chat:
            'fgaf agfsg agfsagf asfgaslkgfskafg asfgsafalsfgsafgsf asysalfsiffffffffffff fffffffffff'),
    Messages(
        chat:
            'fgaf agfsg agfsagf asfgaslkgfskafg asfgsafalsfgsafgsf asysalfsiffffffffffff fffffffffff'),
    Messages(
        chat:
            'Hfgaf agfsg agfsagf asfgaslkgfskafg asfgsafalsfgsafgsf asysalfsiffffffffffff fffffffffffi'),
    Messages(
        chat:
            'fgaf agfsg agfsagf asfgaslkgfskafg asfgsafalsfgsafgsf asysalfsiffffffffffff fffffffffff'),
    Messages(
        chat:
            'fgaf agfsg agfsagf asfgaslkgfskafg asfgsafalsfgsafgsf asysalfsiffffffffffff fffffffffff'),
    Messages(
        chat:
            'fgaf agfsg agfsagf asfgaslkgfskafg asfgsafalsfgsafgsf asysalfsiffffffffffff fffffffffff'),
    Messages(
        chat:
            'fgaf agfsg agfsagf asfgaslkgfskafg asfgsafalsfgsafgsf asysalfsiffffffffffff fffffffffff'),
    Messages(
        chat:
            'fgaf agfsg agfsagf asfgaslkgfskafg asfgsafalsfgsafgsf asysalfsiffffffffffff fffffffffff'),
    Messages(
        chat:
            'fgaf agfsg agfsagf asfgaslkgfskafg asfgsafalsfgsafgsf asysalfsiffffffffffff fffffffffff'),
    Messages(
        chat:
            'fgaf agfsg agfsagf asfgaslkgfskafg asfgsafalsfgsafgsf asysalfsiffffffffffff fffffffffff'),
    Messages(
        chat:
            'fgaf agfsg agfsagf asfgaslkgfskafg asfgsafalsfgsafgsf asysalfsiffffffffffff fffffffffff'),
  ];

  static final earnings = [
    GraphItemData(
        dateTime: DateTime.now().add(const Duration(days: 0)), value: 2.44),
    GraphItemData(
        dateTime: DateTime.now().add(const Duration(days: 1)), value: 1.25),
    GraphItemData(
        dateTime: DateTime.now().add(const Duration(days: 2)), value: 2),
    GraphItemData(
        dateTime: DateTime.now().add(const Duration(days: 3)), value: 2),
    GraphItemData(
        dateTime: DateTime.now().add(const Duration(days: 4)), value: 3.24),
    GraphItemData(
        dateTime: DateTime.now().add(const Duration(days: 5)), value: 3.24),
    GraphItemData(
        dateTime: DateTime.now().add(const Duration(days: 6)), value: 3.24),
  ];
}
