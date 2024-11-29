import 'package:car2gouser/models/enums/gender.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class ProfileDetails {
  String id;
  String name;
  String email;
  String phone;
  String role;
  String gender;
  bool isVerified;
  String address;
  String status;
  String city;
  DateTime createdAt;
  String image;
  String currentRole;

  ProfileDetails({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.role = '',
    this.gender = '',
    this.isVerified = false,
    this.address = '',
    this.status = '',
    this.city = '',
    required this.createdAt,
    this.image = '',
    this.currentRole = '',
  });

  factory ProfileDetails.empty() =>
      ProfileDetails(createdAt: AppComponents.defaultUnsetDateTime);

  factory ProfileDetails.fromJson(Map<String, dynamic> json) {
    return ProfileDetails(
      id: APIHelper.getSafeString(json['_id']),
      name: APIHelper.getSafeString(json['name']),
      email: APIHelper.getSafeString(json['email']),
      phone: APIHelper.getSafeString(json['phone']),
      role: APIHelper.getSafeString(json['role']),
      gender: APIHelper.getSafeString(json['gender']),
      isVerified: APIHelper.getSafeBool(json['is_verified']),
      address: APIHelper.getSafeString(json['address']),
      status: APIHelper.getSafeString(json['status']),
      city: APIHelper.getSafeString(json['city']),
      createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      image: APIHelper.getSafeString(json['image']),
      currentRole: APIHelper.getSafeString(json['current_role']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
        'gender': gender,
        'is_verified': isVerified,
        'address': address,
        'status': status,
        'city': city,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'image': image,
        'current_role': currentRole,
      };

  static ProfileDetails getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProfileDetails.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ProfileDetails.empty();

  Gender get genderAsEnum => Gender.toEnumValue(gender);

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => isEmpty == false;
}
