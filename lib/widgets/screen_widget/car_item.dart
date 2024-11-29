import 'package:cached_network_image/cached_network_image.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/double.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CarItem extends StatelessWidget {
  final String vehicleCategory;
  final int seat;
  final double amount;
  final String distance;
  final String imageURL;
  final String time;
  final bool isSelected;
  final void Function()? onTap;
  const CarItem(
      {required this.vehicleCategory,
      required this.seat,
      required this.amount,
      required this.distance,
      required this.imageURL,
      required this.time,
      this.isSelected = false,
      super.key,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      onTap: onTap,
      backgroundColor: Colors.white,
      borderRadiusValue: 12,
      child: Container(
          height: 85,
          decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(
                  color:
                      isSelected ? AppColors.primaryColor : Colors.transparent,
                  width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, top: 12, right: 12, bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox.square(
                      dimension: 60,
                      child: CachedNetworkImage(
                        imageUrl: imageURL.isNotEmpty
                            ? imageURL
                            : 'https://static.vecteezy.com/system/resources/previews/001/193/930/non_2x/vintage-car-png.png',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    // Image.asset(imageURL),
                    AppGaps.wGap12,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vehicleCategory,
                            style: AppTextStyles.bodyMediumTextStyle
                                .copyWith(color: AppColors.primaryTextColor)),
                        Text('$seat seats',
                            style: AppTextStyles.bodySmallTextStyle
                                .copyWith(color: AppColors.bodyTextColor)),
                        Row(
                          children: [
                            Image.asset(
                              AppAssetImages.locationGrey,
                              height: 20,
                              width: 10,
                            ),
                            AppGaps.wGap2,
                            Text('$distance($time away)',
                                style: AppTextStyles.bodySmallTextStyle
                                    .copyWith(
                                        color: AppColors.primaryTextColor)),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(amount.getCurrencyFormattedText(),
                        style: AppTextStyles.semiSmallXBoldTextStyle),
                    AppGaps.wGap5,
                    SvgPicture.asset(AppAssetImages.infoSVGLogoLine)
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
