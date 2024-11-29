// import 'package:car2gouser/utils/constants/app_colors.dart';
// import 'package:car2gouser/utils/constants/app_gaps.dart';
// import 'package:car2gouser/utils/constants/app_images.dart';
// import 'package:car2gouser/utils/constants/app_language_translations.dart';
// import 'package:car2gouser/utils/constants/app_text_styles.dart';
// import 'package:car2gouser/utils/extensions/string.dart';
// import 'package:car2gouser/widgets/core_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class CustomCardWidget extends StatelessWidget {
//   const CustomCardWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             height: 78,
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.fromBorderColor),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 32,
//                     width: 48,
//                     decoration: BoxDecoration(
//                         border: Border.all(color: AppColors.fromBorderColor)),
//                     child: Image.asset(AppAssetImages.moneyIconImage),
//                   ),
//                   AppGaps.wGap16,
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Liton Nandi',
//                         style: AppTextStyles.bodyLargeSemiboldTextStyle
//                             .copyWith(color: AppColors.primaryColor),
//                       ),
//                       Text(
//                         '**88888888888888',
//                         style: AppTextStyles.bodySmallTextStyle
//                             .copyWith(color: AppColors.bodyTextColor),
//                       ),
//                     ],
//                   ),
//                   SvgPicture.asset(AppAssetImages.trashIconSVGLogoLine)
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
