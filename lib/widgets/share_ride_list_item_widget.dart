import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/* <---- Share ride list item widget ----> */

class ShareRideListItemWidget extends StatelessWidget {
  final String image;
  final String type;
  final int seats;
  final int available;
  final String pickupLocation;
  final String dropLocation;
  final String status;
  final bool showCallChat;
  final bool showPending;
  final DateTime time;
  final DateTime date;
  final int pending;
  final void Function()? onTap;
  final void Function()? onRequestButtonTap;
  final void Function()? onSendTap;
  const ShareRideListItemWidget(
      {super.key,
      this.onTap,
      this.onRequestButtonTap,
      this.onSendTap,
      required this.image,
      this.seats = 1,
      this.available = 1,
      this.type = 'passenger',
      required this.pickupLocation,
      required this.dropLocation,
      required this.status,
      this.showCallChat = false,
      this.showPending = false,
      required this.time,
      required this.date,
      this.pending = 0});

  @override
  Widget build(BuildContext context) {
    return CustomMessageListTileWidget(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.all(19),
            height: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Helper.hhmmFormattedTime(time),
                            style: AppTextStyles.titleSemiSmallSemiboldTextStyle
                                .copyWith(color: AppColors.primaryColor),
                          ),
                          AppGaps.hGap4,
                          Text(
                            Helper.ddMMMyyyyFormattedDateTime(date),
                            style: AppTextStyles.bodyTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          ),
                        ],
                      ),
                    ),
                    type != 'vehicle'
                        ? SizedBox(
                            height: 60,
                            width: 60,
                            child: CachedNetworkImageWidget(
                              imageURL: image,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .seatAvailableTranskey.toCurrentLanguage,
                                style: AppTextStyles.bodySmallTextStyle
                                    .copyWith(color: AppColors.bodyTextColor),
                              ),
                              AppGaps.hGap8,
                              Row(
                                children: List.generate(
                                    available < 1 || available > 10
                                        ? 1
                                        : available, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    child: Container(
                                      width: 19,
                                      height: 19,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD9D9D9),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                  ],
                ),
                if (showCallChat) AppGaps.hGap8,
                if (showCallChat)
                  Row(
                    children: [
                      RawButtonWidget(
                        borderRadiusValue: 12,
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              border:
                                  Border.all(color: AppColors.fromBorderColor)),
                          child: const Center(
                              child: SvgPictureAssetWidget(
                                  AppAssetImages.callingSVGLogoSolid)),
                        ),
                        onTap: () {},
                      ),
                      AppGaps.wGap8,
                      Expanded(
                          child: CustomMessageTextFormField(
                        onTap: onSendTap,
                        isReadOnly: true,
                        suffixIcon: const SvgPictureAssetWidget(
                            AppAssetImages.sendSVGLogoLine),
                        boxHeight: 55,
                        hintText: 'Type Message...',
                      ))
                    ],
                  ),
                AppGaps.hGap16,
                Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SvgPictureAssetWidget(
                        AppAssetImages.currentLocationSVGLogoLine,
                        height: 16,
                        width: 16,
                      ),
                      AppGaps.wGap8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLanguageTranslation
                                  .pickupLocationTransKey.toCurrentLanguage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySmallTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                            AppGaps.hGap4,
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    pickupLocation,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        AppTextStyles.bodyLargeMediumTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppGaps.hGap5,
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 1,
                        decoration:
                            const BoxDecoration(color: AppColors.dividerColor),
                      ))
                    ],
                  ),
                  AppGaps.hGap5,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SvgPictureAssetWidget(
                        AppAssetImages.dropLocationSVGLogoLine,
                        height: 16,
                        width: 16,
                      ),
                      AppGaps.wGap8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLanguageTranslation
                                  .dropLocationTransKey.toCurrentLanguage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySmallTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                            AppGaps.hGap4,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    dropLocation,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        AppTextStyles.bodyLargeMediumTextStyle,
                                  ),
                                ),
                                InkWell(
                                  onTap: showPending && pending > 0
                                      ? onRequestButtonTap
                                      : onRequestButtonTap,
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: showPending
                                                ? AppColors
                                                    .successBackgroundColor
                                                : const Color(0xFFEFF6FF),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Text(
                                          showPending
                                              ? '${AppLanguageTranslation.requestTransKey.toCurrentLanguage}${pending > 1 ? "s" : ""}'
                                              : status,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: showPending
                                                  ? AppColors.successColor
                                                  : const Color(0xFF3B82F6)),
                                        ),
                                      ),
                                      if (showPending && pending > 0)
                                        Positioned(
                                          right: 4,
                                          top: 1,
                                          child: Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                            child: Text(
                                              '$pending',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 6,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
              ],
            )));
  }
}
