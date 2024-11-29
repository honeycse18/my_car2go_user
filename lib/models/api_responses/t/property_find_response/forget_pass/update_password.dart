import 'package:car2gouser/utils/helpers/api_helper.dart';

class UpdatePassword {
  String type;
  String identifier;

  UpdatePassword({this.type = '', this.identifier = ''});

  factory UpdatePassword.fromJson(Map<String, dynamic> json) {
    return UpdatePassword(
      type: APIHelper.getSafeString(json['type']),
      identifier: APIHelper.getSafeString(json['identifier']),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'identifier': identifier,
      };

  static UpdatePassword getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UpdatePassword.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : UpdatePassword();
}
