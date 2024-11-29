import 'dart:async';
import 'dart:developer';

import 'package:car2gouser/controller/socket_controller.dart';
import 'package:car2gouser/models/api_responses/pooling_new_request_socket_response.dart';
import 'package:car2gouser/models/api_responses/pooling_request_status_socket_response.dart';

import 'package:car2gouser/models/api_responses/ride_history_response.dart';
import 'package:car2gouser/models/api_responses/share_ride_history_response.dart';
import 'package:car2gouser/models/enum.dart';
import 'package:car2gouser/models/location_model.dart';
import 'package:car2gouser/models/screenParameters/accepted_request_screen_parameter.dart';
import 'package:car2gouser/models/screenParameters/choose_you_need_screen_parameter.dart';
import 'package:car2gouser/models/screenParameters/select_car_screen_parameter.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CarPoolingHistoryScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  RxBool isShareRideTabSelected = false.obs;
  Rx<ShareRideHistoryStatus> selectedShareRideStatus =
      ShareRideHistoryStatus.unknown.obs;
  Rx<ShareRideActions> selectedActionForRideShare =
      ShareRideActions.unknown.obs;
  Rx<ShareRideHistoryStatus> shareRideTypeTab =
      ShareRideHistoryStatus.accepted.obs;
  PoolingNewRequestSocketResponse newRequestOfferId =
      PoolingNewRequestSocketResponse();
  PoolingRequestStatusSocketResponse requestStatusSocketResponse =
      PoolingRequestStatusSocketResponse();
  StreamSubscription<PoolingNewRequestSocketResponse>? listen;
  StreamSubscription<PoolingRequestStatusSocketResponse>? listen2;
  PagingController<int, ShareRideHistoryDoc> shareRideHistoryPagingController =
      PagingController(firstPageKey: 1);

  void onShareRideTabTap(ShareRideHistoryStatus value) {
    shareRideTypeTab.value = value;

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
/* <---- Get share ride history from API ----> */

  Future<void> getShareRideHistory(currentPage) async {
    ShareRideHistoryResponse? response = await APIRepo.getShareRideHistory(
        page: currentPage,
        filter: shareRideTypeTab.value.stringValue,
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
  /*<-----------Get socket response for new pooling request ----------->*/

  dynamic onNewPoolingRequest(dynamic data) async {
    if (data is PoolingNewRequestSocketResponse) {
      newRequestOfferId = data;
      update();
      if (newRequestOfferId.offer.isNotEmpty) {
        shareRideHistoryPagingController.refresh();
      }
    }
  }
  /*<-----------Get socket response for pooling request status update ----------->*/

  dynamic onPoolingRequestStatusUpdate(dynamic data) async {
    if (data is PoolingRequestStatusSocketResponse) {
      requestStatusSocketResponse = data;
      update();
      if (requestStatusSocketResponse.status.isNotEmpty) {
        shareRideHistoryPagingController.refresh();
      }
    }
  }

  /* <---- Initial state ----> */

  @override
  void onInit() {
    shareRideHistoryPagingController.addPageRequestListener((pageKey) {
      getShareRideHistory(pageKey);
    });
    SocketController socketController = Get.find<SocketController>();
    listen = socketController.pullingRequestResponseData.listen((p0) {});
    listen?.onData((data) {
      onNewPoolingRequest(data);
    });
    listen2 = socketController.pullingRequestStatusResponseData.listen((p0) {});
    listen2?.onData((data) {
      onPoolingRequestStatusUpdate(data);
    });
    super.onInit();
  }

  void popScope() {}
}
