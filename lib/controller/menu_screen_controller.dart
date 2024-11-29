import 'dart:async';

import 'package:car2gouser/controller/drawer_screen_controller.dart';
import 'package:car2gouser/models/api_responses/profile_details.dart';
import 'package:car2gouser/services/profile_service.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MenuScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final profileService = Get.find<ProfileService>();
  final zoomDrawerScreenController = Get.find<ZoomDrawerScreenController>();
  StreamSubscription<ProfileDetails>? profileUpdateSubscriber;
  ProfileDetails get profileDetails => profileService.profileDetails;
  set profileDetails(ProfileDetails value) {
    profileService.profileDetails = value;
  }

/* <---- Logout button tap ----> */
  void onLogOutButtonTap() async {
    await AppDialogs.showConfirmDialog(
        messageText:
            AppLanguageTranslation.wantToLogoutTransKey.toCurrentLanguage,
        titleText: AppLanguageTranslation.logOutTransKey.toCurrentLanguage,
        onYesTap: () async {
          Helper.logout();
        });
  }

/* <---- Get User Details ----> */
/*   getUserDetails() {
    profileDetails = Helper.getUser();
    update();
  } */

/* <---- Initial state ----> */
  @override
  void onInit() {
    // getUserDetails();
    profileUpdateSubscriber ??= profileService.profileDetailsRX.listen((data) {
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    profileUpdateSubscriber?.cancel();
    profileUpdateSubscriber = null;
    super.onClose();
  }
}
