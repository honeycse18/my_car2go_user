import 'package:car2gouser/utils/helpers/api_helper.dart';

class MultipleImageUploadData {
  List<String> data;

  MultipleImageUploadData({this.data = const []});

  factory MultipleImageUploadData.fromJson(Map<String, dynamic> json) {
    return MultipleImageUploadData(
      data: APIHelper.getSafeList(json['data'])
          .map((e) => APIHelper.getSafeString(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.map((e) => e).toList(),
      };

  static MultipleImageUploadData getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MultipleImageUploadData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MultipleImageUploadData();
}
