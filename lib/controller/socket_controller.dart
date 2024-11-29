import 'dart:developer';

import 'package:car2gouser/models/api_responses/pooling_new_request_socket_response.dart';
import 'package:car2gouser/models/api_responses/pooling_request_status_socket_response.dart';
import 'package:car2gouser/models/api_responses/chat_message_list_response.dart';
import 'package:car2gouser/models/api_responses/ride_details_response.dart';
import 'package:car2gouser/models/api_responses/ride_request_update_socket_response.dart';
import 'package:car2gouser/models/enum.dart';
import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  /*<----------- Initialize variables ----------->*/

/*   RideRequestStatus? rideRequestStatus;
  Rx<ChatMessageListItem> newMessageData = ChatMessageListItem.empty().obs;
  Rx<ChatMessageListItem> updatedMessageData = ChatMessageListItem.empty().obs;
  Rx<RideRequestUpdateSocketResponse> rideRequestSocketResponse =
      RideRequestUpdateSocketResponse().obs;
  Rx<RideDetailsData> rideDetails = RideDetailsData.empty().obs;
  Rx<NewRentSocketResponse> newRentSocketData =
      NewRentSocketResponse.empty().obs;
  Rx<RentStatusSocketResponse> rentStatusSocketData =
      RentStatusSocketResponse.empty().obs;


  Rx<HireSocketResponse> hireDetails = HireSocketResponse.empty().obs; */

  RideRequestStatus? rideRequestStatus;
  Rx<ChatMessageListItem> newMessageData = ChatMessageListItem.empty().obs;
  Rx<ChatMessageListItem> updatedMessageData = ChatMessageListItem.empty().obs;
  Rx<RideDetailsData> rideDetails = RideDetailsData.empty().obs;
  Rx<RideRequestUpdateSocketResponse> rideRequestSocketResponse =
      RideRequestUpdateSocketResponse().obs;
  Rx<PoolingRequestStatusSocketResponse> pullingRequestStatusResponseData =
      PoolingRequestStatusSocketResponse().obs;
  Rx<PoolingNewRequestSocketResponse> pullingRequestResponseData =
      PoolingNewRequestSocketResponse().obs;
  /*<-----------Socket initialize ----------->*/
  IO.Socket socket = IO.io(
      AppConstants.appBaseURL,
      IO.OptionBuilder().setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']).build());
  /*<-----------Get socket response for ride request status ----------->*/
  dynamic onRideRequestStatus(dynamic data) async {
    log('data socket');
    final RideRequestUpdateSocketResponse mapData =
        RideRequestUpdateSocketResponse.getAPIResponseObjectSafeValue(data);
    rideRequestSocketResponse.value = mapData;
    update();
  }
  /*<-----------Get socket response for ride request status update ----------->*/

  dynamic onRideRequestStatusUpdate(dynamic data) async {
    final RideDetailsData mapData =
        RideDetailsData.getAPIResponseObjectSafeValue(data);
    rideDetails.value = mapData;
    update();
    log('Ride is updated!');
  }
  /*<-----------Get socket response for new messages ----------->*/

  dynamic onNewMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    newMessageData.value = mapData;
    update();
  }

/*<-----------Get socket response for update messages ----------->*/
  dynamic onUpdateMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    updatedMessageData.value = mapData;
    update();
  }

  /*<-----------Get socket response for new pooling request ----------->*/
  dynamic onNewPoolingRequest(dynamic data) {
    log(data.toString());
    final PoolingNewRequestSocketResponse mapData =
        PoolingNewRequestSocketResponse.getAPIResponseObjectSafeValue(data);
    pullingRequestResponseData.value = mapData;
    update();
  }
  /*<-----------Get socket response for new pooling request status update ----------->*/

  dynamic onPullingRequestStatusUpdate(dynamic data) {
    log(data.toString());
    final PoolingRequestStatusSocketResponse mapData =
        PoolingRequestStatusSocketResponse.getAPIResponseObjectSafeValue(data);
    pullingRequestStatusResponseData.value = mapData;
    update();
  }

  void initSocket() {
    IO.Socket socket = IO.io(
        AppConstants.appBaseURL,
        IO.OptionBuilder()
            // .setAuth(Helper.getAuthHeaderMap())
            .setAuth(<String, String>{
          'token': Helper.getUserToken()
        }).setTransports(['websocket']) // for Flutter or Dart VM
            .build());
    if (socket.connected == false) {
      socket = socket.connect();
    }
    socket.on('ride_request_status', onRideRequestStatus);
    socket.on('ride_update', onRideRequestStatusUpdate);
    socket.on('new_message', onNewMessages);
    socket.on('update_message', onUpdateMessages);
    socket.on('new_admin_message', onNewMessages);
    socket.on('update_admin_message', onUpdateMessages);
    socket.on('pulling_request', onNewPoolingRequest);
    socket.on('pulling_request_status', onPullingRequestStatusUpdate);
    socket.onConnect((data) {
      log('Socket Connect');
    });

    socket.onConnectError((data) {
      log('data connect Error'.toString());
    });
    socket.onConnecting((data) {
      log('data Connecting'.toString());
    });
    socket.onConnectTimeout((data) {
      log('data Connect Timeout');
    });
    socket.onReconnectAttempt((data) {
      log('data Reconnect Attempt');
    });
    socket.onReconnect((data) {
      log('data Reconnect');
    });
    socket.onReconnectFailed((data) {
      log('data Reconnect Failed');
    });
    socket.onReconnectError((data) {
      log('data Reconnect Error');
    });
    socket.onError((data) {
      log('data Error');
    });
    socket.onDisconnect((data) {
      log('data Disconnect');
    });
    socket.onPing((data) {
      log('data Ping');
    });
    socket.onPong((data) {
      log('data Pong');
    });
  }

/* <---- Initial state ----> */
  void disposeSocket() {
    if (socket.connected) {
      socket.disconnect();
    }
    socket.dispose();
    super.onClose();
  }

  void initializeSocket() {
    IO.Socket socket = IO.io(
        AppConstants.appBaseURL,
        IO.OptionBuilder().setAuth(<String, String>{
          'token': Helper.getUserToken()
        }).setTransports(['websocket']).build());
    if (!socket.connected) {
      // _initSocket();
    }
  }

  Future<void> addStreamListeners() async {}
  Future<void> clearStreamListeners() async {}
  Future<void> closeStreamControllers() async {}
  @override
  void onInit() {
    addStreamListeners();
    super.onInit();
  }

  @override
  void onClose() {
    disposeSocket();
    super.onClose();
  }
}
