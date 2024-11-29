import 'package:car2gouser/controller/menu_screen_controller/add_coupon_page_controller.dart';
import 'package:car2gouser/controller/menu_screen_controller/apply_coupon_page_controller.dart';
import 'package:car2gouser/models/api_responses/coupon_code_list_response.dart';
import 'package:car2gouser/screens/bottomsheet_screen/coupon_bottomsheet.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/apply_coupon_code_list_widget.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/coupon_code_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ApplyCouponScreen extends StatelessWidget {
  const ApplyCouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplyCouponScreenController>(
      init: ApplyCouponScreenController(),
      global: false,
      builder: (controller) => CustomScaffold(
        /*<------- AppBar ------>*/

        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText:
              AppLanguageTranslation.applycouponTransKey.toCurrentLanguage,
          hasBackButton: true,
        ),
        /*<------- Body Content ------>*/

        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGaps.hGap32,
              Expanded(
                  child: controller.couponList.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            CouponList couponList =
                                controller.couponList[index];
                            /* <---- Coupon widget----> */
                            return ApplyCouponListWidget(
                              code: couponList.code,
                              type: couponList.type,
                              date: couponList.endDuration,
                              month: couponList.endDuration,
                              day: couponList.endDuration,
                              value: couponList.value,
                              couponMinimumValue:
                                  couponList.couponMinimumAmount,
                            );
                          },
                          separatorBuilder: (context, index) => AppGaps.hGap16,
                          itemCount: controller.couponList.length)),
              CustomStretchedButtonWidget(
                onTap: () {
                  Get.bottomSheet(
                      isScrollControlled: true,
                      const CouponBottomsheet(
                        btnText: 'Add Coupon',
                      ));
                },
                child: const Text('Add New Coupon'),
              ),
              AppGaps.hGap20
            ],
          ),
        ),
      ),
    );
  }
}
