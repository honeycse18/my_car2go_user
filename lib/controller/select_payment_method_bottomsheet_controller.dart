import 'package:car2gouser/models/fakeModel/fake_data.dart';
import 'package:car2gouser/models/payment_option_model.dart';
import 'package:get/get.dart';

class SelectPaymentMethodBottomsheetController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  int selectedReasonIndex = 0;

  SelectPaymentOptionModel paymentOptionList = SelectPaymentOptionModel();

  /*<----------- Submit button tap ----------->*/
  onSubmitButtonTap() {
    SelectPaymentOptionModel selectedOption =
        FakeData.paymentOptionList[selectedReasonIndex];

    Get.back(result: selectedOption);
  }
}
