import 'package:car2gouser/models/enums/profile_field_name.dart';

class ProfileEntryTextFieldBottomSheetParameter {
  final ProfileFieldName profileFieldName;
  final String initialValue;

  ProfileEntryTextFieldBottomSheetParameter({
    required this.profileFieldName,
    required this.initialValue,
  });
}
