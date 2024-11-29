import 'dart:typed_data';

import 'package:get/get.dart';

class ImageZoomScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  dynamic imageData;

  /*<----------- Fetch screen navigation argument----------->*/
  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is String) {
      imageData = argument;
    }
    if (argument is Uint8List) {
      imageData = argument;
    }
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }
}
