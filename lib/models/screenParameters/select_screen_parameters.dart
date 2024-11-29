import 'package:car2gouser/models/location_model.dart';

class SelectLocationScreenParameters {
  String? screenTitle;
  bool? showCurrentLocationButton;
  LocationModel? locationModel;
  SelectLocationScreenParameters(
      {this.screenTitle, this.showCurrentLocationButton, this.locationModel});
}
