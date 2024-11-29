import 'dart:async';
import 'dart:developer';

import 'package:car2gouser/controller/socket_controller.dart';
import 'package:car2gouser/models/api_responses/carpolling/pulling_offer_details_response.dart';
import 'package:car2gouser/models/api_responses/pooling_new_request_socket_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:get/get.dart';

class ViewRequestsScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  String test = 'View Requests Screen Controller is connected!';
  StreamSubscription<PoolingNewRequestSocketResponse>? listen;
  PoolingNewRequestSocketResponse newRequestOfferId =
      PoolingNewRequestSocketResponse();

  String requestId = '';
  String type = 'vehicle';
  PullingOfferDetailsData requestDetails = PullingOfferDetailsData.empty();
  List<PullingOfferDetailsRequest> pendingRequests = [];
  /*<----------- Get request details from API ----------->*/
  Future<void> getRequestDetails() async {
    PoolingOfferDetailsResponse? response =
        await APIRepo.getPoolingOfferDetails(requestId);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForRideDetailsTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRequestDetails(response);
  }

  onSuccessRetrievingRequestDetails(PoolingOfferDetailsResponse response) {
    requestDetails = response.data;
    pendingRequests = response.data.pending;
    update();
  }

  /*<----------- Accept button tap ----------->*/
  void onAcceptButtonTap(String requestId) {
    log('Accepted');
    acceptTheRequest(requestId);
  }

/*<----------- Reject button tap ----------->*/
  void onRejectButtonTap(String requestId) {
    log('Rejected');
    rejectTheRequest(requestId);
  }

/*<----------- Accept request from API----------->*/
  Future<void> acceptTheRequest(String requestId) async {
    RawAPIResponse? response = await APIRepo.updateShareRideRequest(
        requestId: requestId, action: 'accepted');
    if (response == null) {
      log('No response for accepting request!');
      return;
    } else if (response.success) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    log(response.toJson().toString());
    onSuccessAcceptingRequest(response);
  }

  onSuccessAcceptingRequest(RawAPIResponse response) {
    getRequestDetails();
    update();
    AppDialogs.showSuccessDialog(messageText: response.message);
  }

/*<----------- Reject request from API----------->*/
  Future<void> rejectTheRequest(String requestId) async {
    RawAPIResponse? response = await APIRepo.updateShareRideRequest(
        requestId: requestId, action: 'reject');
    if (response == null) {
      log('No response for rejecting request!');
      return;
    } else if (response.success) {
      AppDialogs.showErrorDialog(messageText: response.message);
      return;
    }
    log(response.toJson().toString());
    onSuccessRejectingRequest(response);
  }

  onSuccessRejectingRequest(RawAPIResponse response) {
    getRequestDetails();
    update();
    AppDialogs.showSuccessDialog(messageText: response.message);
  }

/*<----------- Fetch screen navigation argument----------->*/
  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      requestId = params;
      update();
      if (requestId.isNotEmpty) {
        getRequestDetails();
      }
    }
  }

  /*<-----------Get socket response for new pooling request ----------->*/
  dynamic onNewPoolingRequest(dynamic data) async {
    if (data is PoolingNewRequestSocketResponse) {
      newRequestOfferId = data;
      update();
      if (newRequestOfferId.offer.isNotEmpty) {
        getRequestDetails();
      }
    }
  }

/* <---- Initial state ----> */
  @override
  void onInit() {
    _getScreenParameters();
    SocketController socketController = Get.find<SocketController>();

    listen = socketController.pullingRequestResponseData.listen((p0) {
      onNewPoolingRequest(p0);
    });
    super.onInit();
  }

  void popScope() {
    listen?.cancel();
  }

  @override
  void onClose() {
    listen?.cancel();
    super.onClose();
  }
}
