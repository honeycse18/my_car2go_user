import 'dart:developer';

import 'package:car2gouser/models/api_responses/notification_list_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  final PagingController<int, NotificationListItem>
      userNotificationPagingController = PagingController(firstPageKey: 1);
  RxBool hasBackButton = false.obs;
  NotificationListItem? previousNotification(
      int currentIndex, NotificationListItem notification) {
    log(currentIndex.toString());
    final previousIndex = currentIndex - 1;
    if (previousIndex == -1) {
      return null;
    }
    NotificationListItem? previousNotification =
        userNotificationPagingController.value.itemList?[previousIndex];
    return previousNotification;
  }

  bool isNotificationDateChanges(NotificationListItem notification,
      NotificationListItem? previousNotification) {
    if (previousNotification == null) {
      return true;
    }
    final notificationDate = DateTime(notification.createdAt.year,
        notification.createdAt.month, notification.createdAt.day);
    final previousNotificationDate = DateTime(
        previousNotification.createdAt.year,
        previousNotification.createdAt.month,
        previousNotification.createdAt.day);
    Duration dateDifference =
        notificationDate.difference(previousNotificationDate);
    return (dateDifference.inDays >= 1 || (dateDifference.inDays <= -1));
  }
/* <---- Get notifications from API ----> */

  Future<void> getNotifications(int currentPageNumber) async {
    NotificationListResponse? response =
        await APIRepo.getNotificationList(currentPageNumber);
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noNotificationFoundTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(AppLanguageTranslation
          .somethingErrorHappenedTranskey.toCurrentLanguage);
      return;
    }
    onSuccessRetrievingResponse(response);
  }

  onSuccessRetrievingResponse(NotificationListResponse response) {
    final isLastPage = !response.data.hasNextPage;

    if (isLastPage) {
      userNotificationPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    userNotificationPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }
/* <---- Read notification ----> */

  Future<void> readNotification(String id) async {
    Map<String, dynamic> requestBody = {
      '_id': id,
    };
    RawAPIResponse? response = await APIRepo.readNotification(requestBody);
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.success) {
      APIHelper.onFailure(response.message);
      return;
    }
    log(response.toJson().toString());
    _onSuccessSendMessage(response);
  }

  _onSuccessSendMessage(RawAPIResponse response) {
    update();
  }
/* <---- Read all notification ----> */

  Future<void> readAllNotification() async {
    Map<String, dynamic> requestBody = {};
    RawAPIResponse? response = await APIRepo.readAllNotification(requestBody);
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.success) {
      APIHelper.onFailure(response.message);
      return;
    }
    log(response.toJson().toString());
    _onSuccessReadAllNotifications(response);
  }

  _onSuccessReadAllNotifications(RawAPIResponse response) {
    update();
  }
/*<----------- Fetch screen navigation argument----------->*/

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is bool) {
      hasBackButton.value = true;
    }
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameters();
    userNotificationPagingController.addPageRequestListener((pageKey) {
      getNotifications(pageKey);
    });

    super.onInit();
  }
}
