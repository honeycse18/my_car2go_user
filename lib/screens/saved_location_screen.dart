import 'package:car2gouser/controller/saved_locations_screen_controller.dart';
import 'package:car2gouser/models/api_responses/saved_location_list_response.dart';
import 'package:car2gouser/models/api_responses/t/saved_Location/address_list_response/address_list_response.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedLocationScreen extends StatelessWidget {
  const SavedLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedLocationsScreenController>(
        init: SavedLocationsScreenController(),
        builder: (controller) => CustomScaffold(
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText: AppLanguageTranslation
                      .savedAddressTransKey.toCurrentLanguage),
              body: RefreshIndicator(
                onRefresh: () async => controller.getSavedAddressList(),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: CustomScrollView(
                    slivers: [
                      controller.savedLocations.isEmpty
                          ? SliverToBoxAdapter(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppGaps.hGap20,
                                /* <---- Empty location ----> */
                                EmptyScreenWidget(
                                    height: 158,
                                    localImageAssetURL:
                                        AppAssetImages.emptyLocationImage,
                                    title: AppLanguageTranslation
                                        .noSavedAddressTransKey
                                        .toCurrentLanguage),
                              ],
                            ))
                          : SliverList.separated(
                              itemBuilder: (context, index) {
                                SavedAddressItem location =
                                    controller.savedLocations[index];

                                List<String> icons = [
                                  AppAssetImages.homeDarkSVGLogoSolid,
                                  AppAssetImages.officeDarkSVGLogoSolid,
                                  AppAssetImages.mallDarkSVGLogoSolid
                                ];
                                final String icon;
                                if (location.name == 'Home') {
                                  icon = icons[0];
                                } else if (location.name == 'Office') {
                                  icon = icons[1];
                                } else {
                                  icon = icons[2];
                                }

                                ///Remover These later when API is ready    ----END
                                return Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.shadowColor
                                            .withOpacity(0.12),
                                        offset: (const Offset(0, 80)),
                                        spreadRadius: -12,
                                        blurRadius: 200,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.primaryButtonColor,
                                  ),
                                  height: 110,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPictureAssetWidget(
                                          icon,
                                          height: 20,
                                          width: 20,
                                        ),
                                        AppGaps.wGap12,
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    location.name,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .primaryTextColor),
                                                  ),
                                                  const Spacer(),
                                                  /* <---- trash button ----> */
                                                  GestureDetector(
                                                    onTap: () => controller
                                                        .onDeleteButtonTap(
                                                            location.id),
                                                    child:
                                                        const SvgPictureAssetWidget(
                                                      AppAssetImages
                                                          .trashSVGLogoLine,
                                                      color:
                                                          AppColors.errorColor,
                                                    ),
                                                  ),
                                                  AppGaps.wGap12,
                                                  /* <---- Edit button ----> */
                                                  RawButtonWidget(
                                                    onTap: () => controller
                                                        .onEditLocationButtonTap(
                                                            location),
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        child: Text(
                                                          AppLanguageTranslation
                                                              .editTransKey
                                                              .toCurrentLanguage,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white),
                                                        )),
                                                  )
                                                ],
                                              ),
                                              const Spacer(),
                                              Text(
                                                location.name,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .bodyTextColor),
                                              ),
                                              Text(
                                                location.address,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .bodyTextColor),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap24,
                              itemCount: controller.savedLocations.length,
                            ),
                      const SliverToBoxAdapter(
                        child: AppGaps.hGap100,
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: ScaffoldBodyWidget(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /* <---- Add new address button ----> */
                  CustomStretchedButtonWidget(
                    onTap: controller.onAddLocationButtonTap,
                    child: Text(AppLanguageTranslation
                        .addNewAddressTransKey.toCurrentLanguage),
                  ),
                  AppGaps.hGap24,
                ],
              )),
            ));
  }
}
