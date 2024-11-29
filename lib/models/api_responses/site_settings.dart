import 'package:car2gouser/models/sealed_classes/dynamic_field_type.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class SiteSettings {
  String address;
  String currencyCode;
  String currencySymbol;
  String description;
  String email;
  String footer;
  String phone;
  String siteName;
  List<SettingsWithdrawMethodsInfo> withdrawMethodsInfo;
  String logo;
  List<SettingsPaymentGateway> paymentGateway;

  SiteSettings({
    this.address = '',
    this.currencyCode = '',
    this.currencySymbol = '',
    this.description = '',
    this.email = '',
    this.footer = '',
    this.phone = '',
    this.siteName = '',
    this.withdrawMethodsInfo = const [],
    this.logo = '',
    this.paymentGateway = const [],
  });

  factory SiteSettings.fromJson(Map<String, dynamic> json) => SiteSettings(
        address: APIHelper.getSafeString(json['address']),
        currencyCode: APIHelper.getSafeString(json['currency_code']),
        currencySymbol: APIHelper.getSafeString(json['currency_symbol']),
        description: APIHelper.getSafeString(json['description']),
        email: APIHelper.getSafeString(json['email']),
        footer: APIHelper.getSafeString(json['footer']),
        phone: APIHelper.getSafeString(json['phone']),
        siteName: APIHelper.getSafeString(json['site_name']),
        withdrawMethodsInfo:
            APIHelper.getSafeList(json['withdraw_methods_info'])
                .map((e) => SettingsWithdrawMethodsInfo.getSafeObject(e))
                .toList(),
        logo: APIHelper.getSafeString(json['logo']),
        paymentGateway: APIHelper.getSafeList(json['payment_gateway'])
            .map((e) => SettingsPaymentGateway.getSafeObject(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'currency_code': currencyCode,
        'currency_symbol': currencySymbol,
        'description': description,
        'email': email,
        'footer': footer,
        'phone': phone,
        'site_name': siteName,
        'withdraw_methods_info':
            withdrawMethodsInfo.map((e) => e.toJson()).toList(),
        'logo': logo,
        'payment_gateway': paymentGateway.map((e) => e.toJson()).toList(),
      };

  static SiteSettings getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SiteSettings.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : SiteSettings();
  bool get isEmpty =>
      withdrawMethodsInfo.isEmpty ||
      currencyCode.isEmpty ||
      currencySymbol.isEmpty;
  bool get isNotEmpty => isEmpty == false;

  List<SettingsPaymentGateway> get activePaymentGateways =>
      paymentGateway.where((element) => element.isActive).toList();
}

class SettingsPaymentGateway {
  String name;
  String logo;
  bool isActive;

  SettingsPaymentGateway(
      {this.name = '', this.logo = '', this.isActive = false});

  factory SettingsPaymentGateway.fromJson(Map<String, dynamic> json) {
    return SettingsPaymentGateway(
      name: APIHelper.getSafeString(json['name']),
      logo: APIHelper.getSafeString(json['logo']),
      isActive: APIHelper.getSafeBool(json['is_active']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'logo': logo,
        'is_active': isActive,
      };

  static SettingsPaymentGateway getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SettingsPaymentGateway.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SettingsPaymentGateway();

  bool get isEmpty => name.isEmpty || logo.isEmpty;
  bool get isNotEmpty => isEmpty == false;
}

class SettingsWithdrawMethodsInfo {
  String name;
  String type;
  String logo;
  List<String> channels;
  List<SettingsWithdrawRequiredField> requiredFields;
  String id;

  SettingsWithdrawMethodsInfo({
    this.name = '',
    this.type = '',
    this.logo = '',
    this.channels = const [],
    this.requiredFields = const [],
    this.id = '',
  });

  factory SettingsWithdrawMethodsInfo.fromJson(Map<String, dynamic> json) {
    return SettingsWithdrawMethodsInfo(
      name: APIHelper.getSafeString(json['name']),
      type: APIHelper.getSafeString(json['type']),
      logo: APIHelper.getSafeString(json['logo']),
      channels: APIHelper.getSafeList(json['channels'])
          .map((e) => APIHelper.getSafeString(e))
          .toList(),
      requiredFields: APIHelper.getSafeList(json['required_fields'])
          .map((e) => SettingsWithdrawRequiredField.getSafeObject(e))
          .toList(),
      id: APIHelper.getSafeString(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'logo': logo,
        'channels': channels,
        'required_fields': requiredFields.map((e) => e.toJson()).toList(),
        '_id': id,
      };

  static SettingsWithdrawMethodsInfo getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SettingsWithdrawMethodsInfo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SettingsWithdrawMethodsInfo();

  DynamicFieldType get typeAsSealedClass => DynamicFieldType.parse(type: type);
}

class SettingsWithdrawRequiredField {
  String name;
  String type;
  bool isRequired;
  String id;

  SettingsWithdrawRequiredField(
      {this.name = '', this.type = '', this.isRequired = false, this.id = ''});

  factory SettingsWithdrawRequiredField.fromJson(Map<String, dynamic> json) =>
      SettingsWithdrawRequiredField(
        name: APIHelper.getSafeString(json['name']),
        type: APIHelper.getSafeString(json['type']),
        isRequired: APIHelper.getSafeBool(json['required']),
        id: APIHelper.getSafeString(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'required': isRequired,
        '_id': id,
      };

  static SettingsWithdrawRequiredField getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SettingsWithdrawRequiredField.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SettingsWithdrawRequiredField();
}
