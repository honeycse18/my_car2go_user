import 'package:car2gouser/controller/add_location_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddLocationScreen extends StatelessWidget {
  const AddLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<AddLocationScreenController>(
        global: false,
        init: AddLocationScreenController(),
        builder: ((controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  hasBackButton: true,
                  screenContext: context,
                  titleText: controller.locationID.isEmpty
                      ? AppLanguageTranslation
                          .addLocationTransKey.toCurrentLanguage
                      : AppLanguageTranslation
                          .updateLocationTransKey.toCurrentLanguage),
              /* <-------- Body Content --------> */
              body: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                child: SlidingUpPanel(
                  /* <-------- initialize google map --------> */
                  body: GoogleMap(
                    mapType: MapType.normal,
                    mapToolbarEnabled: false,
                    zoomControlsEnabled: false,
                    myLocationEnabled: false,
                    compassEnabled: true,
                    zoomGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: controller.cameraPosition,
                        zoom: controller.zoomLevel),
                    markers: controller.googleMapMarkers,
                    onMapCreated: controller.onGoogleMapCreated,
                  ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  backdropEnabled: true,
                  // maxHeight: controller.othersClicked ? screenHeight * 0.7 : screenHeight * 0.55,
                  maxHeight: controller.othersClicked ? 550 : 430,
                  minHeight: screenHeight * 0.4,
                  panel: Container(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 16),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BottomSheetTopNotch(),
                        AppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            leading: RawButtonWidget(
                                child: BackButton(
                                    color: AppColors.primaryTextColor),
                                onTap: () {
                                  Get.back();
                                }),
                            title: Text(
                              'Add New Address',
                            )),
                        /* <---- for extra 10px gap in height ----> */
                        AppGaps.hGap10,
                        /* <-------- Select Location --------> */
                        CustomTextFormField(
                          onTap: controller.onLocationTap,
                          isReadOnly: true,
                          hintText: controller.savedLocationScreenParameter
                                  .locationModel.address.isEmpty
                              ? AppLanguageTranslation
                                  .selectALocationFromTheMapTransKey
                                  .toCurrentLanguage
                              : controller.savedLocationScreenParameter
                                  .locationModel.address,
                          prefixIcon: SvgPictureAssetWidget(
                              AppAssetImages.pickUpLocationSVGLogoLine),
                          suffixIcon: const SvgPictureAssetWidget(
                              AppAssetImages.cossSVGIcon),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 16.0),
                          child: Text(
                            AppLanguageTranslation
                                .saveAddressAsTransKey.toCurrentLanguage,
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: controller.saveAsOptions
                                .mapIndexed(
                                  (index, singleOption) => GestureDetector(
                                    onTap: () => controller.onOptionTap(index),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 20.0,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16),
                                            child: Container(
                                              height: 78,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                // color: singleOption ==
                                                //         controller
                                                //             .selectedSaveAsOption
                                                //     ? AppColors.primaryColor
                                                color: AppColors.bodyTextColor
                                                    .withOpacity(0.2),
                                                border: Border.all(
                                                  color: singleOption ==
                                                          controller
                                                              .selectedSaveAsOption
                                                      ? AppColors.primaryColor
                                                      : Colors.transparent,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 36, bottom: 16),
                                                child: Center(
                                                  child: Text(
                                                    singleOption.name,
                                                    style: TextStyle(
                                                      // color: singleOption ==
                                                      //         controller
                                                      //             .selectedSaveAsOption
                                                      //     ? Colors.white
                                                      color: AppColors
                                                          .primaryTextColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: 0,
                                            left: 35,
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.white
                                                            .withOpacity(0.5),
                                                        offset:
                                                            const Offset(0, 10),
                                                        blurRadius: 25)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Center(
                                                child: SvgPictureAssetWidget(
                                                  singleOption.icon,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        if (controller.othersClicked) AppGaps.hGap25,
                        if (controller.othersClicked)
                          CustomTextFormField(
                            controller: controller.addressNameEditingController,
                            labelText: AppLanguageTranslation
                                .addressNameTransKey.toCurrentLanguage,
                            hintText: 'e.g: Shopping Mall',
                            prefixIcon: SvgPictureAssetWidget(
                                AppAssetImages.callSVGLogoLine),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controller.addressNameEditingController.text =
                                    '';
                                controller.update();
                              },
                              child: const SvgPictureAssetWidget(
                                  AppAssetImages.cossSVGIcon),
                            ),
                          ),
                        AppGaps.hGap25,
                        /* <-------- Add or update location--------> */
                        StretchedTextButtonWidget(
                          buttonText: controller.locationID.isEmpty
                              ? AppLanguageTranslation
                                  .addLocationTransKey.toCurrentLanguage
                              : AppLanguageTranslation
                                  .updateLocationTransKey.toCurrentLanguage,
                          onTap: controller.buttonOkay &&
                                  controller.savedLocationScreenParameter
                                      .locationModel.address.isNotEmpty
                              ? controller.onAddLocationButtonTap
                              : null,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
