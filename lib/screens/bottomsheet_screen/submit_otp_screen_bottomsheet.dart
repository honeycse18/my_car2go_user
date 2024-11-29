import 'dart:developer';

import 'package:action_slider/action_slider.dart';
import 'package:car2gouser/controller/car_pooling/submit_otp_start_trip_bottomsheet_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitOtpStartRideBottomSheet extends StatelessWidget {
  const SubmitOtpStartRideBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubmitOtpStartRideBottomSheetController>(
        init: SubmitOtpStartRideBottomSheetController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 12,
              ),
              height: MediaQuery.of(context).size.height * 0.38,
              decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(children: [
                Container(
                  width: 60,
                  height: 2,
                  color: Colors.grey,
                ),
                AppGaps.hGap27,
                Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        child: const Center(
                            child: SvgPictureAssetWidget(
                          AppAssetImages.arrowLeftSVGLogoLine,
                          color: AppColors.primaryTextColor,
                        )),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      AppLanguageTranslation
                          .submitOtpTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleBoldTextStyle,
                    ),
                    AppGaps.wGap30,
                    const Spacer(),
                  ],
                ),
                AppGaps.hGap27,
                /*<------- verify OTP ------>*/
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppLanguageTranslation
                          .verifyOTPTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodyLargeMediumTextStyle,
                    ),
                    AppGaps.wGap4,
                    Text(
                      AppLanguageTranslation
                          .userProvideThisOtpTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodySmallTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                  ],
                ),
                AppGaps.hGap8,
                /*<-------OTP text field  ------>*/
                CustomTextFormField(
                  textInputType: TextInputType.number,
                  controller: controller.otpTextEditingController,
                  hintText: 'eg,0515',
                ),
                AppGaps.hGap32,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ActionSlider.standard(
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2))
                      ],
                      icon: Transform.scale(
                          scaleX: -1,
                          child: const SvgPictureAssetWidget(
                              AppAssetImages.arrowLeftSVGLogoLine,
                              color: Colors.white)),
                      successIcon: const SvgPictureAssetWidget(
                        AppAssetImages.tickRoundedSVGLogoSolid,
                        color: Colors.white,
                        height: 34,
                        width: 34,
                      ),
                      foregroundBorderRadius:
                          const BorderRadius.all(Radius.circular(18)),
                      backgroundBorderRadius:
                          const BorderRadius.all(Radius.circular(18)),
                      sliderBehavior: SliderBehavior.stretch,
                      width: MediaQuery.of(context).size.width * 0.85,
                      backgroundColor: AppColors.primaryColor,
                      toggleColor: const Color(0xFFF9B56C),
                      controller: controller.actionSliderController,
                      action: (slideController) async {
                        // controller.actionSliderController = slideController;
                        slideController.loading(); //starts loading animation
                        await Future.delayed(const Duration(seconds: 2));
                        await controller.acceptRejectRideRequest();
                        if (controller.isSuccess) {
                          await Future.delayed(const Duration(seconds: 1));
                          slideController.success();
                        } else {
                          slideController.failure();
                          controller.otpTextEditingController.clear();
                          slideController.reset();
                        } //starts success animation

                        // controller.reset();
                        log('successfully tapped');
                        await Future.delayed(const Duration(seconds: 1));

                        // Get.offNamed(AppPageNames.startRideRequestScreen,
                        //     arguments: controller.rideDetails);

                        //resets the slider
                      },
                      child: Text(
                        AppLanguageTranslation
                            .swipeToPickupTransKey.toCurrentLanguage,
                        style: AppTextStyles.notificationDateSection
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ]),
            ));
  }
}
