import 'package:car2gouser/services/profile_service.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  final profileService = Get.find<ProfileService>();
  /* <---- Splash screen shows for 2 seconds and go to intro screen ----> */
  Future<void> _serviceInitializationOnSplash() async {
    await profileService.initialization();
  }

  Future<void> delayAndGotoNextScreen() async {
    await _serviceInitializationOnSplash();
    await AppSingleton.instance.updateSiteSettings();
    await Future.delayed(const Duration(seconds: 3));

    Get.offNamedUntil(_pageRouteName, (_) => false);
  }

/* <---- Go to next page ----> */
  String get _pageRouteName {
    final String pageRouteName;
    if (Helper.isUserLoggedIn()) {
      pageRouteName = AppPageNames.zoomDrawerScreen;
    } else {
      pageRouteName = AppPageNames.introScreen;
    }
    return pageRouteName;
  }

/* <---- Initial state ----> */
  @override
  void onInit() {
    // Get.put(SocketController());

    delayAndGotoNextScreen();
    super.onInit();
  }
}
