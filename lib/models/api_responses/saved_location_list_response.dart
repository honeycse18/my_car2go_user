import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class SavedLocationListResponse {
  bool error;
  String msg;
  List<SavedLocationListSingleLocation> data;

  SavedLocationListResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory SavedLocationListResponse.fromJson(Map<String, dynamic> json) {
    return SavedLocationListResponse(
      error: APIHelper.getSafeBool(json['error']),
      msg: APIHelper.getSafeString(json['msg']),
      data: APIHelper.getSafeList(json['data'])
          .map((e) =>
              SavedLocationListSingleLocation.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static SavedLocationListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedLocationListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedLocationListResponse();
}

class SavedLocationListSingleLocation {
  SavedLocationListLocation location;
  String id;
  String user;
  String label;
  String name;
  String address;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  SavedLocationListSingleLocation({
    required this.location,
    this.id = '',
    this.user = '',
    this.label = '',
    this.name = '',
    this.address = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory SavedLocationListSingleLocation.fromJson(Map<String, dynamic> json) =>
      SavedLocationListSingleLocation(
        location: SavedLocationListLocation.getAPIResponseObjectSafeValue(
            json['location']),
        id: APIHelper.getSafeString(json['_id']),
        user: APIHelper.getSafeString(json['user']),
        label: APIHelper.getSafeString(json['label']),
        name: APIHelper.getSafeString(json['name']),
        address: APIHelper.getSafeString(json['address']),
        createdAt: APIHelper.getSafeDateTime(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
        v: APIHelper.getSafeInt(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        '_id': id,
        'user': user,
        'label': label,
        'name': name,
        'address': address,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory SavedLocationListSingleLocation.empty() =>
      SavedLocationListSingleLocation(
          location: SavedLocationListLocation(),
          createdAt: AppComponents.defaultUnsetDateTime,
          updatedAt: AppComponents.defaultUnsetDateTime);
  static SavedLocationListSingleLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedLocationListSingleLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedLocationListSingleLocation.empty();
}

class SavedLocationListLocation {
  double lat;
  double lng;

  SavedLocationListLocation({this.lat = 0, this.lng = 0});

  factory SavedLocationListLocation.fromJson(Map<String, dynamic> json) =>
      SavedLocationListLocation(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static SavedLocationListLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedLocationListLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedLocationListLocation();
}
