/*<-------Per intro page content widget------>*/
import 'package:car2gouser/screens/bottomsheet_screen/delete_card_bottomsheet.dart';
import 'package:car2gouser/screens/bottomsheet_screen/edit_card_bottomsheet.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddNewCardWidget extends StatelessWidget {
  const AddNewCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.fromBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              height: 32,
              width: 48,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.fromBorderColor)),
              child: Image.asset(AppAssetImages.visaIconImage),
            ),
            AppGaps.wGap4,
            Container(
              height: 32,
              width: 48,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.fromBorderColor)),
              child: Image.asset(AppAssetImages.moneyIconImage),
            ),
            AppGaps.wGap16,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Card',
                  style: AppTextStyles.bodyLargeSemiboldTextStyle
                      .copyWith(color: AppColors.primaryColor),
                ),
                Text(
                  'Save and pay via card',
                  style: AppTextStyles.bodySmallTextStyle
                      .copyWith(color: AppColors.bodyTextColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddedNewCardWidget extends StatelessWidget {
  final String cardName;
  final String cardNumber;
  final String img;
  const AddedNewCardWidget(
      {Key? key,
      required this.cardName,
      required this.cardNumber,
      required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.fromBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 32,
                  width: 48,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.fromBorderColor)),
                  child: Image.asset(img),
                ),
                AppGaps.wGap16,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardName,
                      style: AppTextStyles.bodyLargeSemiboldTextStyle
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    Text(
                      cardNumber,
                      style: AppTextStyles.bodySmallTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                RawButtonWidget(
                  onTap: () {
                    Get.bottomSheet(const DeleteCardBottomsheet());
                  },
                  child: SvgPicture.asset(AppAssetImages.trashIconSVGLogoLine),
                ),
                AppGaps.wGap12,
                SizedBox(
                  height: 26,
                  width: 41,
                  child: CustomStretchedButtonWidget(
                    onTap: () {
                      Get.bottomSheet(const EditCardBottomsheet());
                    },
                    child: Text(
                      AppLanguageTranslation.editTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodySmallMediumTextStyle,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
