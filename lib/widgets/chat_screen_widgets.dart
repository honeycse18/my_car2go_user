import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class ChatDeliveryManScreenWidgets {
  /* <---- Get chat message widget based on who sent the message ----> */

  static Widget getCustomDeliveryChatWidget({
    required DateTime dateTime,
    DateTime? previousMessageDateTime,
    required String message,
    required String name,
    required String image,
    required bool isMyMessage,
  }) {
    if (isMyMessage) {
      return MyMessageSingleWidget(dateTime: dateTime, message: message);
    } else {
      return RecipientMessageSingleWidget(
        dateTime: dateTime,
        message: message,
        image: image,
        name: name,
      );
    }
  }
}

/* <---- Chat message widget of my message ----> */

class MyMessageSingleWidget extends StatelessWidget {
  final DateTime dateTime;
  final DateTime? previousMessageDateTime;
  final String message;
  const MyMessageSingleWidget({
    Key? key,
    required this.dateTime,
    this.previousMessageDateTime,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Spacer(flex: 2),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Builder(builder: (context) {
                    if (message.isEmpty) {
                      return AppGaps.emptyGap;
                    }
                    return Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: AppComponents.defaultBorderRadius,
                              topRight: AppComponents.defaultBorderRadius,
                              bottomLeft: AppComponents.defaultBorderRadius,
                              bottomRight: Radius.circular(0)),
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.25),
                                offset: const Offset(0, 8),
                                spreadRadius: -8,
                                blurRadius: 10)
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            message,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool get showDate {
    return false;
  }
}

class RecipientMessageSingleWidget extends StatelessWidget {
  final DateTime dateTime;
  final DateTime? previousMessageDateTime;
  final String message;
  final String name;
  final String image;
  const RecipientMessageSingleWidget({
    Key? key,
    required this.dateTime,
    this.previousMessageDateTime,
    required this.message,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(builder: (context) {
                    if (message.isEmpty) {
                      return AppGaps.emptyGap;
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: CachedNetworkImageWidget(
                              imageURL: image,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  )),
                        ),
                        AppGaps.wGap10,
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: AppComponents.defaultBorderRadius,
                                    topRight: AppComponents.defaultBorderRadius,
                                    bottomLeft: Radius.circular(0),
                                    bottomRight:
                                        AppComponents.defaultBorderRadius),
                                color: AppColors.fromBorderColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      offset: const Offset(0, 8),
                                      spreadRadius: -5,
                                      blurRadius: 10)
                                ]),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message,
                                  style: const TextStyle(
                                      color: AppColors.primaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                AppGaps.hGap5,
                                Text(
                                  Helper.getRelativeDateTimeText(dateTime),
                                  style: const TextStyle(
                                      color: AppColors.bodyTextColor,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            const Spacer(flex: 2)
          ],
        ),
      ],
    );
  }

  bool get showDate {
    return false;
  }
}
