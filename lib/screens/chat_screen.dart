import 'package:car2gouser/models/api_responses/chat_message_list_response.dart';
import 'package:car2gouser/controller/chat_screen_controller.dart';
import 'package:car2gouser/models/fakeModel/fake_data.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/widgets/chat_screen_widgets.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:super_tooltip/super_tooltip.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInsetPaddingValue = MediaQuery.of(context).viewInsets.bottom;
    return GetBuilder<ChatScreenController>(
        init: ChatScreenController(),
        builder: (controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                automaticallyImplyLeading: false,
                screenContext: context,
                titleWidget: Row(
                  children: [
                    SuperTooltip(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 250,
                            width: 250,
                            child: CachedNetworkImageWidget(
                              imageURL: controller.getUser.image,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        AppComponents.imageBorderRadius,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          AppGaps.hGap10,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                controller.getUser.name,
                                style: AppTextStyles.bodyLargeMediumTextStyle,
                              ),
                              AppGaps.wGap8,
                              Text(
                                '(${controller.getUser.role})',
                                style: AppTextStyles.bodyTextStyle
                                    .copyWith(color: AppColors.bodyTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CachedNetworkImageWidget(
                          imageURL: controller.getUser.image,
                          imageBuilder: (context, imageProvider) => Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                hasBackButton: true,
                actions: [
                  SvgPicture.asset(
                    AppAssetImages.phonIconLogoLine,
                    height: 24,
                    width: 24,
                    color: Colors.white,
                  ),
                  AppGaps.wGap15,
                ],
              ),
              /* <-------- Body Content --------> */
              body: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                /* <-------- chatting screen --------> */
                child: Column(
                  children: [
                    Expanded(
                      child: ScaffoldBodyWidget(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: PagedListView.separated(
                                  reverse: true,
                                  pagingController:
                                      controller.chatMessagePagingController,
                                  builderDelegate: PagedChildBuilderDelegate<
                                          ChatMessageListItem>(
                                      noItemsFoundIndicatorBuilder: (context) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 65,
                                          width: 65,
                                          child: CachedNetworkImageWidget(
                                            imageURL: controller.getUser.image,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: AppComponents
                                                      .imageBorderRadius,
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              controller.getUser.name,
                                              style: AppTextStyles
                                                  .bodyLargeSemiboldTextStyle,
                                            ),
                                            AppGaps.wGap5,
                                            Text('(${controller.getUser.role})',
                                                style: AppTextStyles
                                                    .bodyTextStyle
                                                    .copyWith(
                                                  color:
                                                      AppColors.bodyTextColor,
                                                )),
                                          ],
                                        ),
                                      ],
                                    );
                                  }, itemBuilder: (context, item, index) {
                                    // final ChatMessageListItem chatMessage =
                                    //     item;
                                    final msz = FakeData.chatMessage[index];
                                    return ChatDeliveryManScreenWidgets
                                        .getCustomDeliveryChatWidget(
                                            image: '',
                                            name: 'Maddy Has',
                                            dateTime: DateTime.now(),
                                            message: msz.chat,
                                            isMyMessage: false);

                                    //Todo: Remove this fake data
                                    // return ChatDeliveryManScreenWidgets
                                    //     .getCustomDeliveryChatWidget(
                                    //         image: chatMessage.from.image,
                                    //         name: chatMessage.from.name,
                                    //         dateTime: chatMessage.createdAt,
                                    //         message: chatMessage.message,
                                    //         isMyMessage: controller
                                    //             .isMyChatMessage(chatMessage));
                                  }),
                                  separatorBuilder: (context, index) =>
                                      AppGaps.hGap24),
                            ),
                            AppGaps.hGap20,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /* <-------- Bottom bar  --------> */
              bottomNavigationBar: Padding(
                padding: AppGaps.bottomNavBarPadding
                    .copyWith(bottom: 15 + bottomInsetPaddingValue),
                /* <---- Chat message text field ----> */
                child: CustomTextFormField(
                  controller: controller.messageController,
                  hintText: 'Type your message',
                  suffixIcon: CustomIconButtonWidget(
                    backgroundColor: Colors.transparent,
                    onTap: () {
                      controller.sendMessage(controller.chatUserId);
                    },
                    child: SvgPicture.asset(
                      AppAssetImages.sendIconSvgLogoLine,
                      height: 24,
                      width: 24,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(maxHeight: 48),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* <---- Attachment icon button ----> */
                      CustomIconButtonWidget(
                        backgroundColor: Colors.transparent,
                        child: SvgPicture.asset(
                          AppAssetImages.attachmentSVGLogoLine,
                          height: 20,
                          width: 20,
                          color: AppColors.bodyTextColor,
                        ),
                        onTap: () {},
                      ),
                      AppGaps.wGap8,

                      /* <---- Camera icon button ----> */
                      CustomIconButtonWidget(
                        backgroundColor: Colors.transparent,
                        child: SvgPicture.asset(
                          AppAssetImages.cameraButtonSVGLogoLine,
                          height: 20,
                          width: 20,
                          color: AppColors.bodyTextColor,
                        ),
                        onTap: () {},
                      ),
                      /* <-------- 8px width gap --------> */
                    ],
                  ),
                ),
              ),
            ));
  }
}
