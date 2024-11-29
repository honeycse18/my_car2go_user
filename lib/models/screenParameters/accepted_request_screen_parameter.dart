import 'package:car2gouser/models/screenParameters/select_car_screen_parameter.dart';

class AcceptedRequestScreenParameter {
  SelectCarScreenParameter selectedCarScreenParameter;
  String rideId;
  AcceptedRequestScreenParameter(
      {required this.selectedCarScreenParameter, required this.rideId});
}
