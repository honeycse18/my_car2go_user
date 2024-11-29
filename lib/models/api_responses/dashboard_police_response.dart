import 'package:car2gouser/utils/helpers/api_helper.dart';

class DashboardEmergencyDataResponse {
  bool error;
  String msg;
  PoliceData data;

  DashboardEmergencyDataResponse(
      {this.error = false, this.msg = '', required this.data});

  factory DashboardEmergencyDataResponse.fromJson(Map<String, dynamic> json) {
    return DashboardEmergencyDataResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: PoliceData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory DashboardEmergencyDataResponse.empty() =>
      DashboardEmergencyDataResponse(
        data: PoliceData.empty(),
      );
  static DashboardEmergencyDataResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashboardEmergencyDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DashboardEmergencyDataResponse.empty();
}

class PoliceData {
  Helpline helpline;
  String whatsapp;
  String email;
  PoliceData({
    required this.helpline,
    this.whatsapp = '',
    this.email = '',
  });

  factory PoliceData.fromJson(Map<String, dynamic> json) => PoliceData(
        helpline: Helpline.getAPIResponseObjectSafeValue(json['helpline']),
        whatsapp: APIHelper.getSafeString(json['phone']),
        email: APIHelper.getSafeString(json['email']),
      );

  Map<String, dynamic> toJson() =>
      {'helpline': helpline.toJson(), 'phone': whatsapp, 'email': email};

  factory PoliceData.empty() => PoliceData(
        helpline: Helpline(),
      );
  static PoliceData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PoliceData.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : PoliceData.empty();
}

class Helpline {
  String police;
  String doctor;
  String support;

  Helpline({this.police = '', this.doctor = '', this.support = ''});

  factory Helpline.fromJson(Map<String, dynamic> json) => Helpline(
        police: APIHelper.getSafeString(json['police']),
        doctor: APIHelper.getSafeString(json['doctor']),
        support: APIHelper.getSafeString(json['support']),
      );

  Map<String, dynamic> toJson() => {
        'police': police,
        'doctor': doctor,
        'support': support,
      };

  static Helpline getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Helpline.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Helpline();
}
