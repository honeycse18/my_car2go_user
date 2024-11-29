import 'dart:io';

import 'package:car2gouser/controller/picked_location_screen_controller.dart';
import 'package:car2gouser/models/api_responses/recent_location_response.dart';
import 'package:car2gouser/models/api_responses/saved_location_list_response.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickedLocationScreen extends StatelessWidget {
  const PickedLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PickedLocationScreenController>(
        init: PickedLocationScreenController(),
        builder: (controller) => CustomScaffold(
              /*<------- AppBar ------>*/

              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText: AppLanguageTranslation
                      .selectAddressTransKey.toCurrentLanguage,
                  hasBackButton: true),
              /*<------- Body Content ------>*/

              body: ScaffoldBodyWidget(
                  child: Column(
                children: [
                  Column(
                    children: [
                      AppGaps.hGap21,
                      /*<------- Pickup Location Field ------>*/
                      if (Platform.isIOS) AppGaps.hGap40,
                      LocationPickUpTextFormField(
                        onTap: controller.onFocusChange,
                        focusNode: controller.pickUpLocationFocusNode,
                        controller: controller.pickUpLocationTextController,
                        hintText: 'Pickup Location',
                        prefixIcon: const SvgPictureAssetWidget(
                            AppAssetImages.dropLocationSVGLogoLine),
                        suffixIcon: controller
                                .pickUpLocationTextController.text.isNotEmpty
                            ? TightIconButtonWidget(
                                onTap: () {
                                  controller.pickUpLocationTextController.text =
                                      '';
                                  controller.pickUpLocationFocusNode
                                      .requestFocus();
                                  controller.update();
                                },
                                icon: const SvgPictureAssetWidget(
                                  AppAssetImages.cossSVGIcon,
                                  color: AppColors.primaryTextColor,
                                  height: 14,
                                  width: 14,
                                ),
                              )
                            : null,
                      ),
                      /*<------- Drop Location Field ------>*/
                      LocationPickDownTextFormField(
                        onTap: controller.onFocusChange,
                        focusNode: controller.dropLocationFocusNode,
                        controller: controller.dropLocationTextController,
                        hintText: 'Drop Location',
                        prefixIcon: const SvgPictureAssetWidget(
                            AppAssetImages.dropLocationSVGLogoLine),
                        suffixIcon: controller
                                .dropLocationTextController.text.isNotEmpty
                            ? TightIconButtonWidget(
                                onTap: () {
                                  controller.dropLocationTextController.text =
                                      '';
                                  controller.dropLocationFocusNode
                                      .requestFocus();
                                  controller.update();
                                },
                                icon: const SvgPictureAssetWidget(
                                  AppAssetImages.cossSVGIcon,
                                  color: AppColors.primaryTextColor,
                                  height: 14,
                                  width: 14,
                                ),
                              )
                            : null,
                      ),
                      AppGaps.hGap24,
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .savedLocationTransKey.toCurrentLanguage,
                                style: AppTextStyles
                                    .titleSemiSmallSemiboldTextStyle,
                              ),
                              AppGaps.hGap12,
                              SizedBox(
                                height: controller.savedLocations.length > 5
                                    ? 250
                                    : controller.savedLocations.length * 60,
                                child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      final location =
                                          controller.savedLocations[index];
                                      return RawButtonWidget(
                                        borderRadiusValue: 4,
                                        onTap: () => controller
                                            .onSavedLocationTap(location),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SvgPictureAssetWidget(
                                              AppAssetImages.gpsFilledSVG,
                                              color: AppColors.bodyTextColor,
                                            ),
                                            AppGaps.wGap12,
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    location.name ==
                                                            AppLanguageTranslation
                                                                .otherTransKey
                                                                .toCurrentLanguage
                                                        ? location.address
                                                        : location.name,
                                                    style: AppTextStyles
                                                        .bodyLargeSemiboldTextStyle,
                                                  ),
                                                  AppGaps.hGap4,
                                                  Text(
                                                    location.address,
                                                    style: AppTextStyles
                                                        .bodyTextStyle,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        AppGaps.hGap10,
                                    itemCount:
                                        controller.savedLocations.length),
                              ),
                              if (controller.recentLocations.isNotEmpty)
                                AppGaps.hGap24,
                              if (controller.recentLocations.isNotEmpty)
                                Text(
                                  AppLanguageTranslation
                                      .recentLocationTransKey.toCurrentLanguage,
                                  style: AppTextStyles
                                      .titleSemiSmallSemiboldTextStyle,
                                ),
                              AppGaps.hGap12,
                              SizedBox(
                                height: controller.recentLocations.length > 5
                                    ? 250
                                    : controller.recentLocations.length * 50,
                                child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      RecentLocationsData location =
                                          controller.recentLocations[index];
                                      return RawButtonWidget(
                                        onTap: () => controller
                                            .onSavedLocationTap(location),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SvgPictureAssetWidget(
                                              AppAssetImages
                                                  .dropLocationSVGLogoLine,
                                              color: AppColors.bodyTextColor,
                                            ),
                                            AppGaps.wGap12,
                                            /*<------- Recent searching addresses ------>*/

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    AppLanguageTranslation
                                                        .recentTransKey
                                                        .toCurrentLanguage,
                                                    style: AppTextStyles
                                                        .bodyLargeSemiboldTextStyle,
                                                  ),
                                                  AppGaps.hGap4,
                                                  Text(
                                                    location.address,
                                                    style: AppTextStyles
                                                        .bodyTextStyle,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        AppGaps.hGap10,
                                    itemCount:
                                        controller.recentLocations.length),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
              /*<------- Bottom Bar------>*/
              bottomNavigationBar: ScaffoldBottomBarWidget(
                  backgroundColor: Colors.white,
                  padding: AppGaps.bottomNavBarPadding.copyWith(
                    top: 10,
                    bottom: context.mediaQueryViewInsets.bottom + 10,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        controller.pickUpLocationFocusNode.hasFocus
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                    children: [
                      if (controller.pickUpLocationFocusNode.hasFocus)
                        GestureDetector(
                          onTap: () => controller.getCurrentPosition(context),
                          child: Row(children: [
                            const SvgPictureAssetWidget(
                              AppAssetImages.currentLocationSVGLogoLine,
                            ),
                            AppGaps.wGap10,
                            Text(
                              AppLanguageTranslation
                                  .currentLocationTransKey.toCurrentLanguage,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ]),
                        ),

                      /*<------- Select location from google map ------>*/

                      GestureDetector(
                        onTap: controller.onLocateOnMapButtonTap,
                        child: Row(children: [
                          const Image(
                            height: 16,
                            width: 16,
                            image: AssetImage(
                              AppAssetImages.locateOnMapLogoLine,
                            ),
                            color: AppColors.bodyTextColor,
                          ),
                          AppGaps.wGap10,
                          Text(
                              AppLanguageTranslation
                                  .locationOnMapTransKey.toCurrentLanguage,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.bodyTextColor,
                              ))
                        ]),
                      )
                    ],
                  )),
            ));
  }
}
