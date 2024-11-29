import 'package:car2gouser/controller/choose_reason_cancel_ride_controller.dart';
import 'package:car2gouser/models/fakeModel/fake_data.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/cancel_reason_screen_widgets.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseReasonCancelRideBottomSheet extends StatelessWidget {
  const ChooseReasonCancelRideBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CancelReasonRideBottomSheetController>(
        init: CancelReasonRideBottomSheetController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.all(24),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(children: [
                /*<------- AppBar ------>*/
                AppBar(
                  backgroundColor: AppColors.backgroundColor,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  leading: Center(
                    child: CustomIconButtonWidget(
                        onTap: () {
                          Get.back();
                        },
                        hasShadow: true,
                        child: const SvgPictureAssetWidget(
                          AppAssetImages.arrowLeftSVGLogoLine,
                          color: AppColors.primaryTextColor,
                          height: 18,
                          width: 18,
                        )),
                  ),
                  title: Text(AppLanguageTranslation
                      .chooseAReasonTransKey.toCurrentLanguage),
                ),
                AppGaps.hGap27,
                /*<------- Cancel reason option ------>*/
                Expanded(
                    child: CustomScrollView(
                  slivers: [
                    SliverList.separated(
                      itemCount: FakeData.cancelRideReason.length,
                      itemBuilder: (context, index) {
                        final cancelReason = FakeData.cancelRideReason[index];
                        // return CancelReasonOptionListTileWidget(
                        //   cancelReason: cancelReason,
                        //   selectedCancelReason: controller.selectedCancelReason,
                        //   reasonName: cancelReason.reasonName,
                        //   hasShadow: controller.selectedReasonIndex == index,
                        //   onTap: () {
                        //     controller.selectedReasonIndex = index;
                        //     controller.selectedCancelReason = cancelReason;
                        //     controller.update();
                        //   },
                        //   radioOnChange: (Value) {
                        //     controller.selectedReasonIndex = index;
                        //     controller.selectedCancelReason = cancelReason;
                        //     controller.update();
                        //   },
                        //   index: index,
                        //   selectedPaymentOptionIndex:
                        //       controller.selectedReasonIndex,
                        // );
                      },
                      separatorBuilder: (context, index) => AppGaps.hGap16,
                    ),
                    const SliverToBoxAdapter(child: AppGaps.hGap16),
                    if (controller.selectedCancelReason.reasonName == 'Other')
                      SliverToBoxAdapter(
                        child: CustomTextFormField(
                          controller: controller.otherReasonTextController,
                          hintText: 'Write your reason here......',
                          maxLines: 3,
                        ),
                      ),
                    const SliverToBoxAdapter(child: AppGaps.hGap16),
                  ],
                )),
                /*<-------Submit cancel reason button  ------>*/
                CustomStretchedTextButtonWidget(
                  buttonText: AppLanguageTranslation
                      .submitReasonTransKey.toCurrentLanguage,
                  onTap: controller.onSubmitButtonTap,
                )
              ]),
            ));
  }
}
