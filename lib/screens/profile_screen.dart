import 'package:car2gouser/controller/profile_screen_controller.dart';
import 'package:car2gouser/models/bottom_sheet_paramers/profile_entry_gender_bottom_sheet_parameter.dart';
import 'package:car2gouser/models/enums/gender.dart';
import 'package:car2gouser/models/enums/profile_field_name.dart';
import 'package:car2gouser/screens/bottomsheet_screen/profile_gender_bottomsheet.dart';
import 'package:car2gouser/screens/bottomsheet_screen/profile_field_bottomsheet.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:car2gouser/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size both height and width
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<MyAccountScreenController>(
        global: true,
        init: MyAccountScreenController(),
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: false,
              extendBody: true,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText: 'Profile',
                  hasBackButton: true),
              body: Container(
                height: screenHeight,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * 0.235,
                        decoration: const ShapeDecoration(
                          color: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 88),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: screenWidth,
                          // height: screenHeight * 0.85,
                          decoration: const ShapeDecoration(
                            color: AppColors.primaryButtonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomScrollView(slivers: [
                              /* <-------- 30px height gap --------> */
                              const SliverToBoxAdapter(child: VerticalGap(64)),
                              SliverToBoxAdapter(
                                child: Text('Profile Information',
                                    style: AppTextStyles
                                        .titleSemiSmallSemiboldTextStyle
                                        .copyWith(
                                      color: AppColors.primaryColor,
                                    )),
                              ),
                              const SliverToBoxAdapter(child: VerticalGap(16)),
                              /* <--------  Profile Information Field--------> */
                              SliverToBoxAdapter(
                                child: ProfileItem(
                                  title: "Full Name",
                                  value: controller.profileDetails.name,
                                  onTap: () async {
                                    final result = await Get.bottomSheet(
                                        const EditProfileFieldBottomSheet(),
                                        isScrollControlled: true,
                                        settings: RouteSettings(
                                            arguments:
                                                ProfileEntryTextFieldBottomSheetParameter(
                                                    profileFieldName:
                                                        ProfileFieldName.name,
                                                    initialValue: controller
                                                        .profileDetails.name)));
                                    if (result is bool) {
                                      // controller.nameController.text = result;
                                      controller.update();
                                    }
                                  },
                                ),
                              ),
                              const SliverToBoxAdapter(child: VerticalGap(16)),
                              SliverToBoxAdapter(
                                child: ProfileItem(
                                    title: "Email Address",
                                    value: controller.profileDetails.email,
                                    onTap: controller.onEmailAddressTap),
                              ),
                              const SliverToBoxAdapter(child: VerticalGap(16)),
                              SliverToBoxAdapter(
                                child: ProfileItem(
                                    title: "Phone Number",
                                    value: controller.profileDetails.phone,
                                    onTap: controller.onPhoneNumberTap),
                              ),
                              const SliverToBoxAdapter(child: VerticalGap(16)),
                              SliverToBoxAdapter(
                                child: ProfileItem(
                                    title: "Gender",
                                    value: controller
                                                .profileDetails.genderAsEnum ==
                                            Gender.unknown
                                        ? 'Not set'
                                        : controller
                                            .profileDetails
                                            .genderAsEnum
                                            .viewableTextTransKey
                                            .toCurrentLanguage,
                                    onTap: () async {
                                      final result = await Get.bottomSheet(
                                          isScrollControlled: true,
                                          const EditProfileGenderBottomsheet(),
                                          settings: RouteSettings(
                                              arguments:
                                                  ProfileEntryGenderBottomSheetParameter(
                                            profileGenderName: controller
                                                .profileDetails.genderAsEnum,
                                          )));
                                      if (result is String) {
                                        // controller.genderController.text = result;
                                        controller.update();
                                      }
                                    }),
                              ),
                              const SliverToBoxAdapter(child: VerticalGap(16)),
                              SliverToBoxAdapter(
                                child: ProfileItem(
                                    title: "Address",
                                    value: controller.profileDetails.address,
                                    onTap: () async {
                                      final result = await Get.bottomSheet(
                                          isScrollControlled: true,
                                          const EditProfileFieldBottomSheet(),
                                          settings: RouteSettings(
                                              arguments:
                                                  ProfileEntryTextFieldBottomSheetParameter(
                                                      initialValue: controller
                                                          .profileDetails
                                                          .address,
                                                      profileFieldName:
                                                          ProfileFieldName
                                                              .address)));
                                      if (result is String) {
                                        // controller.genderController.text = result;
                                        controller.update();
                                      }
                                    }),
                              ),
                              const SliverToBoxAdapter(child: VerticalGap(30)),
                            ]),
                          ),
                        ),
                      ),
                    )),
                    Positioned(
                        top: 20,
                        child: Container(
                            height: 120,
                            width: 120,
                            decoration: const ShapeDecoration(
                              shape: CircleBorder(),
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (controller.selectedProfileImage !=
                                        null) {
                                      Get.toNamed(AppPageNames.imageZoomScreen,
                                          arguments:
                                              controller.selectedProfileImage);
                                    }
                                  },
                                  child: controller.isImageUpdating
                                      ? const Center(
                                          child: SizedBox.square(
                                              dimension: 50,
                                              child:
                                                  CircularProgressIndicator()))
                                      : MixedImageWidget(
                                          imageData:
                                              controller.selectedProfileImage,
                                          imageBuilder: (context,
                                                  imageProvider) =>
                                              Container(
                                                height: 128,
                                                width: 128,
                                                decoration: ShapeDecoration(
                                                    shape: const CircleBorder(),
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: imageProvider)),
                                              )),
                                ),
/*                                 controller.imageEdit
                                    ? Container(
                                        height: 128,
                                        width: 128,
                                        decoration: ShapeDecoration(
                                            shape: const CircleBorder(),
                                            color: Colors.white,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.memory(
                                                  controller
                                                      .selectedProfileImage,
                                                ).image)),
                                      )
                                    : CachedNetworkImageWidget(
                                        imageURL: controller.userDetails.image,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.center,
                                          decoration: ShapeDecoration(
                                              shape: CircleBorder(),
                                              color: Colors.white,
                                              image: DecorationImage(
                                                image: imageProvider,
                                              )),
                                        ),
                                      ), */

                                /* <---- Camera icon for uploading the profile image ----> */
                                Positioned(
                                    bottom: -2,
                                    left: 0,
                                    right: 0,
                                    child: IconButton(
                                      onPressed:
                                          controller.onEditImageButtonTap,
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                          minHeight: 34, minWidth: 34),
                                      icon: Container(
                                          height: 34,
                                          width: 34,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.primaryColor,
                                              border: Border.all(
                                                  color: Colors.white)),
                                          child: Image.asset(AppAssetImages
                                              .cameraButtonImage)),
                                    ))
                              ],
                            ))),
                  ],
                ),
              ),
            ));
  }
}
