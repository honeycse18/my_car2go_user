import 'package:car2gouser/models/location_model.dart';

class ShareRideScreenParameter {
  LocationModel pickUpLocation;
  LocationModel dropLocation;
  String type;
  DateTime date;
  int totalSeat;
  ShareRideScreenParameter(
      {required this.pickUpLocation,
      required this.dropLocation,
      required this.type,
      required this.date,
      this.totalSeat = 0});

  factory ShareRideScreenParameter.empty() => ShareRideScreenParameter(
      pickUpLocation: LocationModel.empty(),
      dropLocation: LocationModel.empty(),
      type: '',
      date: DateTime.now());
}
