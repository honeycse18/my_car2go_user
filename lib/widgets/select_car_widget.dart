import 'package:cached_network_image/cached_network_image.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/*<------- Select vehicle widget  ------>*/
// class SelectCarWidget extends StatelessWidget {
//   final String transportName;
//   final String amount;
//   final String symbol;
//   final int seat;
//   final String carImage;
//   final String vehicleCategory;
//   final String color;
//   final String distanceInTime;
//   final void Function() onTap;
//   final bool isSelected;

//   const SelectCarWidget({
//     super.key,
//     required this.vehicleCategory,
//     required this.amount,
//     required this.symbol,
//     required this.seat,
//     required this.carImage,
//     required this.transportName,
//     required this.color,
//     required this.distanceInTime,
//     required this.onTap,
//     this.isSelected = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//          height: 84,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding:
//               const EdgeInsets.only(left: 8.0, top: 12, right: 12, bottom: 12),

//         child: Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               height: 80,
//               width: 80,
//               decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(12))),
//               child: Center(
//                   child: CachedNetworkImage(
//                       imageUrl: carImage.isNotEmpty
//                           ? carImage
//                           : 'https://static.vecteezy.com/system/resources/previews/001/193/930/non_2x/vintage-car-png.png')),
//             ),
//             AppGaps.wGap8,
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   /*<-------Transport name  ------>*/
//                   Expanded(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             transportName,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: AppTextStyles.bodyLargeSemiboldTextStyle,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Text(symbol),
//                             Text(amount),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       '$vehicleCategory  |  $seat ${AppLanguageTranslation.seatTransKey.toCurrentLanguage}  |  $color',
//                       style: AppTextStyles.bodyTextStyle
//                           .copyWith(color: AppColors.bodyTextColor),
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       distanceInTime.isNotEmpty
//                           ? "$distanceInTime ${AppLanguageTranslation.awayTransKey.toCurrentLanguage}"
//                           : AppLanguageTranslation
//                               .carIsHereTransKey.toCurrentLanguage,
//                       style: AppTextStyles.bodyMediumTextStyle
//                           .copyWith(color: AppColors.secondaryTextColor),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),),
//     );
//   }
// }

class SelectCarCategoryPagesWidget extends StatelessWidget {
  final String transportName;

  final String image;
  final int seat;
  final double realPrice;
  final double discountPrice;
  final void Function()? onTap;
  final bool isSelected;

  const SelectCarCategoryPagesWidget({
    super.key,
    required this.transportName,
    required this.image,
    required this.seat,
    required this.realPrice,
    required this.discountPrice,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
      paddingValue: EdgeInsets.zero,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        // height: 100,
        decoration: BoxDecoration(
            color: AppColors.primaryButtonColor,
            border: Border.all(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: CachedNetworkImage(
                  imageUrl: image.isNotEmpty
                      ? image
                      : 'https://static.vecteezy.com/system/resources/previews/001/193/930/non_2x/vintage-car-png.png',
                  imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(12)),
                      )),
            ),
            AppGaps.wGap8,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transportName,
                    style: AppTextStyles.bodyLargeSemiboldTextStyle,
                  ),
                  AppGaps.hGap2,
                  Text('$seat seats',
                      style: AppTextStyles.bodySmallTextStyle
                          .copyWith(color: AppColors.bodyTextColor)),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "\$${realPrice.toStringAsFixed(2)}",
                  style: AppTextStyles.smallestMediumTextStyle.copyWith(
                    color: AppColors.errorColor,
                    decoration: discountPrice < realPrice
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                if (discountPrice < realPrice) AppGaps.wGap7,
                if (discountPrice < realPrice)
                  Text(
                    "\$${discountPrice.toStringAsFixed(2)}",
                    style: AppTextStyles.notificationDateSection
                        .copyWith(color: AppColors.primaryTextColor),
                  ),
                AppGaps.wGap5,
                SvgPicture.asset(AppAssetImages.infoSVGLogoLine)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
