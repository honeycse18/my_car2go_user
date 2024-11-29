import 'dart:math';

import 'package:car2gouser/controller/car_pooling/choose_you_need_screen_controller.dart';
import 'package:car2gouser/models/api_responses/carpolling/nearest_pulling_requests_response.dart';
import 'package:car2gouser/models/location_model.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChooseYouNeedScreen extends StatelessWidget {
  const ChooseYouNeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChooseYouNeedScreenController>(
        global: false,
        init: ChooseYouNeedScreenController(),
        builder: ((controller) => CustomScaffold(
              /*<-------AppBar  ------>*/
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText: controller.type ==
                          AppLanguageTranslation
                              .passengerTranskey.toCurrentLanguage
                      ? AppLanguageTranslation
                          .findPassengersTranskey.toCurrentLanguage
                      : AppLanguageTranslation
                          .findRideTranskey.toCurrentLanguage),
              /*<-------Body Content  ------>*/
              body: Column(
                children: [
                  AppGaps.hGap24,
                  Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.dividerColor),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            /*<------- Location picker widget ------>*/
                            child: PickupAndDropLocationPickerWidget(
                              pickUpText: controller.shareRideScreenParameter
                                      .pickUpLocation.address.isEmpty
                                  ? AppLanguageTranslation
                                      .noPickupLocationSelectedTranskey
                                      .toCurrentLanguage
                                  : controller.shareRideScreenParameter
                                      .pickUpLocation.address,
                              dropText: controller.shareRideScreenParameter
                                      .dropLocation.address.isEmpty
                                  ? AppLanguageTranslation
                                      .noDropLocationSelectedTranskey
                                      .toCurrentLanguage
                                  : controller.shareRideScreenParameter
                                      .dropLocation.address,
                              isPickupEditable: false,
                              isDropEditable: false,
                              onPickupEditTap: controller.onPickupEditTap,
                              onDropEditTap: controller.onDropEditTap,
                            ),
                          ),
                          AppGaps.hGap15,
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    color: AppColors.fromBorderColor
                                        .withOpacity(0.3),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Helper.ddMMMyyyyFormattedDateTime(
                                              controller
                                                  .shareRideScreenParameter
                                                  .date),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        Row(
                                          children: [
                                            const SvgPictureAssetWidget(
                                              AppAssetImages.seat,
                                              height: 14,
                                              color: AppColors.bodyTextColor,
                                            ),
                                            AppGaps.wGap5,
                                            Text(
                                              '${controller.shareRideScreenParameter.totalSeat} seat${controller.shareRideScreenParameter.totalSeat > 1 ? "s" : ""}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AppGaps.hGap15,
                        ],
                      ),
                    ),
                  ),
                  /*<------- Nearest vehicle list ------>*/
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        controller.nearestRequestPagingController.refresh();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: PagedListView.separated(
                          pagingController:
                              controller.nearestRequestPagingController,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          separatorBuilder: (context, index) => AppGaps.hGap24,
                          builderDelegate: CoreWidgets
                              .pagedChildBuilderDelegate<NearestRequestsDoc>(
                                  itemBuilder: (context, item, index) {
                            Random random = Random();
                            return SingleOfferItem(
                              onTap: () =>
                                  controller.onSingleRequestTap(item.id),
                              image: item.user.image,
                              name: item.user.name,
                              type: item.type,
                              pricePerSeat: item.rate.toDouble(),
                              rating: random.nextDouble() * 5,
                              totalRides: random.nextInt(500) + 10,
                              pickUpLocation: LocationModel(
                                  latitude: 0,
                                  longitude: 0,
                                  address: item.from.address),
                              dropLocation: LocationModel(
                                  latitude: 0,
                                  longitude: 0,
                                  address: item.to.address),
                              seatAvailable: item.available,
                              seatBooked: item.seats - item.available,
                              dateAndTime: DateTime.now(),
                            );
                          }),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
