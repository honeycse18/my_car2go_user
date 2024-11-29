import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/* <---- Notification box ----> */

class NotificationBox extends StatelessWidget {
  String title;
  String text;
  String timetext;
  Color color;
  String img;
  NotificationBox({
    super.key,
    required this.title,
    required this.text,
    required this.timetext,
    required this.color,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 110,
            decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPictureAssetWidget(
                      color: color, height: 40, width: 40, img),
                  AppGaps.wGap10,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.bodyLargeMediumTextStyle,
                      ),
                      Text(
                        text,
                        style: AppTextStyles.bodySmallMediumTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      Text(
                        timetext,
                        style: AppTextStyles.bodyMediumTextStyle.copyWith(
                            color: AppColors.unSelectVehicleBorderColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
