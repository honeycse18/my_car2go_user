import 'dart:async';
import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:car2gouser/models/api_responses/pooling_new_request_socket_response.dart';
import 'package:car2gouser/models/api_responses/pooling_request_status_socket_response.dart';
import 'package:car2gouser/models/api_responses/rent_status_socket_response.dart';
import 'package:car2gouser/controller/socket_controller.dart';
import 'package:car2gouser/models/api_responses/chat_message_list_response.dart';
import 'package:car2gouser/models/api_responses/ride_details_response.dart';
import 'package:car2gouser/models/api_responses/ride_request_update_socket_response.dart';
import 'package:car2gouser/models/api_responses/user_details_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/models/enum.dart';
import 'package:car2gouser/screens/home_navigator/requests_car_pooling.dart';
import 'package:car2gouser/screens/home_navigator/home_screen.dart';
import 'package:car2gouser/screens/home_navigator/my_trip_screen.dart';
import 'package:car2gouser/screens/home_navigator/wallet_screen.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeNavigatorScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  UserDetailsData userDetails = UserDetailsData.empty();
  PoolingNewRequestSocketResponse newRequestOfferId =
      PoolingNewRequestSocketResponse();
  PoolingRequestStatusSocketResponse requestStatusSocketResponse =
      PoolingRequestStatusSocketResponse();
  Widget nestedScreenWidget = const Scaffold();
  int currentPageIndex = 2;
  RideRequestStatus? rideRequestStatus;
  Rx<ChatMessageListItem> newMessageData = ChatMessageListItem.empty().obs;
  Rx<ChatMessageListItem> updatedMessageData = ChatMessageListItem.empty().obs;
  Rx<RideRequestUpdateSocketResponse> rideRequestSocketResponse =
      RideRequestUpdateSocketResponse().obs;
  Rx<RideDetailsData> rideDetails = RideDetailsData.empty().obs;
  RentStatusSocketResponse rentStatusUpdate = RentStatusSocketResponse.empty();

  // final pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  /* <----  widget list ----> */

  final List<Widget> bottomBarPages = [
    const HomeScreen(),
    const RequestCarPullingScreen(),
    const MyTripScreen(),
    const WalletScreen(),
  ];
  StreamSubscription<PoolingNewRequestSocketResponse>? listen;
  StreamSubscription<PoolingRequestStatusSocketResponse>? listen2;
  StreamSubscription<RentStatusSocketResponse>? listen3;
  String get titleText {
    switch (currentIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Request';
      case 2:
        return 'MY Ride';
      case 3:
        return 'Wallet';

      default:
        return '';
    }
  }

  final notchBottomBarController = NotchBottomBarController(index: 0);

  int maxCount = 4;

  @override
  void onClose() {
    // pageController.dispose();
    super.onClose();
  }
  /*<-----------Get socket response for new pooling request ----------->*/

  dynamic onNewPullingRequest(dynamic data) async {
    if (data is PoolingNewRequestSocketResponse) {
      newRequestOfferId = data;
      update();
      if (newRequestOfferId.offer.isNotEmpty) {
        AppDialogs.showSuccessDialog(
            messageText: AppLanguageTranslation
                .youHaveNewRequestTranskey.toCurrentLanguage);
      }
    }
  }
  /*<-----------Get socket response for pooling request status update ----------->*/

  dynamic onPullingRequestStatusUpdate(dynamic data) async {
    if (data is PoolingRequestStatusSocketResponse) {
      requestStatusSocketResponse = data;
      update();
      if (requestStatusSocketResponse.status.isNotEmpty) {
        AppDialogs.showSuccessDialog(
            messageText: AppLanguageTranslation
                .yourRequestHasUpdateTranskey.toCurrentLanguage);
      }
    }
  }
  /*<-----------Get socket response for rent status update ----------->*/

  dynamic onRentStatusUpdate(dynamic data) {
    if (data is RentStatusSocketResponse) {
      rentStatusUpdate = data;
      update();
      if (rentStatusUpdate.id.isNotEmpty) {
        AppDialogs.showSuccessDialog(
            messageText: AppLanguageTranslation
                .yourRentHasUpdateTranskey.toCurrentLanguage);
      }
    }
  }

  Future<void> firebaseTokenUpdate() async {
    final Map<String, dynamic> requestBodyJson = {};
    final String? fcmToken = await Helper.getFCMToken;
    if (Helper.isUserLoggedIn()) {
      requestBodyJson['fcm_token'] = fcmToken;
      RawAPIResponse? response =
          await APIRepo.updateUserProfile(requestBodyJson);
      if (response == null) {
        log('fcm token not updated');
        return;
      } else if (response.success) {
        // AppDialogs.showErrorDialog(messageText: response.msg);
        log('');
        return;
      }
    }
  }

  /* <---- Initial state ----> */ Future<void> getLoggedInUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessGetLoggedInDriverDetails(response);
  }

  void onSuccessGetLoggedInDriverDetails(UserDetailsResponse response) async {
    userDetails = response.data;
    update();
    /*  if ((userDetails..id.isNotEmpty)) {
      await Get.toNamed(AppPageNames.acceptedRequestScreen,
          arguments: AcceptedRequestScreenParameter(
              rideId: userDetails.rideStatus.id,
              selectedCarScreenParameter: SelectCarScreenParameter(
                  pickupLocation: LocationModel(
                      latitude: userDetails.rideStatus.from.location.lat,
                      longitude: userDetails.rideStatus.from.location.lng,
                      address: userDetails.rideStatus.from.address),
                  dropLocation: LocationModel(
                      latitude: userDetails.rideStatus.to.location.lat,
                      longitude: userDetails.rideStatus.to.location.lng,
                      address: userDetails.rideStatus.to.address))));
    } */
  }

  @override
  void onInit() {
    firebaseTokenUpdate();
    SocketController socketController = Get.find<SocketController>();
    if (listen == null) {
      listen = socketController.pullingRequestResponseData.listen((p0) {});
      listen?.onData((data) {
        onNewPullingRequest(data);
      });
    }
    if (listen2 == null) {
      listen2 =
          socketController.pullingRequestStatusResponseData.listen((p0) {});
      listen2?.onData((data) {
        onPullingRequestStatusUpdate(data);
      });
    }
    super.onInit();
  }
}
