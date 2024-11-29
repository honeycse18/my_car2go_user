import 'package:car2gouser/models/api_responses/profile_details.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:get/get.dart';

class ProfileService extends GetxService {
  final Rx<ProfileDetails> profileDetailsRX = ProfileDetails.empty().obs;
  ProfileDetails get profileDetails => profileDetailsRX.value;
  set profileDetails(ProfileDetails value) {
    profileDetailsRX.value = value;
  }

  Future<void> initialization() async {
    profileDetails = Helper.getUser();
  }
}
