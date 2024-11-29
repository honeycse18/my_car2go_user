import 'package:car2gouser/models/enums/gender.dart';
import 'package:car2gouser/models/enums/profile_field_name.dart';

class ProfileEntryTextFieldBottomSheetParameter {
  final ProfileFieldName profileFieldName;
  final String initialValue;

  ProfileEntryTextFieldBottomSheetParameter({
    required this.profileFieldName,
    required this.initialValue,
  });
}

class ProfileEntryGenderBottomSheetParameter {
  final Gender profileGenderName;

  ProfileEntryGenderBottomSheetParameter({
    required this.profileGenderName,
  });
}

class ProfileEntryDoubleImageBottomSheetParameter {
  final ProfileFieldName profileFieldName;
  final String frontImage;
  final String backImage;

  ProfileEntryDoubleImageBottomSheetParameter({
    required this.profileFieldName,
    required this.frontImage,
    required this.backImage,
  });
}
