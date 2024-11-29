import 'dart:async';
import 'dart:developer';

import 'package:car2gouser/models/api_responses/ride_history_response.dart';
import 'package:car2gouser/models/enum.dart';
import 'package:car2gouser/models/location_model.dart';
import 'package:car2gouser/models/screenParameters/accepted_request_screen_parameter.dart';
import 'package:car2gouser/models/screenParameters/select_car_screen_parameter.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyTripScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  RxBool isShareRideTabSelected = false.obs;
  Rx<RideHistoryStatus> selectedStatus = RideHistoryStatus.accepted.obs;

  PagingController<int, RideHistoryDoc> rideHistoryPagingController =
      PagingController(firstPageKey: 1);
  RideHistoryDoc? previousDate(int currentIndex, RideHistoryDoc date) {
    log(currentIndex.toString());
    final previousIndex = currentIndex - 1;
    if (previousIndex == -1) {
      return null;
    }
    RideHistoryDoc? previousNotification =
        rideHistoryPagingController.value.itemList?[previousIndex];
    return previousNotification;
  }

  bool isDateChanges(
      RideHistoryDoc notification, RideHistoryDoc? previousDate) {
    if (previousDate == null) {
      return true;
    }
    final notificationDate = DateTime(notification.createdAt.year,
        notification.createdAt.month, notification.createdAt.day);
    final previousNotificationDate = DateTime(previousDate.createdAt.year,
        previousDate.createdAt.month, previousDate.createdAt.day);
    Duration dateDifference =
        notificationDate.difference(previousNotificationDate);
    return (dateDifference.inDays >= 1 || (dateDifference.inDays <= -1));
  }

  void onRideTabTap(RideHistoryStatus value) {
    selectedStatus.value = value;
    update();
    rideHistoryPagingController.refresh();
  }

  void onRideWidgetTap(
    RideHistoryDoc ride,
  ) {
    log('${ride.id} got tapped');
    Get.toNamed(AppPageNames.acceptedRequestScreen,
        arguments: AcceptedRequestScreenParameter(
            rideId: ride.id,
            selectedCarScreenParameter: SelectCarScreenParameter(
                pickupLocation: LocationModel(
                    latitude: ride.from.location.lat,
                    longitude: ride.from.location.lng,
                    address: ride.from.address),
                dropLocation: LocationModel(
                    latitude: ride.to.location.lat,
                    longitude: ride.to.location.lng,
                    address: ride.to.address))));
  }

/* <---- Get ride history from API ----> */

  Future<void> getRideHistory(currentPageNumber) async {
    final String key = selectedStatus.value.stringValue;
    rideHistoryPagingController.appendLastPage([
      RideHistoryDoc(
        from: RideHistoryFrom(
            address: 'address', location: RideHistoryLocation()),
        to: RideHistoryTo(address: 'address', location: RideHistoryLocation()),
        distance: RideHistoryDistance(text: 'jhhkjhjkh', value: 500),
        duration: RideHistoryDuration(),
        currency: RideHistoryCurrency(),
        driver: RideHistoryDriver(),
        user: RideHistoryUser(),
        ride: RideHistoryRide(),
        date: AppComponents.defaultUnsetDateTime,
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      )
    ]);
    return;
    RideHistoryResponse? response = await APIRepo.getRideHistory(
        page: currentPageNumber, filter: selectedStatus.value.stringValue);
    if (response == null) {
      log('No response for ride History!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingHistory(response);
  }

  onSuccessGettingHistory(RideHistoryResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      rideHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    rideHistoryPagingController.appendPage(response.data.docs, nextPageNumber);
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    rideHistoryPagingController.addPageRequestListener((pageKey) {
      getRideHistory(pageKey);
    });
    super.onInit();
  }

  void popScope() {
    // listen?.cancel();
    // listen2?.cancel();
  }

  @override
  void onClose() {
    // listen?.cancel();
    // listen2?.cancel();
    super.onClose();
  }
}
