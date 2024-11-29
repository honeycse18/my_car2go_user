import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

/*<------- Coupon code List widget ------>*/
class AddCouponListWidget extends StatelessWidget {
  final void Function()? onCopyTap;
  final DateTime day;
  final DateTime date;
  final DateTime month;
  final String code;
  final String type;
  final double value;
  final double couponMinimumValue;
  final Widget widget;
  const AddCouponListWidget({
    super.key,
    this.onCopyTap,
    required this.day,
    required this.date,
    required this.month,
    required this.code,
    required this.type,
    required this.value,
    required this.couponMinimumValue,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 147,
        width: 360,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.fromBorderColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r'10%  Discount Upto $100 Trips ',
                    style: AppTextStyles.bodyLargeSemiboldTextStyle
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  AppGaps.hGap4,
                  Text(
                    'Enjoy hassle-free rides at discounted rates with our exclusive Ride Share',
                    style: AppTextStyles.bodyLargeSemiboldTextStyle
                        .copyWith(color: AppColors.secondaryFont2Color),
                  ),
                  AppGaps.hGap8,
                ],
              ),
            ),
            SizedBox(
              height: 10,
              child: LayoutBuilder(
                builder: (context, constraints) => Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  children: List.generate(
                    (constraints.constrainWidth() / 18).floor(),
                    (index) => Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.dotColor,
                              border:
                                  Border.all(color: AppColors.fromBorderColor)),
                        ),
                        AppGaps.wGap5,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Expiration date text
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Expire: ',
                          style: AppTextStyles.bodySmallTextStyle
                              .copyWith(color: AppColors.primaryTextColor)),
                      Text('20 Oct 2024',
                          style: AppTextStyles.bodySmallSemiboldTextStyle
                              .copyWith(color: AppColors.primaryColor)),
                    ],
                  ),
                  widget
                ],
              ),
            ),
          ],
        ));
  }
}
