import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*<------- Coupon code List widget ------>*/
class ApplyCouponListWidget extends StatelessWidget {
  final void Function()? onCopyTap;
  final DateTime day;
  final DateTime date;
  final DateTime month;
  final String code;
  final String type;
  final double value;
  final double couponMinimumValue;
  const ApplyCouponListWidget({
    super.key,
    this.onCopyTap,
    required this.day,
    required this.date,
    required this.month,
    required this.code,
    required this.type,
    required this.value,
    required this.couponMinimumValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 360,
        decoration: BoxDecoration(
          color: AppColors.fromBorderColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
                top: 30,
                left: -25,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.fromInnerColor),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 25),
              child: Column(
                children: [
                  Text(
                    Helper.eeeFormattedDate(day),
                    style: AppTextStyles.bodySmallTextStyle
                        .copyWith(color: AppColors.bodyTextColor),
                  ),
                  AppGaps.hGap2,
                  Text(
                    Helper.ddFormattedDate(date),
                    style: AppTextStyles.bodyYBoldTextStyle
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  AppGaps.hGap2,
                  Text(
                    Helper.mmFormattedDate(month),
                    style: AppTextStyles.bodySmallTextStyle
                        .copyWith(color: AppColors.bodyTextColor),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 80,
              top: 10,
              child: Center(
                child: Container(
                  height: 80,
                  width: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColors.fromInnerColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 110, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$value TK Off',
                          style: AppTextStyles.bodyBoldTextStyle
                              .copyWith(color: AppColors.primaryColor),
                        ),
                        AppGaps.hGap4,
                        Text(
                          'Over $couponMinimumValue TK',
                          style: AppTextStyles.bodySmallTextStyle
                              .copyWith(color: AppColors.bodyTextColor),
                        ),
                        AppGaps.hGap4,
                        Text(
                          'Code: $code',
                          style: AppTextStyles.bodySmallMediumTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 32,
                      width: 89,
                      child: RawButtonWidget(
                          borderRadiusValue: 10.0,
                          backgroundColor: AppColors.secondaryColor,
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(text: code));
                            Helper.showSnackBar('Coupon code copied');
                          },
                          child: Center(
                            child: Text(
                                AppLanguageTranslation
                                    .copyTransKey.toCurrentLanguage,
                                style: AppTextStyles.bodyBoldTextStyle.copyWith(
                                  color: AppColors.primaryButtonColor,
                                )),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 30,
                right: -25,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.fromInnerColor),
                ))
          ],
        ));
  }
}
