import 'package:car2gouser/models/fakeModel/fake_data.dart';
import 'package:car2gouser/models/fakeModel/intro_content_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelRideReasonController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  int selectedReasonIndex = -1;
  TextEditingController otherReasonTextController = TextEditingController();
  FakeCancelRideReason selectedCancelReason = FakeCancelRideReason();

  /* <---- Submit button tap ----> */
  onSubmitButtonTap() {
    String reason = selectedCancelReason.reasonName == 'Other'
        ? otherReasonTextController.text
        : FakeData.cancelRideReason[selectedReasonIndex].reasonName;

    Get.back(result: reason);
  }
}
