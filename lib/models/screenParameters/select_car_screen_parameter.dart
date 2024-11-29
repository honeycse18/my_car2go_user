import 'package:car2gouser/models/api_responses/commons/location_position.dart';
import 'package:car2gouser/models/enums/ride_type.dart';
import 'package:car2gouser/models/location_model.dart';

class SelectCarScreenParameter {
  final LocationModel pickupLocation;
  final LocationModel dropLocation;
  // final bool isScheduleRide;
  final RideType rideType;
  final DateTime? selectedDate;
  final LocationPosition? currentLocation;
  SelectCarScreenParameter({
    required this.pickupLocation,
    required this.dropLocation,
    this.selectedDate,
    this.currentLocation,
    // this.rideType = false,
    this.rideType = RideType.rideNow,
  });
}
