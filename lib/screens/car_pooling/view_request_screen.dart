import 'package:car2gouser/controller/view_requests_screen_controller.dart';
import 'package:car2gouser/models/api_responses/carpolling/pulling_offer_details_response.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewRequestsScreen extends StatelessWidget {
  const ViewRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewRequestsScreenController>(
        init: ViewRequestsScreenController(),
        builder: (controller) => WillPopScope(
            onWillPop: () async {
              controller.popScope();
              return await Future.value(true);
            },
            child: CustomScaffold(
              /*<------- AppBar ------>*/

              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText:
                      AppLanguageTranslation.requestTransKey.toCurrentLanguage),
              body: RefreshIndicator(
                /*<------- Show loading ------>*/

                onRefresh: () async {
                  controller.getRequestDetails();
                  controller.update();
                },
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(24),
                      sliver: SliverList.separated(
                        itemBuilder: (context, index) {
                          PullingOfferDetailsRequest request =
                              controller.requestDetails.pending[index];
                          return Container(
                            height: controller.requestDetails.type == 'vehicle'
                                ? 315
                                : 275,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: AppColors.fromBorderColor),
                                borderRadius: BorderRadius.circular(14)),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 45,
                                      width: 45,
                                      child: CachedNetworkImageWidget(
                                        imageURL: request.user.image,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: AppComponents
                                                  .imageBorderRadius,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                    AppGaps.wGap8,
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  request.user.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .bodyLargeSemiboldTextStyle,
                                                ),
                                              ),
                                              if (controller
                                                      .requestDetails.type ==
                                                  "vehicle")
                                                AppGaps.wGap5,
                                              if (request.seats > 1 &&
                                                  controller.requestDetails
                                                          .type ==
                                                      "vehicle")
                                                const Text(
                                                  '+',
                                                  style: AppTextStyles
                                                      .bodyLargeSemiboldTextStyle,
                                                ),
                                              if (controller
                                                      .requestDetails.type ==
                                                  "vehicle")
                                                Expanded(
                                                  child: Row(
                                                    children: List.generate(
                                                        request.seats > 2
                                                            ? 3
                                                            : request.seats - 1,
                                                        (index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 1),
                                                        child: Container(
                                                          width:
                                                              19, // Adjust the size of the dot as needed
                                                          height: 19,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Color(
                                                                0xFFD9D9D9),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const SingleStarWidget(review: 3),
                                              AppGaps.wGap4,
                                              Text(
                                                '(531 ${controller.requestDetails.type == "vehicle" ? "Trips" : "Rides"})',
                                                style: AppTextStyles
                                                    .bodySmallTextStyle,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${Helper.getCurrencyFormattedWithDecimalAmountText(request.rate)} ',
                                              style: AppTextStyles
                                                  .bodySmallSemiboldTextStyle,
                                            ),
                                            Text(
                                              ' / ${AppLanguageTranslation.perSeatTranskey.toCurrentLanguage}',
                                              style: AppTextStyles
                                                  .bodySmallSemiboldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            ),
                                          ],
                                        ),
                                        AppGaps.hGap6,
                                        Row(
                                          children: [
                                            const SvgPictureAssetWidget(
                                              AppAssetImages.seat,
                                              height: 10,
                                              width: 10,
                                            ),
                                            Text(
                                              ' ${request.seats}  seat${request.seats > 1 ? "s" : ""} ${controller.requestDetails.type == "vehicle" ? 'Needed' : 'Available'}',
                                              style: AppTextStyles
                                                  .smallestSemiboldTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                AppGaps.hGap12,
                                if (controller.requestDetails.type == 'vehicle')
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLanguageTranslation
                                            .startDateTimeTranskey
                                            .toCurrentLanguage,
                                        style: AppTextStyles.bodyLargeTextStyle
                                            .copyWith(
                                                color: AppColors.bodyTextColor),
                                      ),
                                      Text(
                                        Helper.ddMMMyyyyhhmmaFormattedDateTime(
                                            controller.requestDetails.date),
                                        style: AppTextStyles
                                            .bodyLargeMediumTextStyle
                                            .copyWith(
                                                color:
                                                    AppColors.primaryTextColor),
                                      )
                                    ],
                                  ),
                                if (controller.requestDetails.type == 'vehicle')
                                  AppGaps.hGap12,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLanguageTranslation
                                                .pickupLocationTransKey
                                                .toCurrentLanguage,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodySmallTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .bodyTextColor),
                                          ),
                                          AppGaps.hGap4,
                                          Text(
                                            controller
                                                .requestDetails.from.address,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodyLargeMediumTextStyle,
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
                                      color: AppColors.dividerColor,
                                    )),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLanguageTranslation
                                                .dropLocationTransKey
                                                .toCurrentLanguage,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodySmallTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .bodyTextColor),
                                          ),
                                          AppGaps.hGap4,
                                          Text(
                                            controller
                                                .requestDetails.to.address,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodyLargeMediumTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                AppGaps.hGap25,
                                Row(
                                  children: [
                                    Expanded(
                                        child:
                                            CustomStretchedOutlinedButtonWidget(
                                                onTap: () => controller
                                                    .onRejectButtonTap(
                                                        request.id),
                                                child: Text(
                                                    AppLanguageTranslation
                                                        .rejectTransKey
                                                        .toCurrentLanguage,
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .primaryColor)))),
                                    AppGaps.wGap50,
                                    Expanded(
                                        child: StretchedTextButtonWidget(
                                            onTap: () => controller
                                                .onAcceptButtonTap(request.id),
                                            buttonText: AppLanguageTranslation
                                                .acceptTransKey
                                                .toCurrentLanguage))
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => AppGaps.hGap16,
                        itemCount: controller.pendingRequests.length,
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
