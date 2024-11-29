import 'package:car2gouser/controller/pooling_offer_details_screen_controller.dart';
import 'package:car2gouser/models/api_responses/carpolling/pulling_offer_details_response.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PullingOfferDetailsScreen extends StatelessWidget {
  const PullingOfferDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PullingOfferDetailsScreenController>(
        init: PullingOfferDetailsScreenController(),
        global: false,
        builder: ((controller) => WillPopScope(
            onWillPop: () async {
              controller.popScope();
              return await Future.value(true);
            },
            child: CustomScaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              /* <--------AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText:
                      AppLanguageTranslation.detailsTranskey.toCurrentLanguage),
              /* <-------- Body Content --------> */
              body: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Stack(
                  children: [
                    Positioned.fill(
                      bottom: MediaQuery.of(context).size.height * 0.32,
                      /* <-------- initialize google map --------> */
                      child: GoogleMap(
                        mapType: MapType.normal,
                        mapToolbarEnabled: false,
                        zoomControlsEnabled: false,
                        myLocationEnabled: false,
                        compassEnabled: true,
                        zoomGesturesEnabled: true,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                (controller.cameraPosition.latitude) - 7.7,
                                controller.cameraPosition.longitude),
                            zoom: controller.zoomLevel),
                        markers: controller.googleMapMarkers,
                        polylines: controller.googleMapPolyLines,
                        onMapCreated: controller.onGoogleMapCreated,
                      ),
                    ),
                    SlidingUpPanel(
                        color: Colors.transparent,
                        boxShadow: null,
                        minHeight: 372,
                        maxHeight: 610,
                        panel: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 73.0),
                              child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                  color: AppColors.backgroundColor,
                                ),
                                child: Column(children: [
                                  AppGaps.hGap10,
                                  Container(
                                    width: 60,
                                    decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 3,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: Color(0xFFA5A5A5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: ScaffoldBodyWidget(
                                        child: CustomScrollView(
                                      slivers: [
                                        const SliverToBoxAdapter(
                                          child: AppGaps.hGap10,
                                        ),
                                        SliverToBoxAdapter(
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            height: 180,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14))),
                                            child: Column(children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        AppLanguageTranslation
                                                            .startDateTimeTranskey
                                                            .toCurrentLanguage,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppTextStyles
                                                            .bodyMediumTextStyle
                                                            .copyWith(
                                                          color: AppColors
                                                              .bodyTextColor,
                                                        )),
                                                  ),
                                                  Text(
                                                      Helper
                                                          .ddMMMyyyyhhmmaFormattedDateTime(
                                                              controller
                                                                  .offerDetails
                                                                  .date),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTextStyles
                                                          .bodyMediumTextStyle),
                                                ],
                                              ),
                                              AppGaps.hGap12,
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SvgPictureAssetWidget(
                                                    AppAssetImages
                                                        .currentLocationSVGLogoLine,
                                                    height: 16,
                                                    width: 16,
                                                  ),
                                                  AppGaps.wGap4,
                                                  /* <-------- select pickup location from google map --------> */
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          AppLanguageTranslation
                                                              .pickupLocationTransKey
                                                              .toCurrentLanguage,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTextStyles
                                                              .bodySmallTextStyle
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .bodyTextColor),
                                                        ),
                                                        AppGaps.hGap4,
                                                        Text(
                                                          controller
                                                              .offerDetails
                                                              .from
                                                              .address,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTextStyles
                                                              .bodyLargeMediumTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              AppGaps.hGap12,
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Container(
                                                    height: 1,
                                                    color: AppColors
                                                        .fromBorderColor,
                                                  ))
                                                ],
                                              ),
                                              AppGaps.hGap12,
                                              /* <-------- select drop location from google map --------> */
                                              Expanded(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const SvgPictureAssetWidget(
                                                      AppAssetImages
                                                          .dropLocationSVGLogoLine,
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                    AppGaps.wGap4,
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            AppLanguageTranslation
                                                                .dropLocationTransKey
                                                                .toCurrentLanguage,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: AppTextStyles
                                                                .bodySmallTextStyle
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .bodyTextColor),
                                                          ),
                                                          AppGaps.hGap4,
                                                          Expanded(
                                                            child: Text(
                                                              controller
                                                                  .offerDetails
                                                                  .to
                                                                  .address,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: AppTextStyles
                                                                  .bodyLargeMediumTextStyle,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                        const SliverToBoxAdapter(
                                          child: AppGaps.hGap24,
                                        ),
                                        SliverToBoxAdapter(
                                          child: Text(
                                            controller.offerDetails.type ==
                                                    'passenger'
                                                ? 'Passenger'
                                                : 'Driver',
                                            style: AppTextStyles
                                                .notificationDateSection,
                                          ),
                                        ),
                                        const SliverToBoxAdapter(
                                          child: AppGaps.hGap12,
                                        ),
                                        SliverToBoxAdapter(
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
                                            height: 90,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14))),
                                            child: Row(children: [
                                              SizedBox(
                                                height: 45,
                                                width: 45,
                                                child: CachedNetworkImageWidget(
                                                  imageURL: controller
                                                      .offerDetails.user.image,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ),
                                              AppGaps.wGap10,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        controller.offerDetails
                                                            .user.name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppTextStyles
                                                            .bodyLargeSemiboldTextStyle,
                                                      ),
                                                    ),
                                                    AppGaps.hGap5,
                                                    const Row(
                                                      children: [
                                                        SingleStarWidget(
                                                            review: 4.9),
                                                        AppGaps.wGap4,
                                                        Text(
                                                          '(831 reviews)',
                                                          style: AppTextStyles
                                                              .smallestMediumTextStyle,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            Helper.getCurrencyFormattedWithDecimalAmountText(
                                                                controller
                                                                    .offerDetails
                                                                    .rate
                                                                    .toDouble()),
                                                            style: AppTextStyles
                                                                .bodySemiboldTextStyle,
                                                          ),
                                                          AppGaps.wGap4,
                                                          Text(
                                                            AppLanguageTranslation
                                                                .perSeatTranskey
                                                                .toCurrentLanguage,
                                                            style: AppTextStyles
                                                                .bodySmallSemiboldTextStyle
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .bodyTextColor),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    AppGaps.hGap4,
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          const SvgPictureAssetWidget(
                                                              AppAssetImages
                                                                  .seat),
                                                          AppGaps.wGap5,
                                                          Text(
                                                            '${controller.offerDetails.type == 'passenger' ? controller.offerDetails.seats : controller.offerDetails.available}',
                                                            style: AppTextStyles
                                                                .bodySmallSemiboldTextStyle,
                                                          ),
                                                          AppGaps.wGap5,
                                                          Expanded(
                                                            child: Text(
                                                              controller.offerDetails
                                                                          .type ==
                                                                      'vehicle'
                                                                  ? 'Seat Available'
                                                                  : 'Seat Need',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: AppTextStyles
                                                                  .bodySmallSemiboldTextStyle
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .bodyTextColor),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),

                                        const SliverToBoxAdapter(
                                          child: AppGaps.hGap16,
                                        ),
                                        // if (controller.requestDetails.type ==
                                        //     'vehicle')
                                        SliverToBoxAdapter(
                                          child: Text(
                                            controller.offerDetails.type ==
                                                    'passenger'
                                                ? 'Driver'
                                                : 'Passenger',
                                            style: AppTextStyles
                                                .notificationDateSection,
                                          ),
                                        ),
                                        const SliverToBoxAdapter(
                                          child: AppGaps.hGap8,
                                        ),
                                        // if (controller.requestDetails.type ==
                                        //     'vehicle')
                                        controller.offerDetails.requests
                                                .isNotEmpty
                                            ? SliverList.separated(
                                                separatorBuilder:
                                                    (context, index) =>
                                                        AppGaps.hGap10,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  PullingOfferDetailsRequest
                                                      request = controller
                                                          .requests[index];
                                                  return Container(
                                                    height: 260,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14)),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 45,
                                                              width: 45,
                                                              child:
                                                                  CachedNetworkImageWidget(
                                                                imageURL:
                                                                    request.user
                                                                        .image,
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          AppComponents
                                                                              .imageBorderRadius,
                                                                      image: DecorationImage(
                                                                          image:
                                                                              imageProvider,
                                                                          fit: BoxFit
                                                                              .cover)),
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
                                                                        child:
                                                                            Text(
                                                                          request
                                                                              .user
                                                                              .name,
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              AppTextStyles.bodyLargeSemiboldTextStyle,
                                                                        ),
                                                                      ),
                                                                      if (controller
                                                                              .offerDetails
                                                                              .type ==
                                                                          "vehicle")
                                                                        AppGaps
                                                                            .wGap5,
                                                                      if (request.seats >
                                                                              1 &&
                                                                          controller.offerDetails.type ==
                                                                              "vehicle")
                                                                        const Text(
                                                                          '+',
                                                                          style:
                                                                              AppTextStyles.bodyLargeSemiboldTextStyle,
                                                                        ),
                                                                      if (controller
                                                                              .offerDetails
                                                                              .type ==
                                                                          "vehicle")
                                                                        Expanded(
                                                                          child:
                                                                              Row(
                                                                            children:
                                                                                List.generate(request.seats > 2 ? 3 : request.seats - 1, (index) {
                                                                              return Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 1),
                                                                                child: Container(
                                                                                  width: 19, // Adjust the size of the dot as needed
                                                                                  height: 19,
                                                                                  decoration: const BoxDecoration(
                                                                                    color: Color(0xFFD9D9D9),
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }),
                                                                          ),
                                                                        )
                                                                    ],
                                                                  ),
                                                                  const Row(
                                                                    children: [
                                                                      SingleStarWidget(
                                                                          review:
                                                                              3),
                                                                      AppGaps
                                                                          .wGap4,
                                                                      Text(
                                                                        '(531 Rides)',
                                                                        style: AppTextStyles
                                                                            .bodySmallTextStyle,
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            if (controller
                                                                    .offerDetails
                                                                    .type ==
                                                                'vehicle')
                                                              Obx(() => controller
                                                                      .pickUpPassengers
                                                                      .value
                                                                  ? InkWell(
                                                                      onTap: () =>
                                                                          controller
                                                                              .onPickupButtonTap(request),
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                7,
                                                                            horizontal:
                                                                                16),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(8),
                                                                            color: request.status == 'accepted'
                                                                                ? AppColors.primaryColor
                                                                                : request.status == 'started'
                                                                                    ? AppColors.primaryTextColor
                                                                                    : request.status == 'completed'
                                                                                        ? AppColors.bodyTextColor
                                                                                        : AppColors.errorColor),
                                                                        child:
                                                                            Text(
                                                                          request.status == 'accepted'
                                                                              ? 'Pick Up'
                                                                              : request.status == 'started'
                                                                                  ? 'Drop'
                                                                                  : request.status == 'completed'
                                                                                      ? AppLanguageTranslation.completedTransKey.toCurrentLanguage
                                                                                      : 'Unknown',
                                                                          style: AppTextStyles
                                                                              .bodySemiboldTextStyle
                                                                              .copyWith(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              '${Helper.getCurrencyFormattedWithDecimalAmountText(request.rate)} ',
                                                                              style: AppTextStyles.bodySmallSemiboldTextStyle,
                                                                            ),
                                                                            Text(
                                                                              ' / ${AppLanguageTranslation.perSeatTranskey.toCurrentLanguage}}',
                                                                              style: AppTextStyles.bodySmallSemiboldTextStyle.copyWith(color: AppColors.bodyTextColor),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        AppGaps
                                                                            .hGap6,
                                                                        Row(
                                                                          children: [
                                                                            const SvgPictureAssetWidget(
                                                                              AppAssetImages.seat,
                                                                              height: 10,
                                                                              width: 10,
                                                                            ),
                                                                            Text(
                                                                              ' ${request.seats}  seat${request.seats > 1 ? "s" : ""}',
                                                                              style: AppTextStyles.smallestSemiboldTextStyle.copyWith(color: AppColors.bodyTextColor),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    )),
                                                          ],
                                                        ),
                                                        AppGaps.hGap10,
                                                        Row(
                                                          children: [
                                                            RawButtonWidget(
                                                              child: Container(
                                                                height: 40,
                                                                width: 40,
                                                                decoration: const BoxDecoration(
                                                                    color: AppColors
                                                                        .fromBorderColor,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(12))),
                                                                child:
                                                                    const Center(
                                                                  child: SvgPictureAssetWidget(
                                                                      AppAssetImages
                                                                          .callingSVGLogoSolid),
                                                                ),
                                                              ),
                                                              onTap: () {},
                                                            ),
                                                            AppGaps.wGap12,
                                                            Expanded(
                                                                child:
                                                                    Custom2MessageTextFormField(
                                                              onTap: () {
                                                                Get.toNamed(
                                                                    AppPageNames
                                                                        .chatScreen,
                                                                    arguments:
                                                                        request
                                                                            .user
                                                                            .id);
                                                              },
                                                              isReadOnly: true,
                                                              suffixIcon: const SvgPictureAssetWidget(
                                                                  AppAssetImages
                                                                      .sendSVGLogoLine),
                                                              boxHeight: 44,
                                                              hintText:
                                                                  'Type Message...',
                                                            ))
                                                          ],
                                                        ),
                                                        if (controller
                                                                .offerDetails
                                                                .type ==
                                                            'vehicle')
                                                          AppGaps.hGap12,
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const SvgPictureAssetWidget(
                                                              AppAssetImages
                                                                  .currentLocationSVGLogoLine,
                                                              height: 16,
                                                              width: 16,
                                                            ),
                                                            AppGaps.wGap8,
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    AppLanguageTranslation
                                                                        .pickupLocationTransKey
                                                                        .toCurrentLanguage,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: AppTextStyles
                                                                        .bodySmallTextStyle
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.bodyTextColor),
                                                                  ),
                                                                  AppGaps.hGap4,
                                                                  Text(
                                                                    controller
                                                                        .offerDetails
                                                                        .from
                                                                        .address,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
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
                                                                child:
                                                                    Container(
                                                              height: 1,
                                                              decoration: const BoxDecoration(
                                                                  color: AppColors
                                                                      .fromBorderColor),
                                                            ))
                                                          ],
                                                        ),
                                                        AppGaps.hGap5,
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const SvgPictureAssetWidget(
                                                              AppAssetImages
                                                                  .dropLocationSVGLogoLine,
                                                              height: 16,
                                                              width: 16,
                                                            ),
                                                            AppGaps.wGap8,
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    AppLanguageTranslation
                                                                        .dropLocationTransKey
                                                                        .toCurrentLanguage,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: AppTextStyles
                                                                        .bodySmallTextStyle
                                                                        .copyWith(
                                                                            color:
                                                                                AppColors.bodyTextColor),
                                                                  ),
                                                                  AppGaps.hGap4,
                                                                  Text(
                                                                    controller
                                                                        .offerDetails
                                                                        .to
                                                                        .address,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: AppTextStyles
                                                                        .bodyLargeMediumTextStyle,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                itemCount:
                                                    controller.requests.length,

                                                /* gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          childAspectRatio: 1,
                                                          crossAxisSpacing: 10,
                                                          mainAxisExtent: 70,
                                                          mainAxisSpacing: 10), */
                                              )
                                            : SliverToBoxAdapter(
                                                child: Center(
                                                child: Text(
                                                  controller.offerDetails
                                                              .type ==
                                                          'passenger'
                                                      ? 'Have No Driver Yet'
                                                      : 'Have No passengers Yet',
                                                  style: AppTextStyles
                                                      .notificationDateSection
                                                      .copyWith(
                                                          color: AppColors
                                                              .bodyTextColor),
                                                ),
                                              )),
                                        const SliverToBoxAdapter(
                                          child: AppGaps.hGap16,
                                        ),
                                        if (controller.offerDetails.type ==
                                            'passenger')
                                          if (controller.offerDetails.category
                                              .id.isNotEmpty)
                                            SliverToBoxAdapter(
                                              child: Text(
                                                AppLanguageTranslation
                                                    .vehicleInformationTransKey
                                                    .toCurrentLanguage,
                                                style: AppTextStyles
                                                    .notificationDateSection,
                                              ),
                                            ),
                                        if (controller.offerDetails.type ==
                                            'passenger')
                                          if (controller.offerDetails.category
                                              .id.isNotEmpty)
                                            const SliverToBoxAdapter(
                                              child: AppGaps.hGap8,
                                            ),
                                        if (controller.offerDetails.type ==
                                            'passenger')
                                          if (controller.offerDetails.category
                                              .id.isNotEmpty)
                                            SliverToBoxAdapter(
                                                child: Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  height: 100,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          18))),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 80,
                                                        width: 80,
                                                        child:
                                                            CachedNetworkImageWidget(
                                                          imageURL: controller
                                                                  .offerDetails
                                                                  .requests
                                                                  .firstOrNull
                                                                  ?.category
                                                                  .image ??
                                                              '',
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            16)),
                                                                image: DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .cover)),
                                                          ),
                                                        ),
                                                      ),
                                                      AppGaps.wGap10,
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            controller
                                                                    .offerDetails
                                                                    .requests
                                                                    .firstOrNull
                                                                    ?.category
                                                                    .name ??
                                                                '',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: AppTextStyles
                                                                .bodyLargeSemiboldTextStyle,
                                                          ),
                                                          Text(
                                                            controller
                                                                    .offerDetails
                                                                    .requests
                                                                    .firstOrNull
                                                                    ?.vehicleNumber ??
                                                                '',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: AppTextStyles
                                                                .bodyTextStyle
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .bodyTextColor),
                                                          ),
                                                        ],
                                                      ))
                                                    ],
                                                  ),
                                                ))
                                              ],
                                            )),
                                        const SliverToBoxAdapter(
                                          child: AppGaps.hGap100,
                                        ),
                                      ],
                                    )),
                                  ))
                                ]),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  backgroundColor: AppColors.backgroundColor,
                  child: Obx(() => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomStretchedButtonWidget(
                            onTap: controller.offerDetails.type == 'passenger'
                                ? controller.offerDetails.status == 'completed'
                                    ? null
                                    : controller.offerDetails.requests
                                                .firstOrNull?.payment.status ==
                                            'paid'
                                        ? controller.offerDetails.requests
                                                    .firstOrNull?.status ==
                                                'completed'
                                            ? null
                                            : () => controller.dropPassenger(
                                                controller.offerDetails.requests
                                                        .firstOrNull ??
                                                    PullingOfferDetailsRequest
                                                        .empty())
                                        : controller.offerDetails.requests
                                                    .firstOrNull?.status ==
                                                'accepted'
                                            ? controller.onStartTripTap
                                            : controller.onMakePaymentTap
                                : controller.offerDetails.status == 'completed'
                                    ? null
                                    : controller.pickUpPassengers.value
                                        ? controller.onCompleteRideButtonTap
                                        : controller.onStartRideButtonTap,
                            /* controller.offerDetails.status == 'completed'
                                  ? null
                                  : controller.pickUpPassengers.value
                                      ? controller.onCompleteRideButtonTap
                                      : controller.offerDetails.type ==
                                              'passenger'
                                          ? () => controller.onPickupButtonTap(
                                              controller.offerDetails.requests[0])
                                          : controller.onStartRideButtonTap */
                            child: Text(controller.offerDetails.type ==
                                    'passenger'
                                ? controller.offerDetails.status == 'completed'
                                    ? 'Trip is Completed'
                                    : controller.offerDetails.requests
                                                .firstOrNull?.payment.status ==
                                            'paid'
                                        ? controller.offerDetails.requests
                                                    .firstOrNull?.status ==
                                                'completed'
                                            ? 'Trip is Completed'
                                            : 'Complete the trip'
                                        : controller.offerDetails.requests
                                                    .firstOrNull?.status ==
                                                'accepted'
                                            ? 'Start Trip'
                                            : AppLanguageTranslation
                                                .makePaymentTransKey
                                                .toCurrentLanguage
                                : controller.offerDetails.status == 'completed'
                                    ? 'Ride is Completed'
                                    : controller.pickUpPassengers.value
                                        ? 'Complete Ride'
                                        : 'Start Ride'),
                          ),
                        ],
                      ))),
            ))));
  }
}
