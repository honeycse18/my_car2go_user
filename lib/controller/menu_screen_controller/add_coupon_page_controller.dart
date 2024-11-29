import 'dart:developer';

import 'package:car2gouser/models/api_responses/coupon_code_list_response.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AddCouponScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  List<CouponList> couponList = [];

  /*<-----------Get coupon list from API ----------->*/

  Future<void> getCouponList() async {
    CouponCodeListResponse? response = await APIRepo.getCouponList();
    if (response == null) {
      APIHelper.onError(response?.msg ??
          AppLanguageTranslation
              .noResponseForThisActionTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingSavedLocationList(response);
  }

  onSuccessGettingSavedLocationList(CouponCodeListResponse response) {
    couponList = response.data;
    update();
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    getCouponList();
    super.onInit();
  }
}
