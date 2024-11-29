import 'dart:ui';

import 'package:car2gouser/controller/payment_bottomsheet_controller.dart';

import 'package:car2gouser/models/fakeModel/fake_data.dart';
import 'package:car2gouser/screens/bottomsheet_screen/ride_ongoing_dialog.dart';

import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/core_widgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../utils/constants/app_colors.dart';

class PaymentBottomsheet extends StatelessWidget {
  const PaymentBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentBottomsheetController>(
        init: PaymentBottomsheetController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 418,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    backgroundColor: AppColors.backgroundColor,
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    leading: Center(
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: SvgPictureAssetWidget(
                            AppAssetImages.arrowLeftBackSVGLogoLine,
                            color: AppColors.primaryTextColor,
                            height: 24,
                            width: 24,
                          )),
                    ),
                    title: const Text(
                      'Select Payment Method',
                      style: AppTextStyles.titleMediumTextStyle,
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Divider(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
