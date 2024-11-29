import 'package:car2gouser/models/bottom_sheet_paramers/profile_entry_gender_bottom_sheet_parameter.dart';
import 'package:car2gouser/models/enums/gender.dart';
import 'package:car2gouser/models/fakeModel/fake_data.dart';
import 'package:car2gouser/models/payment_option_model.dart';
import 'package:get/get.dart';

class PaymentBottomsheetController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  int selectedVerificationMethodIndex = 0;
  String id = '';
  int selectedReasonIndex = 0;
  int selectedPaymentMethodIndex = 0;

  SelectPaymentOptionModel selectedPaymentOption =
      FakeData.paymentOptionLists[0];
  SelectPaymentOptionModel getValues = SelectPaymentOptionModel();
  SelectPaymentOptionModel paymentOptionList = SelectPaymentOptionModel();
  /*<----------- Submit button tap ----------->*/
  onSubmitButtonTap() {
    SelectPaymentOptionModel selectedOption =
        FakeData.paymentOptionLists[selectedReasonIndex];

    Get.back(result: selectedOption);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
