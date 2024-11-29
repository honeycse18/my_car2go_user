import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class SavedAddressItem {
  String user;
  String name;
  String address;
  AddressLocation location;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  SavedAddressItem({
    this.user = '',
    this.name = '',
    this.address = '',
    required this.location,
    this.id = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory SavedAddressItem.empty() => SavedAddressItem(
        location: AddressLocation(),
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );

  factory SavedAddressItem.fromJson(Map<String, dynamic> json) {
    return SavedAddressItem(
      user: APIHelper.getSafeString(json['user']),
      name: APIHelper.getSafeString(json['name']),
      address: APIHelper.getSafeString(json['address']),
      location: AddressLocation.getSafeObject(json['location']),
      id: APIHelper.getSafeString(json['_id']),
      createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
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
      };

  static SavedAddressItem getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedAddressItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedAddressItem.empty();
}

class AddressLocation {
  double lat;
  double lng;

  AddressLocation({this.lat = 0, this.lng = 0});

  factory AddressLocation.fromJson(Map<String, dynamic> json) =>
      AddressLocation(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static AddressLocation getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AddressLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AddressLocation();
}
