import 'package:car2gouser/controller/socket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class ZoomDrawerScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  SocketController? socketController;
  final zoomDrawerController = ZoomDrawerController();
  Widget nestedScreenWidget = const Scaffold();
  int currentPageIndex = 0;

  @override
  void onInit() {
    try {
      // socketController = Get.find<SocketController>();
      socketController = Get.find<SocketController>();
    } catch (e) {
      socketController = Get.put<SocketController>(SocketController());
    }
    socketController?.initSocket();
    super.onInit();
  }

  @override
  void onClose() {
    socketController?.onClose();
    super.onClose();
  }
}
