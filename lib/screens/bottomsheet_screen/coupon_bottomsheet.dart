import 'package:car2gouser/controller/coupon_bottomsheet_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponBottomsheet extends StatelessWidget {
  final String btnText;
  const CouponBottomsheet({required this.btnText, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponBottomsheetController>(
        init: CouponBottomsheetController(),
        builder: (controller) {
          return SizedBox(
            height: context.height * 0.32,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Add New Coupon",
                                style: AppTextStyles
                                    .titleSemiSmallSemiboldTextStyle
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                            AppGaps.hGap28,
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Enter Coupon Code',
                                style: AppTextStyles.bodyLargeMediumTextStyle
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                            AppGaps.hGap8,
                            TextField(
                              controller: controller.textController,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Image.asset(AppAssetImages.couponIconImage),
                                hintText: ' e,g, haddjadh',
                                hintStyle: AppTextStyles.bodyLargeTextStyle
                                    .copyWith(color: AppColors.bodyTextColor),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            AppGaps.hGap16,
                            CustomStretchedButtonWidget(
                              onTap: controller.onContinueButtonTap,
                              child: const Text('Add Coupon'),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          );
        });
  }
} /**/
