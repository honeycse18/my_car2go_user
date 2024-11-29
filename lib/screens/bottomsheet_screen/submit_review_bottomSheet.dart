import 'package:car2gouser/controller/submit_review_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class SubmitReviewBottomSheetScreen extends StatelessWidget {
  const SubmitReviewBottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubmitReviewBottomSheetScreenController>(
        init: SubmitReviewBottomSheetScreenController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.only(
                top: 24,
              ),
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: ScaffoldBodyWidget(
                child: SingleChildScrollView(
                  /*<------- Submitting Review form------>*/
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: controller.submitReviewFormKey,
                    child: Column(
                      children: [
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
                                  .submitReviewTransKey.toCurrentLanguage,
                              style: AppTextStyles.titleBoldTextStyle,
                            ),
                            AppGaps.wGap30,
                            const Spacer(),
                          ],
                        ),
                        AppGaps.hGap20,
                        /*<------- Set driver's rating ------>*/
                        Obx(
                          () => RatingBar.builder(
                            initialRating: controller.rating.value,
                            minRating: 0.5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) =>
                                const SvgPictureAssetWidget(
                              AppAssetImages.starSVGLogoSolid,
                              color: AppColors.primaryColor,
                            ),
                            onRatingUpdate: controller.setRating,
                          ),
                        ),
                        AppGaps.hGap10,
                        /*<-------Rating title  ------>*/
                        Obx(
                          () => Text(
                            controller.rating.value < 1
                                ? AppLanguageTranslation
                                    .weakTransKey.toCurrentLanguage
                                : controller.rating.value < 2
                                    ? AppLanguageTranslation
                                        .emergingTransKey.toCurrentLanguage
                                    : controller.rating.value < 3
                                        ? AppLanguageTranslation
                                            .goodTransKey.toCurrentLanguage
                                        : controller.rating.value < 4
                                            ? AppLanguageTranslation
                                                .strongTransKey
                                                .toCurrentLanguage
                                            : controller.rating.value < 5
                                                ? AppLanguageTranslation
                                                    .excellentTransKey
                                                    .toCurrentLanguage
                                                : AppLanguageTranslation
                                                    .bestTransKey
                                                    .toCurrentLanguage,
                            style: AppTextStyles.titleBoldTextStyle,
                          ),
                        ),
                        AppGaps.hGap10,
                        Obx(
                          () => Text(
                            '${AppLanguageTranslation.youRatedTransKey.toCurrentLanguage} ${controller.rating.value} ${AppLanguageTranslation.starTransKey.toCurrentLanguage}',
                            style: AppTextStyles.bodyLargeMediumTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          ),
                        ),
                        AppGaps.hGap30,
                        /*<-------Sharing experience with the driver  ------>*/
                        CustomTextFormField(
                          validator: Helper.textFormValidator,
                          controller: controller.commentTextEditingController,
                          labelText: AppLanguageTranslation
                              .writeSomethingAboutYourExperienceTransKey
                              .toCurrentLanguage,
                          hintText: 'Write Something........',
                          maxLines: 5,
                        ),
                        AppGaps.hGap30,
                        CustomStretchedButtonWidget(
                          onTap: controller.submitRentReview,
                          child: Text(AppLanguageTranslation
                              .submitReviewTransKey.toCurrentLanguage),
                        ),
                        AppGaps.hGap20,
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
