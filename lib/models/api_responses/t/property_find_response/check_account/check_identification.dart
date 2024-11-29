import 'package:car2gouser/utils/helpers/api_helper.dart';

class CheckIdentification {
  String id;
  String name;

  CheckIdentification({this.id = '', this.name = ''});

  factory CheckIdentification.fromJson(Map<String, dynamic> json) {
    return CheckIdentification(
      id: APIHelper.getSafeString(json['_id']),
      name: APIHelper.getSafeString(json['name']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static CheckIdentification getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CheckIdentification.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CheckIdentification();
}
