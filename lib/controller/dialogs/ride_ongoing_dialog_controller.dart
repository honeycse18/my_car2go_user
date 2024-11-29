import 'dart:async';
import 'package:car2gouser/controller/socket_controller.dart';
import 'package:car2gouser/models/api_responses/ride_details_response.dart';
import 'package:get/get.dart';

class RideOngoingDialogController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  SocketController socketController = Get.find<SocketController>();
  StreamSubscription<RideDetailsData>?
      rideDetailsAcceptRequestScreenSocketListener;
/*<----------- Fetch screen navigation argument----------->*/

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
/*     socketController
        .rideDetailsAcceptRequestScreenSocketListener
        ?.onData((data) {
      if (data.status == 'rejected') {
        Get.back(result: true);
      } else {
        Get.back(result: true);
      }
    }); */
    rideDetailsAcceptRequestScreenSocketListener ??=
        socketController.rideDetails.stream.listen((event) {
      if (event.status == 'rejected') {
        Get.back(result: true);
      } else {
        Get.back(result: true);
      }
    }, cancelOnError: false);

    super.onInit();
  }

  @override
  void onClose() {
    onAsyncClose();
    super.onClose();
  }

  Future<void> onAsyncClose() async {
    await rideDetailsAcceptRequestScreenSocketListener?.cancel();
    rideDetailsAcceptRequestScreenSocketListener = null;
  }
}
