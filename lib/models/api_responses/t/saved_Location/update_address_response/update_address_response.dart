import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class UpdateAddressResponse {
  Location? location;
  String? id;
  String? user;
  String? name;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UpdateAddressResponse({
    this.location,
    this.id,
    this.user,
    this.name,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UpdateAddressResponse.fromJson(Map<String, dynamic> json) {
    return UpdateAddressResponse(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      user: json['user'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        '_id': id,
        'user': user,
        'name': name,
        'address': address,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };

  factory UpdateAddressResponse.empty() => UpdateAddressResponse(
        location: Location(),
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static UpdateAddressResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UpdateAddressResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UpdateAddressResponse.empty();
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
