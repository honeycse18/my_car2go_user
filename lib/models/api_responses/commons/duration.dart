import 'package:car2gouser/utils/helpers/api_helper.dart';

class DurationDetails {
  String text;
  int valueAsSeconds;

  DurationDetails({this.text = '', this.valueAsSeconds = 0});

  factory DurationDetails.fromJson(Map<String, dynamic> json) =>
      DurationDetails(
        text: APIHelper.getSafeString(json['text']),
        valueAsSeconds: APIHelper.getSafeInt(json['value'], 0),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': valueAsSeconds,
      };

  static DurationDetails getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DurationDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DurationDetails();
}
