import 'package:car2gouser/controller/menu_screen_controller/add_coupon_page_controller.dart';
import 'package:car2gouser/models/api_responses/coupon_code_list_response.dart';
import 'package:car2gouser/screens/bottomsheet_screen/coupon_bottomsheet.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/coupon_code_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class UseCouponScreen extends StatelessWidget {
  const UseCouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCouponScreenController>(
      init: AddCouponScreenController(),
      global: false,
      builder: (controller) => CustomScaffold(
        /*<------- AppBar ------>*/

        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText: 'Coupon',
          hasBackButton: true,
        ),
        /*<------- Body Content ------>*/

        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGaps.hGap32,
              // Expanded(
              //     child: controller.couponList.isEmpty
              //         ? Center(child: CircularProgressIndicator())
              //         : ListView.separated(
              //             itemBuilder: (context, index) {
              //               CouponList couponList =
              //                   controller.couponList[index];
              //               /* <---- Coupon widget----> */
              //               return AddCouponListWidget(
              //                 widget: SizedBox(
              //                   height: 28,
              //                   width: 58,
              //                   child: CustomStretchedButtonWidget(
              //                     onTap: () {},
              //                     child: Text('Apply'),
              //                   ),
              //                 ),
              //                 code: couponList.code,
              //                 type: couponList.type,
              //                 date: couponList.endDuration,
              //                 month: couponList.endDuration,
              //                 day: couponList.endDuration,
              //                 value: couponList.value,
              //                 couponMinimumValue:
              //                     couponList.couponMinimumAmount,
              //               );
              //             },
              //             separatorBuilder: (context, index) => AppGaps.hGap16,
              //             itemCount: controller.couponList.length)),
              SizedBox(
                  height: 150,
                  child: AddCouponListWidget(
                    widget: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: SizedBox(
                        height: 28,
                        width: 58,
                        child: CustomStretchedButtonWidget(
                          onTap: () {},
                          child: Text(
                            'Apply',
                            style: AppTextStyles.smallestMediumTextStyle,
                          ),
                        ),
                      ),
                    ),
                    code: '24458',
                    type: 'Passenger',
                    date: DateTime(2023, 10, 10),
                    month: DateTime(2023, 10, 10),
                    day: DateTime(2023, 10, 10),
                    value: 20.0,
                    couponMinimumValue: 50.0,
                  )),

              AppGaps.hGap20
            ],
          ),
        ),
      ),
    );
  }
}
