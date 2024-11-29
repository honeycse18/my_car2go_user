import 'package:car2gouser/controller/menu_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:car2gouser/widgets/drawer_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuScreenController>(
        global: false,
        init: MenuScreenController(),
        builder: (controller) => Scaffold(
              body: Stack(
                children: [
                  Positioned.fill(
                      child: Container(
                    // color: AppColors.primaryColor.withOpacity(0.5),
                    color: AppColors.backgroundColor,
                    child: ScaffoldBodyWidget(
                      child: SafeArea(
                        child: RefreshIndicator(
                          onRefresh: () async =>
                              Helper.updateSavedUserDetails(),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* <---- For extra 50px gap in height ----> */
                                const VerticalGap(28),
                                Row(
                                  children: [
                                    BackArrowButtonWidget(
                                      color: AppColors.primaryTextColor,
                                      onTap: () {
                                        controller.zoomDrawerScreenController
                                            .zoomDrawerController.close
                                            ?.call();
                                      },
                                    ),
                                    const HorizontalGap(43),
                                    Text(
                                      'Menu',
                                      style: AppTextStyles.bodyBoldTextStyle
                                          .copyWith(fontSize: 24),
                                    )
                                  ],
                                ),
/*                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 115,
                                      width: 115,
                                      child: CachedNetworkImageWidget(
                                        imageURL:
                                            controller.profileDetails.image,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                /* <---- For extra 20px gap in height ----> */
                                AppGaps.hGap20,
                                Column(
                                  children: [
                                    /* <---- User profile name here ----> */
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Text(
                                                controller.profileDetails.name,
                                                textAlign: TextAlign.center,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles
                                                    .titlesemiSmallMediumTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryTextColor))),
                                      ],
                                    ),
                                    /* <---- User profile mail here ----> */
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Text(
                                                controller.profileDetails.email,
                                                textAlign: TextAlign.center,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles
                                                    .bodySmallTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .primaryTextColor))),
                                      ],
                                    ),
                                  ],
                                ), */
                                const VerticalGap(26),
                                RawButtonWidget(
                                  isCircleShape: true,
                                  onTap: () {
                                    Get.toNamed(AppPageNames.profileScreen);
                                  },
                                  child: SizedBox.square(
                                    dimension: 70,
                                    /* <-------- Fetch user image from API --------> */
                                    child: CachedNetworkImageWidget(
                                      imageURL: controller.profileDetails.image,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.white),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  ),
                                ),
                                /* <-------- 20px height gap --------> */
                                const VerticalGap(8),
                                Text(controller.profileDetails.name,
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles
                                        .titlesemiSmallMediumTextStyle
                                        .copyWith()),
                                Text(controller.profileDetails.email,
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.bodySmallTextStyle
                                        .copyWith()),
                                const VerticalGap(12),
                                /* <---- For extra 80px gap in height ----> */
                                const VerticalGap(32),

                                /* <---- Profile function in the drawer menu ----> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .profileTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.userProfileSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () async {
                                      Get.toNamed(AppPageNames.profileScreen);
                                    }),
                                /* <---- For extra 22px gap in height ----> */
                                AppGaps.hGap22,

                                /* <---- Car Pooling history function in the drawer menu ----> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .carPoolingHistoryTransKey
                                        .toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.myVehicleSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.carPoolingHistroyScreen);
                                    }),
                                //demo
                                DrawerMenuSvgWidget(
                                    text: 'Select car',
                                    localAssetIconName:
                                        AppAssetImages.myVehicleSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(AppPageNames.selectCarScreen);
                                    }),
                                /* <---- For extra 22px gap in height ----> */
                                AppGaps.hGap22,
                                DrawerMenuSvgWidget(
                                    text: 'Chat screen',
                                    localAssetIconName:
                                        AppAssetImages.myVehicleSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(
                                        AppPageNames.chatScreen,
                                      );
                                    }),
                                /* <---- For extra 22px gap in height ----> */
                                AppGaps.hGap22,
                                /* <---- setting function in the drawer menu ----> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .settingTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.settingFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(AppPageNames.settings);
                                    }),
                                /* <---- For extra 22px gap in height ----> */
                                AppGaps.hGap22,
                                /* <---- Saved location function in the drawer menu ----> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .savedLocationTransKey
                                        .toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.settingFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.savedLocationScreen);
                                    }),
                                /* <---- For extra 22px gap in height ----> */
                                AppGaps.hGap22,
                                /* <---- About us function in the drawer menu ----> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .aboutUsTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.aboutUsSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(AppPageNames.aboutUs);
                                    }),
                                /* <---- For extra 22px gap in height ----> */
                                AppGaps.hGap22,
                                /* <---- Coupon function in the drawer menu ----> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .addcouponTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.aboutUsSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(AppPageNames.addCouponScreen);
                                    }),

                                /* <---- For extra 22px gap in height ----> */
                                AppGaps.hGap22,

                                /* <---- Coupon function in the drawer menu ----> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .applycouponTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.aboutUsSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.applyCouponScreen);
                                    }),

                                /* <---- For extra 22px gap in height ----> */
                                AppGaps.hGap22,
                                /* <---- Help & Support function in the drawer menu ----> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .helpSupportTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.helpSupportSvgFillIcon,
                                    color: AppColors.primaryColor,
                                    onTap: () {
                                      Get.toNamed(AppPageNames.helpSupport);
                                    }),
                                /* <---- For extra 66px gap in height ----> */
                                AppGaps.hGap66,

                                /* <---- Logout function in the drawer menu ----> */
                                DrawerMenuSvgWidget(
                                    text: AppLanguageTranslation
                                        .logOutTransKey.toCurrentLanguage,
                                    localAssetIconName:
                                        AppAssetImages.logoutSvgFillIcon,
                                    color: AppColors.primaryTextColor,
                                    onTap: controller.onLogOutButtonTap),
                                AppGaps.hGap22,

                                // Bottom extra spaces
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ));
  }
}
