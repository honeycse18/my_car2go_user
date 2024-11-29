import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';

/* <---- Transaction widget ----> */

class TransactionWidget extends StatelessWidget {
  final String text1;
  final String text2;

  final Widget icon;
  final Color backColor;
  final String title;
  final DateTime dateTime;

  const TransactionWidget(
      {Key? key,
      required this.title,
      required this.text1,
      required this.text2,
      required this.icon,
      required this.backColor,
      required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        CircleAvatar(maxRadius: 16, backgroundColor: backColor, child: icon),
        AppGaps.wGap10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color.fromARGB(255, 12, 1, 59))),
            Text(
              dayText,
              style: AppTextStyles.captionTextStyle
                  .copyWith(color: AppColors.bodyTextColor),
            ),
          ],
        ),
      ]),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text2,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green)),
          Text(text1,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Colors.green)),
        ],
      ),
    ]);
  }

  String get dayText {
    if (Helper.isToday(dateTime)) {
      return 'Today';
    }
    if (Helper.wasYesterday(dateTime)) {
      return 'Yesterday';
    }
    if (Helper.isTomorrow(dateTime)) {
      return 'Tomorrow';
    }
    return Helper.ddMMMyyyyFormattedDateTime(dateTime);
  }
}
