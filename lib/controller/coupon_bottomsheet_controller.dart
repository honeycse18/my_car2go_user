import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponBottomsheetController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  final textController = TextEditingController();
  void onContinueButtonTap() {
    Get.back(
        //  result: textController.text
        );

    // updateGender(gender.value);
  }
}
