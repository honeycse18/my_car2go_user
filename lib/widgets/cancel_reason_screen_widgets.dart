import 'package:car2gouser/models/fakeModel/intro_content_model.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CancelReasonOptionListTileWidget extends StatelessWidget {
  const CancelReasonOptionListTileWidget({
    super.key,
    required this.hasShadow,
    required this.reasonName,
    required this.index,
    required this.isSelected,
    required this.onChanged,
    this.onTap,
    required this.cancelReason,
    required this.selectedCancelReason,
  });

  final bool hasShadow;
  final String reasonName;
  final int index;
  final FakeCancelRideReason cancelReason;
  final FakeCancelRideReason selectedCancelReason;
  final bool isSelected;
  final void Function(bool?) onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () => onChanged(!isSelected),
            child: isSelected
                ? SvgPicture.asset(
                    AppAssetImages.selectCheckBoxSVGLogoLine,
                    width: 24,
                    height: 24,
                  )
                : SvgPicture.asset(
                    AppAssetImages.unselectCheckBoxSVGLogoLine,
                    width: 24,
                    height: 24,
                  )),
        AppGaps.wGap16,
        Expanded(
          child: Text(
            reasonName,
            style: AppTextStyles.bodyMediumTextStyle
                .copyWith(color: AppColors.primaryTextColor),
          ),
        ),
      ],
    );
  }
}
