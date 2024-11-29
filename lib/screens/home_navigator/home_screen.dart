import 'dart:developer';

import 'package:car2gouser/controller/home_screen_controller.dart';
import 'package:car2gouser/utils/app_singleton.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SampleItem? selectedMenu;
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        global: false,
        builder: (controller) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalGap(24),
                  Text(
                    AppLanguageTranslation
                        .choseYourRideTransKey.toCurrentLanguage,
                    style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                  ),
                  const VerticalGap(12),
                  Row(
                    children: [
                      /* <---- Ride now function in Sliding up panel ----> */
                      Expanded(
                        child: RawButtonWidget(
                          child: Container(
                            height: 121,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.fromBorderColor),
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssetImages.rideNowIconImage,
                                    height: 46,
                                    width: 46,
                                  ),
                                  AppGaps.hGap4,
                                  Text(
                                      AppLanguageTranslation
                                          .rideNowTransKey.toCurrentLanguage,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles
                                          .notificationDateSection
                                          .copyWith(
                                        color: AppColors.primaryColor,
                                      ))
                                ]),
                          ),
                          onTap: () {
                            Get.toNamed(AppPageNames.pickedLocationScreen,
                                arguments: false);
                          },
                        ),
                      ),
                      /* <---- For extra 16px gap in width ----> */
                      AppGaps.wGap16,
                      /* <---- Schedule Ride function in Sliding up panel ----> */
                      Expanded(
                        child: RawButtonWidget(
                          child: Container(
                            height: 121,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.fromBorderColor),
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssetImages.carPoolingIconImage,
                                    height: 46,
                                    width: 46,
                                  ),
                                  Text(
                                      AppLanguageTranslation
                                          .carPoolingTranskey.toCurrentLanguage,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles
                                          .notificationDateSection
                                          .copyWith(
                                        color: AppColors.primaryColor,
                                      ))
                                ]),
                          ),
                          onTap: () {
                            Get.toNamed(AppPageNames.rideShareScreen);
                          },
                        ),
                      ),
                    ],
                  ),
                  const VerticalGap(32),
                  Stack(
                    children: [
                      Container(
                        height: 192,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Obx(() => GoogleMap(
                                mapType: MapType.normal,
                                mapToolbarEnabled: false,
                                zoomControlsEnabled: false,
                                myLocationEnabled: false,
                                myLocationButtonEnabled: true,
                                compassEnabled: true,
                                zoomGesturesEnabled: true,
                                initialCameraPosition:
                                    AppSingleton.instance.defaultCameraPosition,
                                markers: {
                                  Marker(
                                      markerId: const MarkerId('user_location'),
                                      position: controller.userLocation.value,
                                      icon: controller.myCarIcon ??
                                          BitmapDescriptor.defaultMarker),
                                },
                                polylines: controller.googleMapPolylines,
                                onMapCreated: controller.onGoogleMapCreated,
                                onTap: controller.onGoogleMapTap,
                              )),
                        ),
                      ),
                      Positioned(
                          bottom: 33,
                          right: 18,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14)),
                            child: IconButtonWidget(
                              backgroundColor: Colors.white,
                              onTap: () {
                                controller.getCurrentLocation();
                                log('location tapped');
                              },
                              child: const SvgPictureAssetWidget(
                                  /*<------- Location icon ------>*/

                                  AppAssetImages.currentLocationSVGLogoLine,
                                  color: AppColors.primaryColor),
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ));
  }
}
