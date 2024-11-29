import 'dart:developer';

import 'package:car2gouser/models/api_responses/share_ride_history_response.dart';
import 'package:car2gouser/models/enum.dart';
import 'package:car2gouser/models/screenParameters/choose_you_need_screen_parameter.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RequestCarPullingScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  RxBool isOfferRideTabSelected = false.obs;
  Rx<ShareRideHistoryStatus> shareRideTypeTab =
      ShareRideHistoryStatus.findRide.obs;
  Rx<ShareRideActions> selectedActionForRideShare =
      ShareRideActions.unknown.obs;
  Rx<ShareRideHistoryStatus> selectedShareRideStatus =
      ShareRideHistoryStatus.unknown.obs;
  PagingController<int, ShareRideHistoryDoc> shareRideHistoryPagingController =
      PagingController(firstPageKey: 1);

/*<-----------Share ride Tab Tap Functions----------->*/

  void onShareRideTabTap(ShareRideHistoryStatus value) {
    shareRideTypeTab.value = value;
    if (value == ShareRideHistoryStatus.findRide) {
      selectedActionForRideShare.value = ShareRideActions.myRequest;
      selectedShareRideStatus.value = ShareRideHistoryStatus.unknown;
    } else if (value == ShareRideHistoryStatus.offering) {
      selectedActionForRideShare.value = ShareRideActions.myOffer;
      selectedShareRideStatus.value = ShareRideHistoryStatus.unknown;
    } else {
      selectedActionForRideShare.value = ShareRideActions.unknown;
      selectedShareRideStatus.value = value;
    }
    update();
    log('Selected Action: ${selectedActionForRideShare.value.stringValueForView}\nSelected Tab: ${selectedShareRideStatus.value.stringValueForView}');
    shareRideHistoryPagingController.refresh();
  }

  onShareRideItemTap(String itemId, ShareRideHistoryDoc item, String type) {
    log('$itemId got tapped!');
    if (selectedActionForRideShare.value == ShareRideActions.myOffer) {
      Get.toNamed(AppPageNames.pullingOfferDetailsScreen,
          arguments: OfferOverViewScreenParameters(
              id: itemId, seat: item.seats, type: type));
    } else {
      if (item.offer.id.isEmpty) {
        Get.toNamed(AppPageNames.pullingOfferDetailsScreen, arguments: item.id);
      } else {
        log('$itemId Ride Got Tapped!');
        Get.toNamed(AppPageNames.pullingRequestDetailsScreen,
            arguments: itemId);
      }
    }
  }

  onRequestButtonTap(String requestId) async {
    log('$requestId got tapped!');
    await Get.toNamed(AppPageNames.viewRequestsScreen, arguments: requestId);
    shareRideHistoryPagingController.refresh();
  }

/*<-----------Get share ride history from API ----------->*/
  Future<void> getShareRideHistory(currentPage) async {
    ShareRideHistoryResponse? response = await APIRepo.getShareRideHistory(
        page: currentPage,
        filter: selectedShareRideStatus.value.stringValue ==
                ShareRideHistoryStatus.unknown.stringValue
            ? ''
            : selectedShareRideStatus.value.stringValue,
        action: selectedActionForRideShare.value.stringValue ==
                ShareRideActions.unknown.stringValue
            ? ''
            : selectedActionForRideShare.value.stringValue);
    if (response == null) {
      log('No response for share Ride history list!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessFetchingHistory(response);
  }

  onSuccessFetchingHistory(ShareRideHistoryResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      shareRideHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    shareRideHistoryPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    shareRideHistoryPagingController.addPageRequestListener((pageKey) {
      getShareRideHistory(pageKey);
    });
    super.onInit();
  }
}
