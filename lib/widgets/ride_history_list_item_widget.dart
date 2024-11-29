import 'dart:math';

import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/*<-------Ride History item widget  ------>*/
class RideHistoryListItemWidget extends StatelessWidget {
  final String driverImage;
  final String carModel;
  final String currency;
  final String distance;
  final double rate;
  final String driverName;
  final String carName;
  final String pickupLocation;
  final String dropLocation;
  final bool showCallChat;
  final DateTime time;
  final DateTime date;
  final bool isDateChanged;

  final void Function()? onTap;
  final void Function()? onSendTap;

  const RideHistoryListItemWidget({
    Key? key,
    this.onTap,
    this.onSendTap,
    required this.driverImage,
    required this.pickupLocation,
    required this.dropLocation,
    this.showCallChat = false,
    required this.time,
    required this.date,
    required this.driverName,
    required this.isDateChanged,
    required this.carModel,
    required this.carName,
    required this.currency,
    required this.rate,
    required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDateChanged) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              dayText,
              style: AppTextStyles.titlesemiSmallMediumTextStyle
                  .copyWith(color: AppColors.primaryTextColor),
            ),
          ),
          AppGaps.hGap12,
          _RideHistoryListWidget(
              distance: distance,
              currency: currency,
              rate: rate,
              carName: carName,
              carModel: carModel,
              driverName: driverName,
              showCallChat: showCallChat,
              onSendTap: onSendTap,
              pickupLocation: pickupLocation,
              dropLocation: dropLocation,
              date: date,
              driverImage: driverImage,
              time: time,
              isDateChanged: isDateChanged,
              onTap: onTap),
        ],
      );
    }
    return _RideHistoryListWidget(
        distance: distance,
        currency: currency,
        rate: rate,
        carName: carName,
        carModel: carModel,
        driverName: driverName,
        showCallChat: showCallChat,
        onSendTap: onSendTap,
        pickupLocation: pickupLocation,
        dropLocation: dropLocation,
        date: date,
        driverImage: driverImage,
        time: time,
        isDateChanged: isDateChanged,
        onTap: onTap);
  }

  String get dayText {
    if (Helper.isToday(date)) {
      return AppLanguageTranslation.todayTransKey.toCurrentLanguage;
    }
    if (Helper.wasYesterday(date)) {
      return AppLanguageTranslation.yesterdayTransKey.toCurrentLanguage;
    }
    if (Helper.isTomorrow(date)) {
      return AppLanguageTranslation.tomorrowTransKey.toCurrentLanguage;
    }
    return Helper.ddMMMyyyyFormattedDateTime(date);
  }
}

class _RideHistoryListWidget extends StatelessWidget {
  final String driverImage;
  final String driverName;
  final String carModel;
  final String carName;
  final String distance;
  final double rate;
  final String currency;
  final String pickupLocation;
  final String dropLocation;
  final bool showCallChat;
  final DateTime time;
  final DateTime date;
  final bool isDateChanged;

  final void Function()? onTap;
  final void Function()? onSendTap;
  const _RideHistoryListWidget({
    this.onTap,
    this.onSendTap,
    required this.driverImage,
    required this.pickupLocation,
    required this.dropLocation,
    this.showCallChat = false,
    required this.time,
    required this.date,
    required this.driverName,
    required this.isDateChanged,
    required this.carModel,
    required this.carName,
    required this.rate,
    required this.currency,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return CustomMessageListTileWidget(
        onTap: onTap,
        child: SizedBox(
            height: showCallChat ? 280 : 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: CachedNetworkImageWidget(
                        imageURL: driverImage,
                        imageBuilder: (context, imageProvider) => Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill)),
                        ),
                      ),
                    ),
                    AppGaps.wGap12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            driverName,
                            style: AppTextStyles.bodySemiboldTextStyle
                                .copyWith(color: AppColors.primaryColor),
                          ),
                          AppGaps.hGap4,
                          Text(
                            '★ ${(Random().nextDouble() * (5 - 4) + 4).toStringAsFixed(2)} (${(Random().nextInt(90) + 100)} Rides)',
                            style: AppTextStyles.smallestTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          ),
                          AppGaps.hGap4,
                          Row(
                            children: [
                              Text(
                                carName,
                                style: AppTextStyles.bodySmallMediumTextStyle
                                    .copyWith(color: AppColors.bodyTextColor),
                              ),
                              Expanded(
                                child: Text(
                                  ' ($carModel)',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.bodySmallMediumTextStyle
                                      .copyWith(color: AppColors.primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                currency,
                                style: AppTextStyles.bodyLargeBoldTextStyle
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                              Text(
                                rate.toStringAsFixed(2),
                                style: AppTextStyles.bodyLargeBoldTextStyle
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                          AppGaps.hGap4,
                          Text(
                            Helper.hhmmFormattedDateTime(time),
                            style: AppTextStyles.bodyTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          ),
                        ],
                      ),
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
                          child: const Center(child: Icon(Icons.call)),
                        ),
                        onTap: () {},
                      ),
                      AppGaps.wGap8,
                      Expanded(
                          child: CustomMessageTextFormField(
                        onTap: onSendTap,
                        isReadOnly: true,
                        suffixIcon: const Icon(Icons.send),
                        boxHeight: 55,
                        hintText: 'Type your message..',
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
                        color: AppColors.bodyTextColor,
                      ),
                      AppGaps.wGap4,
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
                            AppGaps.hGap6,
                            Text(
                              pickupLocation,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyLargeMediumTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppGaps.hGap14,
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.fromBorderColor,
                        ),
                      ),
                      Container(
                        width: 65,
                        height: 28,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF919BB3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: Center(
                            child: Text(
                          distance,
                          style: AppTextStyles.bodySmallMediumTextStyle
                              .copyWith(color: Colors.white),
                        )),
                      ),
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
                        color: AppColors.bodyTextColor,
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
                  )
                ]),
              ],
            )));
  }
}
