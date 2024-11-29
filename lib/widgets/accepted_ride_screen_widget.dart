import 'dart:math';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/screen_widget/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

/* <---- Accept ride screen widget----> */

class AcceptedRideScreenWidget extends StatelessWidget {
  final String userName;
  final String gender;
  final bool isRideNow;

  final String userImage;
  final String carImage;
  final String distance;
  final String duration;
  final String pickupLocation;
  final String dropLocation;
  // final double amount;
  final double rating;
  final void Function()? onTap;
  final void Function()? chatTap;
  final void Function()? callTap;
  // final void Function()? onSendTap;
  final void Function()? onAcceptTap;
  final void Function()? onRejectTap;

  const AcceptedRideScreenWidget({
    super.key,
    required this.userName,
    required this.gender,
    required this.userImage,
    required this.carImage,
    required this.distance,
    required this.duration,
    required this.pickupLocation,
    required this.dropLocation,
    // required this.amount,
    required this.rating,
    this.onTap,
    // required this.onSendTap,
    this.isRideNow = false,
    this.onAcceptTap,
    this.onRejectTap,
    this.chatTap,
    this.callTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: CachedNetworkImageWidget(
                    imageURL: userImage,
                    imageBuilder: (context, imageProvider) => Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    ),
                  ),
                ),
                AppGaps.wGap10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyLargeSemiboldTextStyle
                                  .copyWith(color: AppColors.primaryTextColor),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        gender,
                        style: AppTextStyles.bodySmallTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      Row(
                        children: [
                          const SvgPictureAssetWidget(
                            AppAssetImages.yellowStar,
                            height: 8,
                            width: 8,
                            color: AppColors.warningColor,
                          ),
                          AppGaps.wGap6,
                          Expanded(
                            child: Text(
                              '${rating.toStringAsFixed(2)} (${Random().nextInt(901) + 100} reviews )',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySmallTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RawButtonWidget(
                            onTap: chatTap,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: Offset(2, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: RawButtonWidget(
                                onTap: chatTap,
                                child: SvgPicture.asset(
                                    AppAssetImages.mszLogoLine),
                              )),
                            ),
                          ),
                          AppGaps.wGap12,
                          RawButtonWidget(
                            onTap: callTap,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: Offset(2, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                    AppAssetImages.phonIconLogoLine),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            AppGaps.hGap12,
            Divider(
              color: AppColors.grayShadeColor,
              thickness: 1,
            ),
            AppGaps.hGap18,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: CachedNetworkImageWidget(
                    imageURL: carImage,
                    imageBuilder: (context, imageProvider) => Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    ),
                  ),
                ),
                AppGaps.wGap10,
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        'WAGONR',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMediumTextStyle
                            .copyWith(color: AppColors.primaryTextColor),
                      ),
                      AppGaps.hGap6,
                      Text(
                        '3 seats',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmallTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      AppGaps.hGap6,
                      Text(
                        'Tesla AS-852-XL',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmallTextStyle
                            .copyWith(color: AppColors.primaryTextColor),
                      ),
                    ])),
                Text(
                  '1.5 hour',
                  style: AppTextStyles.bodySmallTextStyle
                      .copyWith(color: AppColors.bodyTextColor),
                )
              ],
            ),
          ],
        ),
      ),
      AppGaps.hGap16,
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor.withOpacity(0.12),
              offset: (const Offset(0, 80)),
              spreadRadius: -12,
              blurRadius: 200,
            )
          ],
          borderRadius: BorderRadius.circular(12),
          color: AppColors.primaryButtonColor,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocationDetailsWidget(
                pickupLocation: pickupLocation,
                dropLocation: dropLocation,
                distance: distance),
            AppGaps.hGap10,
            Text('Payment method',
                style: AppTextStyles.bodySmallTextStyle
                    .copyWith(color: AppColors.bodyTextColor)),
            AppGaps.hGap8,
            Row(children: [
              SvgPicture.asset(
                width: 24,
                height: 24,
                AppAssetImages.grayWalletSVGLogoLine,
              ),
              AppGaps.wGap10,
              Text('Cash',
                  style: AppTextStyles.bodyMediumTextStyle
                      .copyWith(color: AppColors.primaryTextColor)),
            ]),
          ],
        ),
      ),

      // Container(
      //   padding: const EdgeInsets.all(12),
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(14), color: Colors.white),
      //   child: Column(
      //     children: [
      //       Row(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Image.asset(
      //             AppAssetImages.pickupMarkerPngIcon,
      //             height: 16,
      //             width: 16,
      //           ),
      //           AppGaps.wGap4,
      //           Expanded(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   AppLanguageTranslation
      //                       .pickupLocationTransKey.toCurrentLanguage,
      //                   style: AppTextStyles.bodySmallTextStyle
      //                       .copyWith(color: AppColors.bodyTextColor),
      //                 ),
      //                 AppGaps.hGap6,
      //                 Text(
      //                   pickLocation,
      //                   maxLines: 2,
      //                   overflow: TextOverflow.ellipsis,
      //                   style: AppTextStyles.bodyLargeMediumTextStyle,
      //                 )
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //       const Divider(),
      //       Row(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Image.asset(
      //             AppAssetImages.dropMarkerPngIcon,
      //             height: 16,
      //             width: 16,
      //           ),
      //           AppGaps.wGap6,
      //           Expanded(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   AppLanguageTranslation
      //                       .dropLocationTransKey.toCurrentLanguage,
      //                   style: AppTextStyles.bodySmallTextStyle
      //                       .copyWith(color: AppColors.bodyTextColor),
      //                 ),
      //                 AppGaps.hGap4,
      //                 Text(
      //                   dropLocation,
      //                   maxLines: 2,
      //                   overflow: TextOverflow.ellipsis,
      //                   style: AppTextStyles.bodyLargeMediumTextStyle,
      //                 )
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      // Row(
      //   children: [
      //     Expanded(
      //         child: Container(
      //       height: 1,
      //       color: AppColors.fromBorderColor,
      //     )),
      //   ],
      // ),
      AppGaps.hGap9,
      Row(
        children: [
          SvgPicture.asset(
            width: 24,
            height: 24,
            AppAssetImages.shareRideStatusSVGLogoLine,
          ),
          AppGaps.wGap12,
          Text(
            'Share Trip Status',
            style: AppTextStyles.bodyMediumTextStyle
                .copyWith(color: AppColors.primaryTextColor),
          )
        ],
      ),
      AppGaps.hGap16,
    ]);
  }
}
