import 'package:car2gouser/controller/dialogs/delete_card_bottomsheet_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteCardBottomsheet extends StatelessWidget {
  const DeleteCardBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeleteCardBottomsheetController>(
        init: DeleteCardBottomsheetController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
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
                              Text(
                                "Are you sure you want to Delete card?",
                                style: AppTextStyles.titleSemiboldTextStyle
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                              AppGaps.hGap32,
                              CustomStretchedTextButtonWidget(
                                  onTap: () {},
                                  buttonText: 'Yes, Delete',
                                  backgroundColor: AppColors.errorColor),
                              AppGaps.hGap16,
                              RawButtonWidget(
                                onTap: () {},
                                child: Container(
                                  height: 56,
                                  width: 360,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'No, Keep Ride',
                                    style: AppTextStyles
                                        .bodyLargeSemiboldTextStyle
                                        .copyWith(
                                            color: AppColors
                                                .buttonLightStandardColor),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
} /**/
