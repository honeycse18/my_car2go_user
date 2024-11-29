import 'package:car2gouser/controller/dialogs/ride_ongoing_dialog_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideOngoingDialog extends StatelessWidget {
  const RideOngoingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideOngoingDialogController>(
        init: RideOngoingDialogController(),
        global: false,
        builder: (controller) => PopScope(
              canPop: false,
              onPopInvoked: (didPop) {
                controller.onClose();
              },
              child: AlertDialogWidget(
                backgroundColor: AppColors.backgroundColor,
                titleWidget: Column(
                  children: [
                    Image.asset(
                      AppAssetImages.ongoingRequestIconImage,
                    ),
                    Text(
                      'Request Ongoing',
                      style: AppTextStyles.titlesemiSmallMediumTextStyle
                          .copyWith(color: AppColors.secondaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                contentWidget: const Text(
                    'Your booking has been placed sent to Md. Sharif Ahmed',
                    style: AppTextStyles.bodySmallTextStyle,
                    textAlign: TextAlign.center),
                actionWidgets: [
                  RawButtonWidget(
                    child: Container(
                      height: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.grayShadeColor2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Cancel Request',
                        style: AppTextStyles.bodyLargeSemiboldTextStyle
                            .copyWith(color: AppColors.errorColor),
                      ),
                    ),
                    onTap: () async {
                      dynamic res = await AppDialogs.showConfirmDialog(
                          messageText:
                              'Are you sure to cancel ongoing request?',
                          onYesTap: () async {
                            Get.back(result: true);
                            Get.back(result: true);
                          },
                          onNoTap: () {
                            Get.back(result: false);
                          },
                          shouldCloseDialogOnceYesTapped: false);
                    },
                  )
                ],
              ),
            ));
  }
}
