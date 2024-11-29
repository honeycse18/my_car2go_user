import 'package:car2gouser/controller/car_pooling/ride_share_screen_controller.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RideShareScreen extends StatelessWidget {
  const RideShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideShareScreenController>(
        init: RideShareScreenController(),
        global: false,
        builder: ((controller) => CustomScaffold(
              /*<------- AppBar ------>*/
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText: AppLanguageTranslation
                      .carPoolingTranskey.toCurrentLanguage),
              /*<-------Body Content  ------>*/
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    AppGaps.hGap24,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: AppColors.fromBorderColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  /*<------- Find pool tab ------>*/
                                  Expanded(
                                    child: controller.shareRideTabWidget(
                                      isSelected: controller.isFindSelected,
                                      title: AppLanguageTranslation
                                          .findPoolTranskey.toCurrentLanguage,
                                      onTap: () {
                                        if (!controller.isFindSelected) {
                                          controller.isFindSelected =
                                              !controller.isFindSelected;
                                          controller.update();
                                        }
                                      },
                                    ),
                                  ),
                                  /*<------- Offer pool tab ------>*/
                                  Expanded(
                                    child: controller.shareRideTabWidget(
                                      isSelected: !controller.isFindSelected,
                                      title: AppLanguageTranslation
                                          .offerPoolTranskey.toCurrentLanguage,
                                      onTap: () {
                                        if (controller.isFindSelected) {
                                          controller.isFindSelected =
                                              !controller.isFindSelected;
                                          controller.update();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppGaps.hGap24,

                            /*<------- Pickup & drop location picker widget------>*/
                            PickupAndDropLocationPickerWidget(
                              pickUpText:
                                  controller.pickUpLocation?.address ?? '',
                              dropText: controller.dropLocation?.address ?? '',
                              onPickUpTap: controller.onPickUpTap,
                              onDropTap: controller.onDropTap,
                            ),
                            if (controller.isFindSelected) AppGaps.hGap24,
                            if (controller.isFindSelected)
                              CustomTextFormField(
                                labelText: AppLanguageTranslation
                                    .selectDateTranskey.toCurrentLanguage,
                                hintText: 'Start Date',
                                isReadOnly: true,
                                controller: TextEditingController(
                                    text: DateFormat('yyyy-MM-dd').format(
                                        controller.selectedStartDate.value)),
                                prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.calendar),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate:
                                        DateTime(DateTime.now().year + 100),
                                  );
                                  if (pickedDate != null) {
                                    controller
                                        .updateSelectedStartDate(pickedDate);
                                  }

                                  controller.update();
                                },
                              ),
                            /* <---- for extra 24px gap in height ----> */
                            AppGaps.hGap24,
                            if (controller.isFindSelected)
                              Text(
                                AppLanguageTranslation
                                    .selectSeatTranskey.toCurrentLanguage,
                                style: AppTextStyles.labelTextStyle,
                              ),
                            if (controller.isFindSelected) AppGaps.hGap8,
                            if (controller.isFindSelected)
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.fromBorderColor,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    const SvgPictureAssetWidget(AppAssetImages
                                        .multiplePeopleSVGLogoLine),
                                    AppGaps.wGap16,
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (controller.seatSelected > 1) {
                                                controller.seatSelected -= 1;
                                                controller.update();
                                              }
                                            },
                                            child: Container(
                                              height: 32,
                                              width: 32,
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.fromBorderColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: const Center(
                                                child: Text("-",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .bodyTextColor)),
                                              ),
                                            ),
                                          ),
                                          /* <---- Available seat for passengers ----> */
                                          Text(
                                              controller.seatSelected > 0
                                                  ? '${controller.seatSelected.toString()} ${AppLanguageTranslation.seatTransKey.toCurrentLanguage}${controller.seatSelected > 1 ? "s" : ""}'
                                                  : AppLanguageTranslation
                                                      .seatAvailableTranskey
                                                      .toCurrentLanguage,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      AppColors.bodyTextColor)),
                                          GestureDetector(
                                            onTap: () {
                                              if (controller.seatSelected <
                                                  15) {
                                                controller.seatSelected += 1;
                                                controller.update();
                                              }
                                            },
                                            child: Container(
                                              height: 32,
                                              width: 32,
                                              decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: const Center(
                                                child: Text("+",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /*<-------Bottom Bar  ------>*/
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 10.0),
                    child: controller.isFindSelected
                        ? Row(
                            children: [
                              /*<-------  Find Ride Button------>*/
                              Expanded(
                                  child: CustomStretchedOutlinedButtonWidget(
                                onTap: controller.onFindRideButtonTap,
                                child: Text(
                                  AppLanguageTranslation
                                      .findRideTranskey.toCurrentLanguage,
                                  style: AppTextStyles
                                      .bodyLargeSemiboldTextStyle
                                      .copyWith(
                                          color: AppColors.primaryTextColor),
                                ),
                              )),
                              AppGaps.wGap16,
                              /*<------- Find Passenger Button ------>*/
                              Expanded(
                                  child: StretchedTextButtonWidget(
                                buttonText: AppLanguageTranslation
                                    .findPassengersTranskey.toCurrentLanguage,
                                onTap: controller.onFindPassengersButtonTap,
                              )),
                            ],
                          ) /*<------- Next Button ------>*/
                        : StretchedTextButtonWidget(
                            buttonText: AppLanguageTranslation
                                .nextTransKey.toCurrentLanguage,
                            onTap: controller.onNextButtonTap,
                          ),
                  ),
                  AppGaps.hGap10
                ],
              ),
            )));
  }
}
