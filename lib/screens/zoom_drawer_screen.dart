import 'package:car2gouser/controller/drawer_screen_controller.dart';
import 'package:car2gouser/screens/home_navigator/home_navigator_screen.dart';
import 'package:car2gouser/screens/menu_screen.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class ZoomDrawerScreen extends StatelessWidget {
  const ZoomDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoomDrawerScreenController>(
        global: true,
        init: ZoomDrawerScreenController(),
        builder: (controller) => PopScope(
              onPopInvoked: (didPop) {
                controller.onClose();
              },
              child: Scaffold(
                extendBody: true,
                extendBodyBehindAppBar: true,
                body: ZoomDrawer(
                  //zoom drawer on the left side of the screen
                  // menuBackgroundColor: AppColors.primaryColor.withOpacity(0.5),
                  menuBackgroundColor: AppColors.backgroundColor,
                  controller: controller.zoomDrawerController,
                  menuScreen: const MenuScreen(),
                  mainScreen: const HomeNavigatorScreen(),
                  showShadow: true,
                  style: DrawerStyle.defaultStyle,
                  angle: 0.0,
                  isRtl: false,
                  disableDragGesture: true,
                  androidCloseOnBackTap: true,
                  mainScreenTapClose: true,
                  moveMenuScreen: true,
                ),
              ),
            ));
  }
}
