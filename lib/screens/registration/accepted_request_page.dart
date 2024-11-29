import 'dart:math';

import 'package:car2gouser/controller/accepted_request_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/accepted_ride_screen_widget.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AcceptedRideRequestScreen extends StatelessWidget {
  const AcceptedRideRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<AcceptedRequestScreenController>(
        init: AcceptedRequestScreenController(),
        global: false,
        builder: ((controller) => WillPopScope(
              onWillPop: () async {
                controller.dispose();
                return await Future.value(true);
              },
              child: CustomScaffold(
                extendBodyBehindAppBar: true,
                extendBody: true,
                /* <--------AppBar-------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    titleText: AppLanguageTranslation
                        .rideDetailsTransKey.toCurrentLanguage,
                    hasBackButton: true),
                /* <-------- Body Content --------> */
                body: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        bottom: MediaQuery.of(context).size.height * 0.32,
                        /* <-------- initialize google map --------> */

                        child: GoogleMap(
                          myLocationButtonEnabled: false,
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
                          minHeight: screenHeight * 0.45,
                          maxHeight: controller.rideDetails.status != 'accepted'
                              ? screenHeight * 0.7
                              : screenHeight * 0.55,
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
                                          controller.rideDetails.status ==
                                                  'accepted'
                                              ? SliverToBoxAdapter(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '${AppLanguageTranslation.yourDriverIsComingInTransKey.toCurrentLanguage} ${controller.rideDetails.duration.text}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .primaryTextColor),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : const SliverToBoxAdapter(
                                                  child: AppGaps.emptyGap),
                                          const SliverToBoxAdapter(
                                            child: AppGaps.hGap12,
                                          ),
                                          SliverToBoxAdapter(
                                            child: AcceptedRideScreenWidget(
                                              callTap: () {},
                                              chatTap: () {
                                                // Get.toNamed(
                                                //     AppPageNames.chatScreen,
                                                //     arguments: controller
                                                //         .rideDetails.driver.id);

                                                Get.toNamed(
                                                  AppPageNames.chatScreen,
                                                );
                                              },
                                              gender: 'Male',
                                              // amount:
                                              //     controller.rideDetails.total,
                                              distance: controller
                                                  .rideDetails.distance.text,
                                              duration: controller
                                                  .rideDetails.duration.text,
                                              dropLocation: controller
                                                  .rideDetails.to.address,
                                              pickupLocation: controller
                                                  .rideDetails.from.address,
                                              rating: Random().nextDouble() *
                                                      (5 - 4) +
                                                  4,
                                              userName: controller
                                                  .rideDetails.driver.name,
                                              userImage: controller
                                                  .rideDetails.driver.image,
                                              carImage: controller
                                                  .rideDetails.driver.image,
                                              isRideNow: false,
                                            ),
                                          ),
                                          if ((controller.rideDetails.status !=
                                              'completed'))
                                            const SliverToBoxAdapter(
                                              child: Divider(),
                                            ),
                                          const SliverToBoxAdapter(
                                            child: AppGaps.hGap10,
                                          ),
                                          if ((controller.rideDetails.status !=
                                              'completed'))
                                            SliverToBoxAdapter(
                                              child: RawButtonWidget(
                                                borderRadiusValue: 10,
                                                onTap: controller
                                                    .onSelectPaymentMethod,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      PaymentMethodSelectWidget(
                                                        methodImage: controller
                                                            .getValues
                                                            .paymentImage,
                                                        methodName: controller
                                                            .getValues
                                                            .viewAbleName,
                                                      ),
                                                      Text(
                                                        AppLanguageTranslation
                                                            .selectPaymentMethodTransKey
                                                            .toCurrentLanguage,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .bodyTextColor),
                                                      ),
                                                      const SvgPictureAssetWidget(
                                                          AppAssetImages
                                                              .arrowRightSVGLogoLine)
                                                    ]),
                                              ),
                                            )
                                        ],
                                      )),
                                    )),
                                  ]),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  left: 27,
                                  child: Container(
                                    width: 90,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            controller.otp,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    AppColors.primaryTextColor),
                                          ),
                                          Text(
                                            AppLanguageTranslation
                                                .startOtpTransKey
                                                .toCurrentLanguage,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.bodyTextColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ))
                    ],
                  ),
                ),
                /* <-------- Bottom Bar--------> */
                bottomNavigationBar: /* CustomScaffoldBottomBarWidget(
                    backgroundColor: AppColors.backgroundColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomStretchedButtonWidget(
                          onTap: controller.rideDetails.status == 'started'
                              ? controller.onPaymentTap
                              : controller.rideDetails.status == 'completed'
                                  ? controller.submitReview
                                  : controller.onBottomButtonTap,
                          child: Text(controller.rideDetails.status == 'started'
                              ? AppLanguageTranslation
                                  .makePaymentTransKey.toCurrentLanguage
                              : controller.rideDetails.status == 'completed'
                                  ? AppLanguageTranslation
                                      .submitReviewTransKey.toCurrentLanguage
                                  : AppLanguageTranslation
                                      .cancelRideTransKey.toCurrentLanguage),
                        ),
                      ],
                    )), */
                    CustomScaffoldBottomBarWidget(
                        backgroundColor: AppColors.backgroundColor,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            switch (controller.rideDetails.status) {
                              'started' => const CustomStretchedButtonWidget(
                                  onTap: null,
                                  child: Text('Make payment'),
                                ),
                              'reached' => CustomStretchedButtonWidget(
                                  isLoading: controller.isLoading,
                                  onTap: !controller.makePayment
                                      ? controller.onPaymentTap
                                      : null,
                                  child: !controller.makePayment
                                      ? const Text('Make Payment')
                                      : const Text('Waiting for Completion'),
                                ),
                              'cancelled' => Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${controller.rideDetails.cancelReason.capitalizeFirst}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.errorColor),
                                      ),
                                      AppGaps.hGap10,
                                      CustomStretchedButtonWidget(
                                        onTap: () {
                                          // Get.offAllNamed(
                                          //     AppPageNames.zoomDrawerScreen);
                                          Get.until((route) =>
                                              Get.currentRoute ==
                                              AppPageNames.zoomDrawerScreen);
                                        },
                                        child: const Text('Go To Home'),
                                      )
                                    ],
                                  ),
                                ),
                              _ => const SizedBox(),
                            },
                            /*  CustomStretchedButtonWidget(
                          onTap: controller.rideDetails.status == 'started'
                              ? (controller.rideDetails.status != 'reached'
                                  ? null
                                  : controller.onPaymentTap)
                              : (controller.rideDetails.status == 'completed'
                                  ? controller.submitReview
                                  : null),
                          child: Text(controller.rideDetails.status == 'started'
                              ? (controller.rideDetails.status == 'reached'
                                  ? 'Make Payment'
                                  : 'Make Payment')
                              : (controller.rideDetails.status == 'completed'
                                  ? 'Submit Review'
                                  : 'Make Payment')),
                        ), */
                          ],
                        )),
              ),
            )));
  }
}

class PaymentMethodSelectWidget extends StatelessWidget {
  final String methodName;
  final String methodImage;
  const PaymentMethodSelectWidget({
    super.key,
    required this.methodName,
    required this.methodImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 40,
          width: 40,
          child: CachedNetworkImageWidget(
            imageURL: methodImage,
            imageBuilder: (context, imageProvider) => Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: AppComponents.imageBorderRadius,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
          ),
        ),
        AppGaps.wGap8,
        Text(
          methodName,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTextColor),
        ),
      ],
    );
  }
}
