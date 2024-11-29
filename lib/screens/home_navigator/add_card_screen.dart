import 'package:car2gouser/controller/menu_screen_controller/add_card_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCardScreenController>(
        init: AddCardScreenController(),
        builder: (controller) => CustomScaffold(
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleText: 'Add Card',
                hasBackButton: true,
              ),
              body: ScaffoldBodyWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.hGap24,
                    Text(
                      '16 digits number',
                      style: AppTextStyles.bodyLargeMediumTextStyle
                          .copyWith(color: AppColors.primaryTextColor),
                    ),
                    AppGaps.hGap12,
                    CustomTextFormField(
                      controller: controller.cardNumberController,
                      hintText: '1234 5678 9012 1234',
                      textInputType: TextInputType.number,
                      suffixIcon: InkWell(
                        onTap: () {
                          controller.scanBarcode();
                          controller.update();
                        },
                        child: const SvgPictureAssetWidget(
                            AppAssetImages.scannerSVGLogoLine),
                      ),
                    ),
                    AppGaps.hGap24,
                    // Text(
                    //   controller.scanResult.value,
                    //   style: TextStyle(fontSize: 18),
                    // ),
                    Row(children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: controller.expiryDateController,
                          labelText: 'Expiration Date',
                          hintText: 'MM/YY',
                          textInputType: TextInputType.number,
                        ),
                      ),
                      AppGaps.wGap22,
                      Expanded(
                        child: CustomTextFormField(
                          controller: controller.cvvController,
                          labelText: 'CVV / CVC',
                          hintText: '***',
                          textInputType: TextInputType.number,
                          suffixIcon: const SvgPictureAssetWidget(
                              AppAssetImages.quesMarkSVGLogoLine),
                        ),
                      ),
                    ]),
                    AppGaps.hGap24,
                    CustomTextFormField(
                      controller: controller.nameController,
                      labelText: 'Cardholder Name (Optional)',
                      hintText: 'e.g. Liton Nandi',
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                child: CustomStretchedTextButtonWidget(
                  buttonText: 'Add Card',
                  onTap: () {},
                ),
              ),
            ));
  }
}
