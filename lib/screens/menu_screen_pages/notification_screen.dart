import 'package:car2gouser/controller/menu_screen_controller/notification_screen_controllar.dart';
import 'package:car2gouser/models/api_responses/notification_list_response.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/notifications_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationScreenController>(
      init: NotificationScreenController(),
      global: false,
      builder: (controller) => CustomScaffold(
          /*<------- AppBar ------>*/

          appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              titleText:
                  AppLanguageTranslation.notificationTransKey.toCurrentLanguage,
              hasBackButton: true,
              actions: [
                RawButtonWidget(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 24,
                    width: 80,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryButtonColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Center(
                        child: Text(
                      AppLanguageTranslation.readAllTransKey,
                      style: AppTextStyles.bodySemiboldTextStyle
                          .copyWith(color: AppColors.primaryButtonColor),
                    )),
                  ),
                  onTap: () {
                    controller.readAllNotification();
                    controller.userNotificationPagingController.refresh();
                  },
                )
              ]),
          /*<------- Body Content ------>*/

          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
              ),
              child: RefreshIndicator(
                onRefresh: () async =>
                    controller.userNotificationPagingController.refresh(),
                child: PagedListView.separated(
                  pagingController: controller.userNotificationPagingController,
                  builderDelegate: CoreWidgets.pagedChildBuilderDelegate<
                      NotificationListItem>(
                    noItemFoundIndicatorBuilder: (context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /* <---- Empty notification ----> */
                          EmptyScreenWidget(
                            isSVGImage: true,
                            localImageAssetURL: AppAssetImages.bellFillIcon,
                            title: AppLanguageTranslation
                                .youHavenoNotificationTranskey
                                .toCurrentLanguage,
                            shortTitle: '',
                          ),
                        ],
                      );
                    },
                    itemBuilder: (context, item, index) {
                      final notification = item;
                      final previousNotification =
                          controller.previousNotification(index, item);
                      final bool isNotificationDateChanges =
                          controller.isNotificationDateChanges(
                              item, previousNotification);
                      /* <---- Notification widget ----> */
                      return NotificationWidget(
                        action: notification.action,
                        tittle: notification.title,
                        description: notification.message,
                        dateTime: notification.createdAt,
                        isDateChanged: isNotificationDateChanges,
                        notificationType: notification.action,
                        isRead: notification.read,
                        onTap: () {
                          controller.readNotification(notification.id);
                          controller.userNotificationPagingController.refresh();
                        },
                      );
                    },
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      AppGaps.hGap24,
                ),
              ),
            ),
          )),
    );
  }
}
