import 'package:car2gouser/utils/helpers/api_helper.dart';

class SingleImageUploadData {
  String data;

  SingleImageUploadData({this.data = ''});

  factory SingleImageUploadData.fromJson(Map<String, dynamic> json) {
    return SingleImageUploadData(
      data: APIHelper.getSafeString(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data,
      };

  static SingleImageUploadData getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleImageUploadData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleImageUploadData();
}
