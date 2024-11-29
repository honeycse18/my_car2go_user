import 'package:car2gouser/models/payment_option_model.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants/app_images.dart';

class PaymentItemWidget extends StatelessWidget {
  // final String vehicleCategory;
  // final int seat;
  // final String amount;
  // final String image;
  // final bool isSelected;
  final void Function() onTap;
  const PaymentItemWidget(
      {
      //   required this.vehicleCategory,
      // required this.seat,
      // required this.amount,
      // required this.image,
      // this.isSelected = false,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      onTap: onTap,
      child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.fromBorderColor, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, top: 12, right: 12, bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppAssetImages.infoSVGLogoLine),
                    // Text(paymentType,
                    //     style: AppTextStyles.semiSmallXBoldTextStyle),
                    AppGaps.wGap5,
                  ],
                ),
                // CustomRadioWidget(
                //   value: index,
                //   groupValue: selectedVerificationOptionIndex,
                //   onChanged: radioOnChange),
              ],
            ),
          )),
    );
  }
}

/// Payment option list tile widget from checkout screen
class SelectVerificationMethodWidget extends StatelessWidget {
  const SelectVerificationMethodWidget({
    super.key,
    required this.verificationOption,
    required this.index,
    required this.selectedVerificationOptionIndex,
    required this.radioOnChange,
    this.onTap,
    required this.cancelReason,
    required this.selectedCancelReason,
  });

  final String verificationOption;
  final int index;
  final OptionModel cancelReason;
  final OptionModel selectedCancelReason;
  final int selectedVerificationOptionIndex;
  final void Function(Object?) radioOnChange;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  verificationOption,
                  style: AppTextStyles.labelTextStyle,
                ),
                AppGaps.wGap16,
                CustomRadioWidget(
                    value: index,
                    groupValue: selectedVerificationOptionIndex,
                    onChanged: radioOnChange),
              ],
            ),
            AppGaps.hGap10,
            Divider(
              color: AppColors.secondaryTextColor,
            ),
          ],
        ));
  }
}
