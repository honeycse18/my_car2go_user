import 'package:car2gouser/utils/helpers/api_helper.dart';

class DistanceDetails {
  String text;
  int valueAsMeter;

  DistanceDetails({this.text = '', this.valueAsMeter = 0});

  factory DistanceDetails.fromJson(Map<String, dynamic> json) =>
      DistanceDetails(
        text: APIHelper.getSafeString(json['text']),
        valueAsMeter: APIHelper.getSafeInt(json['value'], 0),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': valueAsMeter,
      };

  static DistanceDetails getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DistanceDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DistanceDetails();
}
