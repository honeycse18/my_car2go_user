import 'package:car2gouser/controller/my_trip_screen_controller.dart';
import 'package:car2gouser/models/api_responses/ride_history_response.dart';
import 'package:car2gouser/models/enum.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/Tab_list_screen_widget.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/ride_history_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyTripScreen extends StatelessWidget {
  const MyTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTripScreenController>(
        global: false,
        init: MyTripScreenController(),
        builder: (controller) => ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                color: Colors.white,
                child: RefreshIndicator(
                  onRefresh: () async =>
                      controller.rideHistoryPagingController.refresh(),
                  child: ScaffoldBodyWidget(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          decoration: const BoxDecoration(
                              color: AppColors.myRideTabColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /* <---- Upcoming Tab ----> */

                                TabStatusWidget(
                                  text: RideHistoryStatus
                                      .accepted.stringValueForView,
                                  isSelected: controller.selectedStatus.value ==
                                      RideHistoryStatus.accepted,
                                  onTap: () {
                                    controller.onRideTabTap(
                                        RideHistoryStatus.accepted);
                                  },
                                ),
                                /* <---- For extra 10px gap in width ----> */
                                AppGaps.wGap10,
                                /* <---- Started Tab ----> */
                                TabStatusWidget(
                                  text: RideHistoryStatus
                                      .started.stringValueForView,
                                  isSelected: controller.selectedStatus.value ==
                                      RideHistoryStatus.started,
                                  onTap: () {
                                    controller.onRideTabTap(
                                        RideHistoryStatus.started);
                                  },
                                ),
                                /* <---- For extra 10px gap in width ----> */
                                AppGaps.wGap10,
                                /* <---- Completed Tab ----> */
                                TabStatusWidget(
                                  text: RideHistoryStatus
                                      .completed.stringValueForView,
                                  isSelected: controller.selectedStatus.value ==
                                      RideHistoryStatus.completed,
                                  onTap: () {
                                    controller.onRideTabTap(
                                        RideHistoryStatus.completed);
                                  },
                                ),
                                /* <---- For extra 10px gap in width ----> */

                                AppGaps.wGap10,
                                /* <---- Cancelled Tab ----> */
                                TabStatusWidget(
                                  text: RideHistoryStatus
                                      .cancelled.stringValueForView,
                                  isSelected: controller.selectedStatus.value ==
                                      RideHistoryStatus.cancelled,
                                  onTap: () {
                                    controller.onRideTabTap(
                                        RideHistoryStatus.cancelled);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        AppGaps.hGap10,
                        Expanded(
                          child: CustomScrollView(slivers: [
                            const SliverToBoxAdapter(child: AppGaps.hGap5),
                            PagedSliverList.separated(
                              pagingController:
                                  controller.rideHistoryPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<RideHistoryDoc>(
                                      noItemsFoundIndicatorBuilder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    /*<------- Empty ride history ------>*/

                                    EmptyScreenWidget(
                                        localImageAssetURL:
                                            AppAssetImages.confirmIconImage,
                                        title: AppLanguageTranslation
                                            .youHaveNoRideHistoryTransKey
                                            .toCurrentLanguage,
                                        shortTitle: '')
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final RideHistoryDoc rideHistory = item;
                                final previousDate =
                                    controller.previousDate(index, item);
                                final bool isDateChanges = controller
                                    .isDateChanges(item, previousDate);
                                return RideHistoryListItemWidget(
                                  distance: rideHistory.distance.text,
                                  rate: rideHistory.total,
                                  currency: rideHistory.currency.symbol,
                                  carName: rideHistory.ride.name,
                                  carModel: rideHistory.ride.model,
                                  isDateChanged: isDateChanges,
                                  driverName: rideHistory.driver.name,
                                  showCallChat: rideHistory.status ==
                                      RideHistoryStatus.accepted.stringValue,
                                  onSendTap: () {
                                    Get.toNamed(AppPageNames.chatScreen,
                                        arguments: rideHistory.driver.id);
                                  },
                                  pickupLocation: rideHistory.from.address,
                                  dropLocation: rideHistory.to.address,
                                  onTap: () => controller.onRideWidgetTap(item),
                                  date: rideHistory.date,
                                  driverImage: rideHistory.driver.image,
                                  time: rideHistory.date,
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            ),
                            const SliverToBoxAdapter(
                                /* <---- for extra 100px gap in height ----> */
                                child: AppGaps.hGap100),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
