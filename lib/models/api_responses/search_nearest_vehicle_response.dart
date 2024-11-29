import 'package:car2gouser/models/api_responses/commons/duration.dart';
import 'package:car2gouser/models/api_responses/commons/location_position.dart';
import 'package:car2gouser/models/enums/gender.dart';
import 'package:car2gouser/models/api_responses/commons/distance.dart';
import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/extensions/datetime.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';

class SearchNearestVehiclesResponse {
  List<NearestVehicle> nearestVehicles;
  List<NearestVehiclesCategory> categories;

  SearchNearestVehiclesResponse(
      {this.nearestVehicles = const [], this.categories = const []});

  factory SearchNearestVehiclesResponse.fromJson(Map<String, dynamic> json) {
    return SearchNearestVehiclesResponse(
      nearestVehicles: APIHelper.getSafeList(json['nearest_vehicles'])
          .map((e) => NearestVehicle.getSafeObject(e))
          .toList(),
      categories: APIHelper.getSafeList(json['categories'])
          .map((e) => NearestVehiclesCategory.getSafeObject(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'nearest_vehicles': nearestVehicles.map((e) => e.toJson()).toList(),
        'category': categories.map((e) => e.toJson()).toList(),
      };

  static SearchNearestVehiclesResponse getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SearchNearestVehiclesResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SearchNearestVehiclesResponse();
}

class NearestVehicle {
  String id;
  String brand;
  String model;
  String year;
  String carNumberPlate;
  List<String> images;
  int seat;
  NearestVehicleDriver driver;
  NearestVehicleCategory category;
  NearestVehicleDriverDistanceFromPickupPoint driverDistanceFromPickupPoint;
  NearestVehicleEstimatedFare estimatedFare;

  NearestVehicle({
    this.id = '',
    this.brand = '',
    this.model = '',
    this.year = '',
    this.carNumberPlate = '',
    this.images = const [],
    this.seat = 0,
    required this.driver,
    required this.category,
    required this.driverDistanceFromPickupPoint,
    required this.estimatedFare,
  });
  factory NearestVehicle.empty() => NearestVehicle(
      driver: NearestVehicleDriver(),
      category: NearestVehicleCategory(),
      driverDistanceFromPickupPoint:
          NearestVehicleDriverDistanceFromPickupPoint.empty(),
      estimatedFare: NearestVehicleEstimatedFare());

  factory NearestVehicle.fromJson(Map<String, dynamic> json) {
    return NearestVehicle(
      id: APIHelper.getSafeString(json['_id']),
      brand: APIHelper.getSafeString(json['brand']),
      model: APIHelper.getSafeString(json['model']),
      year: APIHelper.getSafeString(json['year']),
      carNumberPlate: APIHelper.getSafeString(json['car_number_plate']),
      images: APIHelper.getSafeList(json['images'])
          .map((e) => APIHelper.getSafeString(e))
          .toList(),
      seat: APIHelper.getSafeInt(json['seat'], 0),
      driver: NearestVehicleDriver.getSafeObject(json['driver']),
      category: NearestVehicleCategory.getSafeObject(json['category']),
      driverDistanceFromPickupPoint:
          NearestVehicleDriverDistanceFromPickupPoint.getSafeObject(
              json['driverDistanceFromPickupPoint']),
      estimatedFare:
          NearestVehicleEstimatedFare.getSafeObject(json['estimatedFare']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'brand': brand,
        'model': model,
        'year': year,
        'car_number_plate': carNumberPlate,
        'images': images,
        'seat': seat,
        'driver': driver.toJson(),
        'category': category.toJson(),
        'driverDistanceFromPickupPoint': driverDistanceFromPickupPoint.toJson(),
        'estimatedFare': estimatedFare.toJson(),
      };

  static NearestVehicle getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestVehicle.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : NearestVehicle.empty();
}

class NearestVehicleDriverDistanceFromPickupPoint {
  DistanceDetails distance;
  DurationDetails duration;
  String status;

  NearestVehicleDriverDistanceFromPickupPoint({
    required this.distance,
    required this.duration,
    this.status = '',
  });

  factory NearestVehicleDriverDistanceFromPickupPoint.empty() =>
      NearestVehicleDriverDistanceFromPickupPoint(
          distance: DistanceDetails(), duration: DurationDetails());

  factory NearestVehicleDriverDistanceFromPickupPoint.fromJson(
      Map<String, dynamic> json) {
    return NearestVehicleDriverDistanceFromPickupPoint(
      distance: DistanceDetails.getSafeObject(json['distance']),
      duration: DurationDetails.getSafeObject(json['duration']),
      status: APIHelper.getSafeString(json['status']),
    );
  }

  Map<String, dynamic> toJson() => {
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        'status': status,
      };

  static NearestVehicleDriverDistanceFromPickupPoint getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestVehicleDriverDistanceFromPickupPoint.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestVehicleDriverDistanceFromPickupPoint.empty();
}

class NearestVehicleEstimatedFare {
  double minimumFare;
  double baseFare;
  double perKmCharge;
  String totalKm;
  double perMinuteCharge;
  String totalMin;
  double additionalCost;
  double total;
  double uptoTotalFareAmount;

  NearestVehicleEstimatedFare({
    this.minimumFare = 0,
    this.baseFare = 0,
    this.perKmCharge = 0,
    this.totalKm = '',
    this.perMinuteCharge = 0,
    this.totalMin = '',
    this.additionalCost = 0,
    this.total = 0,
    this.uptoTotalFareAmount = 0,
  });

  factory NearestVehicleEstimatedFare.fromJson(Map<String, dynamic> json) =>
      NearestVehicleEstimatedFare(
        minimumFare: APIHelper.getSafeDouble(json['minimum_fare'], 0),
        baseFare: APIHelper.getSafeDouble(json['base_fare'], 0),
        perKmCharge: APIHelper.getSafeDouble(json['per_km_charge'], 0),
        totalKm: APIHelper.getSafeString(json['total_km']),
        perMinuteCharge: APIHelper.getSafeDouble(json['per_minute_charge'], 0),
        totalMin: APIHelper.getSafeString(json['total_min']),
        additionalCost: APIHelper.getSafeDouble(json['additionalCost'], 0),
        total: APIHelper.getSafeDouble(json['total'], 0),
        uptoTotalFareAmount:
            APIHelper.getSafeDouble(json['uptoTotalFareAmount'], 0),
      );

  Map<String, dynamic> toJson() => {
        'minimum_fare': minimumFare,
        'base_fare': baseFare,
        'per_km_charge': perKmCharge,
        'total_km': totalKm,
        'per_minute_charge': perMinuteCharge,
        'total_min': totalMin,
        'additionalCost': additionalCost,
        'total': total,
        'uptoTotalFareAmount': uptoTotalFareAmount,
      };

  static NearestVehicleEstimatedFare getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestVehicleEstimatedFare.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestVehicleEstimatedFare();
}

class NearestVehicleDriver {
  String id;
  String name;
  String email;
  String phone;
  String gender;
  String image;

  NearestVehicleDriver({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.gender = '',
    this.image = '',
  });

  factory NearestVehicleDriver.fromJson(Map<String, dynamic> json) =>
      NearestVehicleDriver(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
        email: APIHelper.getSafeString(json['email']),
        phone: APIHelper.getSafeString(json['phone']),
        gender: APIHelper.getSafeString(json['gender']),
        image: APIHelper.getSafeString(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'gender': gender,
        'image': image,
      };

  static NearestVehicleDriver getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestVehicleDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestVehicleDriver();
  Gender get genderAsEnum => Gender.toEnumValue(gender);
}

class NearestVehicleCategory {
  String id;
  String name;

  NearestVehicleCategory({this.id = '', this.name = ''});

  factory NearestVehicleCategory.fromJson(Map<String, dynamic> json) =>
      NearestVehicleCategory(
        id: APIHelper.getSafeString(json['_id']),
        name: APIHelper.getSafeString(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static NearestVehicleCategory getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestVehicleCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestVehicleCategory();
}

class NearestVehiclesCategory {
  String id;
  String driver;
  String vehicleType;
  String brand;
  String model;
  String year;
  int seat;
  String carNumberPlate;
  List<String> images;
  String status;
  bool isOnline;
  bool isActive;
  String rideStatus;
  List<NearestVehicleCategoryDynamicField> dynamicFields;
  DateTime createdAt;
  DateTime updatedAt;
  NearestVehicleCategoryLocation location;
  LocationPosition position;
  String category;
  bool isDeleted;
  NearestVehicleCategoryDist dist;

  NearestVehiclesCategory({
    this.id = '',
    this.driver = '',
    this.vehicleType = '',
    this.brand = '',
    this.model = '',
    this.year = '',
    this.seat = 0,
    this.carNumberPlate = '',
    this.images = const [],
    this.status = '',
    this.isOnline = false,
    this.isActive = false,
    this.rideStatus = '',
    this.dynamicFields = const [],
    required this.createdAt,
    required this.updatedAt,
    required this.location,
    required this.position,
    this.category = '',
    this.isDeleted = false,
    required this.dist,
  });
  factory NearestVehiclesCategory.empty() => NearestVehiclesCategory(
      createdAt: AppConstants.defaultUnsetDateTime,
      updatedAt: AppConstants.defaultUnsetDateTime,
      location: NearestVehicleCategoryLocation(),
      position: LocationPosition(),
      dist: NearestVehicleCategoryDist.empty());

  factory NearestVehiclesCategory.fromJson(Map<String, dynamic> json) {
    return NearestVehiclesCategory(
      id: APIHelper.getSafeString(json['_id']),
      driver: APIHelper.getSafeString(json['driver']),
      vehicleType: APIHelper.getSafeString(json['vehicle_type']),
      brand: APIHelper.getSafeString(json['brand']),
      model: APIHelper.getSafeString(json['model']),
      year: APIHelper.getSafeString(json['year']),
      seat: APIHelper.getSafeInt(json['seat'], 0),
      carNumberPlate: APIHelper.getSafeString(json['car_number_plate']),
      images: APIHelper.getSafeList(json['images'])
          .map((e) => APIHelper.getSafeString(e))
          .toList(),
      status: APIHelper.getSafeString(json['status']),
      isOnline: APIHelper.getSafeBool(json['isOnline']),
      isActive: APIHelper.getSafeBool(json['isActive']),
      rideStatus: APIHelper.getSafeString(json['ride_status']),
      dynamicFields: APIHelper.getSafeList(json['dynamic_fields'])
          .map((e) => NearestVehicleCategoryDynamicField.getSafeObject(e))
          .toList(),
      createdAt: APIHelper.getSafeDateTime(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTime(json['updatedAt']),
      location: NearestVehicleCategoryLocation.getSafeObject(json['location']),
      position: LocationPosition.getSafeObject(json['position']),
      category: APIHelper.getSafeString(json['category']),
      isDeleted: APIHelper.getSafeBool(json['is_deleted']),
      dist: NearestVehicleCategoryDist.getSafeObject(json['dist']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'driver': driver,
        'vehicle_type': vehicleType,
        'brand': brand,
        'model': model,
        'year': year,
        'seat': seat,
        'car_number_plate': carNumberPlate,
        'images': images,
        'status': status,
        'isOnline': isOnline,
        'isActive': isActive,
        'ride_status': rideStatus,
        'dynamic_fields': dynamicFields.map((e) => e.toJson()).toList(),
        'createdAt': createdAt.toServerDateTime(),
        'updatedAt': updatedAt.toServerDateTime(),
        'location': location.toJson(),
        'position': position.toJson(),
        'category': category,
        'is_deleted': isDeleted,
        'dist': dist.toJson(),
      };
  static NearestVehiclesCategory getSafeObject(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestVehiclesCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestVehiclesCategory.empty();
}

class NearestVehicleCategoryDist {
  double calculated;
  NearestVehicleCategoryLocation location;

  NearestVehicleCategoryDist({this.calculated = 0, required this.location});
  factory NearestVehicleCategoryDist.empty() =>
      NearestVehicleCategoryDist(location: NearestVehicleCategoryLocation());

  factory NearestVehicleCategoryDist.fromJson(Map<String, dynamic> json) =>
      NearestVehicleCategoryDist(
        calculated: APIHelper.getSafeDouble(json['calculated'], 0),
        location:
            NearestVehicleCategoryLocation.getSafeObject(json['location']),
      );

  Map<String, dynamic> toJson() => {
        'calculated': calculated,
        'location': location.toJson(),
      };

  static NearestVehicleCategoryDist getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestVehicleCategoryDist.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestVehicleCategoryDist.empty();
}

class NearestVehicleCategoryLocation {
  String type;
  List<double> coordinates;

  NearestVehicleCategoryLocation({this.type = '', this.coordinates = const []});

  factory NearestVehicleCategoryLocation.fromJson(Map<String, dynamic> json) =>
      NearestVehicleCategoryLocation(
        type: APIHelper.getSafeString(json['type']),
        coordinates: APIHelper.getSafeList(json['coordinates'])
            .map((e) => APIHelper.getSafeDouble(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };

  static NearestVehicleCategoryLocation getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestVehicleCategoryLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestVehicleCategoryLocation();
}

class NearestVehicleCategoryDynamicField {
  String key;
  List<dynamic> value;
  String type;

  NearestVehicleCategoryDynamicField(
      {this.key = '', this.value = const [], this.type = ''});

  factory NearestVehicleCategoryDynamicField.fromJson(
          Map<String, dynamic> json) =>
      NearestVehicleCategoryDynamicField(
        key: APIHelper.getSafeString(json['key']),
        value: APIHelper.getSafeList(json['value']).map((e) => e).toList(),
        type: APIHelper.getSafeString(json['type']),
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
        'type': type,
      };

  static NearestVehicleCategoryDynamicField getSafeObject(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestVehicleCategoryDynamicField.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestVehicleCategoryDynamicField();
}
