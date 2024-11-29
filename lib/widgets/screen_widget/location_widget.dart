import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationDetailsWidget extends StatelessWidget {
  final String pickupLocation;
  final String dropLocation;
  final String distance;
  final Color iconColor;
  final Color lineColor;
  final Color boxColor;
  final Color primaryTextColor;
  final Color bodyTextColor;

  const LocationDetailsWidget({
    Key? key,
    required this.pickupLocation,
    required this.dropLocation,
    required this.distance,
    this.iconColor = AppColors.bodyTextColor2,
    this.lineColor = AppColors.grayShadeColor,
    this.boxColor = AppColors.containerBoxColor,
    this.primaryTextColor = AppColors.primaryTextColor,
    this.bodyTextColor = AppColors.bodyTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  AppAssetImages.pickUpLocationSVGLogoLine,
                  color: iconColor,
                  height: 20,
                  width: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: 1,
                  color: lineColor,
                ),
                SvgPicture.asset(
                  AppAssetImages.dropUpLocationSVGLogoLine,
                  color: iconColor,
                  height: 20,
                  width: 20,
                ),
              ],
            ),
            AppGaps.wGap4,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pickup Location',
                    style: AppTextStyles.bodySmallTextStyle.copyWith(
                      color: bodyTextColor,
                    ),
                  ),
                  AppGaps.hGap4,
                  Text(
                    pickupLocation,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyMediumTextStyle,
                  ),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        color: lineColor,
                        height: 1,
                        width: double.infinity,
                      ),
                      Positioned(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: boxColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            distance,
                            style: AppTextStyles.bodySmallSemiboldTextStyle
                                .copyWith(
                              color: primaryTextColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppGaps.hGap12,
                  Text(
                    'Drop Location',
                    style: AppTextStyles.bodySmallTextStyle.copyWith(
                      color: bodyTextColor,
                    ),
                  ),
                  AppGaps.hGap4,
                  Text(
                    dropLocation,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeMediumTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
