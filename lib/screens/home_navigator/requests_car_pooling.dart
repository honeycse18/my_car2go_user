import 'package:car2gouser/controller/car_pooling/car_pooling_screen_controller.dart';
import 'package:car2gouser/models/api_responses/share_ride_history_response.dart';
import 'package:car2gouser/models/enum.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/share_ride_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RequestCarPullingScreen extends StatelessWidget {
  const RequestCarPullingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestCarPullingScreenController>(
        init: RequestCarPullingScreenController(),
        global: false,
        builder: ((controller) => ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  color: Colors.white,
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        controller.shareRideHistoryPagingController.refresh(),
                    child: ScaffoldBodyWidget(
                      child: Column(
                        children: [
                          DecoratedBox(
                            decoration: const BoxDecoration(
                                color: AppColors.myRideTabColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: SizedBox(
                                      height: 52,
                                      child: Obx(() =>
                                          CustomTabToggleButtonWidget(
                                              /*<------- Offering Tab ------>*/

                                              text: AppLanguageTranslation
                                                  .offeringTransKey
                                                  .toCurrentLanguage,
                                              isSelected: !controller
                                                  .isOfferRideTabSelected.value,
                                              onTap: () {
                                                controller
                                                    .isOfferRideTabSelected
                                                    .value = false;
                                                controller.onShareRideTabTap(
                                                    ShareRideHistoryStatus
                                                        .offering);
                                              })),
                                    ),
                                  ),
                                ),
                                /* <---- For extra 5px gap in width ----> */
                                AppGaps.wGap5,
                                /* <---- Product Won Auctions tab button ----> */
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SizedBox(
                                      height: 48,
                                      child: Obx(() =>
                                          CustomTabToggleButtonWidget(
                                              /*<------- Finding Tab ------>*/

                                              text: AppLanguageTranslation
                                                  .findingTransKey
                                                  .toCurrentLanguage,
                                              isSelected: controller
                                                  .isOfferRideTabSelected.value,
                                              onTap: () {
                                                controller
                                                    .isOfferRideTabSelected
                                                    .value = true;
                                                controller.onShareRideTabTap(
                                                    ShareRideHistoryStatus
                                                        .findRide);
                                              })),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          AppGaps.hGap10,
                          Expanded(
                            child: CustomScrollView(
                              slivers: [
                                const SliverToBoxAdapter(
                                  child: AppGaps.hGap18,
                                ),
                                PagedSliverList.separated(
                                    pagingController: controller
                                        .shareRideHistoryPagingController,
                                    builderDelegate: PagedChildBuilderDelegate<
                                            ShareRideHistoryDoc>(
                                        itemBuilder: (context, item, index) {
                                      ShareRideHistoryUser user = item.user;
                                      ShareRideHistoryFrom from = item.from;
                                      ShareRideHistoryTo to = item.to;
                                      DateTime date = item.date;
                                      String status =
                                          ShareRideAllStatus.toEnumValue(
                                                  item.status)
                                              .stringValueForView;
                                      String id = item.id;
                                      int pending = item.pending;
                                      String type = item.type;
                                      if (item.offer.id.isNotEmpty) {
                                        user = item.offer.user;
                                        from = item.offer.from;
                                        to = item.offer.to;
                                        type = item.offer.type;
                                        date = item.offer.date;
                                      }
                                      return ShareRideListItemWidget(
                                          onTap: () =>
                                              controller.onShareRideItemTap(
                                                  id, item, type),
                                          onRequestButtonTap:
                                              controller.selectedActionForRideShare
                                                              .value ==
                                                          ShareRideActions
                                                              .myOffer &&
                                                      item.pending > 0
                                                  ? () async {
                                                      await controller
                                                          .onRequestButtonTap(
                                                              id);
                                                      controller
                                                          .shareRideHistoryPagingController
                                                          .refresh();
                                                    }
                                                  : null,
                                          image: user.image,
                                          type: type,
                                          seats: item.seats,
                                          available: item.available,
                                          pickupLocation: from.address,
                                          dropLocation: to.address,
                                          time: date,
                                          date: date,
                                          status: status,
                                          showPending: controller
                                                  .shareRideTypeTab.value ==
                                              ShareRideHistoryStatus.offering,
                                          pending: pending);
                                    }),
                                    separatorBuilder: (context, index) =>
                                        AppGaps.hGap16),
                                const SliverToBoxAdapter(
                                  /* <---- For extra 100px gap in height ----> */
                                  child: AppGaps.hGap100,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            )));
  }
}
