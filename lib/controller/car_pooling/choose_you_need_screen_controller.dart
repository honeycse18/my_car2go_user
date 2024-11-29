import 'dart:developer';

import 'package:car2gouser/models/api_responses/carpolling/nearest_pulling_requests_response.dart';
import 'package:car2gouser/models/location_model.dart';
import 'package:car2gouser/models/screenParameters/choose_you_need_screen_parameter.dart';
import 'package:car2gouser/models/screenParameters/select_screen_parameters.dart';
import 'package:car2gouser/models/screenParameters/share_ride_screen_parameter.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChooseYouNeedScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  String date = '';
  String type = '';
  int totalSeat = 0;

  ShareRideScreenParameter shareRideScreenParameter =
      ShareRideScreenParameter.empty();
  PagingController<int, NearestRequestsDoc> nearestRequestPagingController =
      PagingController(firstPageKey: 1);

  void onPickupEditTap() async {
    dynamic result = await Get.toNamed(AppPageNames.selectLocationScreen,
        arguments: SelectLocationScreenParameters(
            locationModel: shareRideScreenParameter.pickUpLocation,
            showCurrentLocationButton: true));
    if (result is LocationModel) {
      shareRideScreenParameter.pickUpLocation = result;
      update();
    }
  }

  void onDropEditTap() async {
    dynamic result = await Get.toNamed(AppPageNames.selectLocationScreen,
        arguments: SelectLocationScreenParameters(
            locationModel: shareRideScreenParameter.dropLocation,
            showCurrentLocationButton: false));
    if (result is LocationModel) {
      shareRideScreenParameter.dropLocation = result;
      update();
    }
  }

  Map<String, String> getParametersExtracted() {
    return {
      'lat': shareRideScreenParameter.pickUpLocation.latitude.toString(),
      'lng': shareRideScreenParameter.pickUpLocation.longitude.toString(),
      'seats': shareRideScreenParameter.totalSeat.toString(),
      'date': date,
      'type': shareRideScreenParameter.type
    };
  }

/*<-----------Get nearest request from API ----------->*/
  Future<void> getNearestRequests(int currentPageNumber) async {
    final Map<String, String> requestBody = getParametersExtracted();
    NearestPoolingRequestsResponse? response =
        await APIRepo.getNearestRequests(requestBody, currentPageNumber);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseFromServerTryAgainTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingNearestList(response);
  }

  onSuccessGettingNearestList(NearestPoolingRequestsResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      nearestRequestPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    nearestRequestPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  void onSingleRequestTap(String requestId) {
    log('$requestId got tapped!');
    Get.toNamed(AppPageNames.pullingRequestOverviewScreen,
        arguments: OfferOverViewScreenParameters(
            id: requestId,
            type: shareRideScreenParameter.type,
            seat: totalSeat));
  }
/*<----------- Fetch screen navigation argument----------->*/

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is ShareRideScreenParameter) {
      shareRideScreenParameter = params;
      date = Helper.yyyyMMddFormattedDateTime(params.date);
      totalSeat = params.totalSeat;
      type = params.type;
      update();
    } else if (params is Map<String, dynamic>) {
      date = params['date'].toString();
      totalSeat = params['seats'];
      update();
    }
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameters();
    nearestRequestPagingController.addPageRequestListener((pageKey) {
      getNearestRequests(pageKey);
    });
    super.onInit();
  }
}
