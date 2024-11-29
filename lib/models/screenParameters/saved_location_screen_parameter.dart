import 'package:car2gouser/models/location_model.dart';

class SavedLocationScreenParameter {
  String id;
  LocationModel locationModel;
  String? othersText;
  SavedLocationScreenParameter(
      {this.id = '', required this.locationModel, this.othersText = ''});
}
