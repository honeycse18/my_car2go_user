import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class CreateNewAddressResponse {
  String user;
  String name;
  String address;
  Location location;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  CreateNewAddressResponse({
    this.user = '',
    this.name = '',
    this.address = '',
    required this.location,
    this.id = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory CreateNewAddressResponse.fromJson(Map<String, dynamic> json) {
    return CreateNewAddressResponse(
      user: APIHelper.getSafeString(json['user']),
      name: APIHelper.getSafeString(json['name']),
      address: APIHelper.getSafeString(json['address']),
      location: Location.getAPIResponseObjectSafeValue(json['location']),
      id: APIHelper.getSafeString(json['_id']),
      createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      v: APIHelper.getSafeInt(json['__v']),
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user,
        'name': name,
        'address': address,
        'location': location.toJson(),
        '_id': id,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory CreateNewAddressResponse.empty() => CreateNewAddressResponse(
        location: Location(),
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static CreateNewAddressResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CreateNewAddressResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CreateNewAddressResponse.empty();
}

class Location {
  double lat;
  double lng;

  Location({this.lat = 0, this.lng = 0});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static Location getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Location.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Location();
}
