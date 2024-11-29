import 'package:car2gouser/controller/cancel_ride_reason_controller.dart';
import 'package:car2gouser/models/fakeModel/fake_data.dart';
import 'package:car2gouser/models/fakeModel/intro_content_model.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/cancel_reason_screen_widgets.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseReasonCancelRide extends StatelessWidget {
  const ChooseReasonCancelRide({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CancelRideReasonController>(
      init: CancelRideReasonController(),
      builder: (controller) => CustomScaffold(
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText: 'Cancel Reason',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              AppGaps.hGap24,
              Text('Please select a reason for booking cancellations:',
                  style: AppTextStyles.walletBalanceSemiBold.copyWith(
                    color: AppColors.bodyTextColor,
                  )),
              AppGaps.hGap24,
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList.separated(
                      itemCount: FakeData.cancelRideReason.length,
                      itemBuilder: (context, index) {
                        final cancelReason = FakeData.cancelRideReason[index];
                        return CancelReasonOptionListTileWidget(
                          cancelReason: cancelReason,
                          selectedCancelReason: controller.selectedCancelReason,
                          reasonName: cancelReason.reasonName,
                          hasShadow: controller.selectedReasonIndex == index,
                          onTap: () {
                            controller.selectedReasonIndex = index;
                            controller.selectedCancelReason = cancelReason;
                            controller.update();
                          },
                          onChanged: (isChecked) {
                            if (isChecked == true) {
                              controller.selectedReasonIndex = index;
                              controller.selectedCancelReason = cancelReason;
                            } else {
                              controller.selectedReasonIndex = -1;
                              controller.selectedCancelReason =
                                  FakeCancelRideReason();
                            }
                            controller.update();
                          },
                          index: index,
                          isSelected: controller.selectedReasonIndex == index,
                        );
                      },
                      separatorBuilder: (context, index) => AppGaps.hGap24,
                    ),
                    const SliverToBoxAdapter(child: AppGaps.hGap16),
                    if (controller.selectedCancelReason.reasonName == 'Other')
                      SliverToBoxAdapter(
                        child: CustomTextFormField(
                          controller: controller.otherReasonTextController,
                          hintText: 'Write your reason here...',
                          maxLines: 3,
                        ),
                      ),
                    const SliverToBoxAdapter(child: AppGaps.hGap16),
                  ],
                ),
              ),
              CustomStretchedTextButtonWidget(
                buttonText: 'Confirm Cancel',
                onTap: controller.onSubmitButtonTap,
              ),
              AppGaps.hGap16,
            ],
          ),
        ),
      ),
    );
  }
}
