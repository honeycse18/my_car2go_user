import 'package:car2gouser/controller/car_pooling/offer_ride_bottom_sheet_controller.dart';
import 'package:car2gouser/models/api_responses/carpolling/all_categories_response.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OfferRideBottomSheet extends StatelessWidget {
  const OfferRideBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfferRideBottomSheetController>(
        init: OfferRideBottomSheetController(),
        builder: (controller) => ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: Container(
                height: controller.offerRideBottomSheetParameters.isCreateOffer
                    ? 760
                    : 590,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TightIconButtonWidget(
                            onTap: () {
                              Get.back();
                            },
                            icon: const SizedBox(
                              height: 40,
                              width: 40,
                              child: Center(
                                  child: SvgPictureAssetWidget(
                                AppAssetImages.backButtonSVGLogoLine,
                                color: AppColors.primaryTextColor,
                              )),
                            ),
                          ),
                          /*<-------Selection to create or offer a ride  ------>*/
                          Expanded(
                            child: Center(
                                child: Text(
                              controller.offerRideBottomSheetParameters
                                      .isCreateOffer
                                  ? AppLanguageTranslation
                                      .createARideTransKey.toCurrentLanguage
                                  : AppLanguageTranslation
                                      .offerARideTransKey.toCurrentLanguage,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryTextColor),
                            )),
                          )
                        ],
                      ),
                      AppGaps.hGap24,
                      /*<-------Pickup or drop location picker  ------>*/
                      PickupAndDropLocationPickerWidget(
                          pickUpText: controller.offerRideBottomSheetParameters
                              .pickUpLocation.address,
                          dropText: controller.offerRideBottomSheetParameters
                              .dropLocation.address),
                      AppGaps.hGap16,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 24),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: [
                            const SvgPictureAssetWidget(
                                AppAssetImages.multiplePeopleSVGLogoLine),
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
                                          color: AppColors.fromBorderColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Center(
                                        child: Text("-",
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColors.bodyTextColor)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                      controller.seatSelected > 0
                                          ? '${controller.seatSelected.toString()} seat${controller.seatSelected > 1 ? "s" : ""}'
                                          : controller
                                                  .offerRideBottomSheetParameters
                                                  .isCreateOffer
                                              ? AppLanguageTranslation
                                                  .seatAvailableTranskey
                                                  .toCurrentLanguage
                                              : AppLanguageTranslation
                                                  .seatNeedTranskey
                                                  .toCurrentLanguage,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.bodyTextColor)),
                                  GestureDetector(
                                    onTap: () {
                                      if (controller.seatSelected < 15) {
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
                                                fontWeight: FontWeight.bold,
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
                      AppGaps.hGap16,
                      CustomTextFormField(
                        labelText: controller
                                .offerRideBottomSheetParameters.isCreateOffer
                            ? AppLanguageTranslation
                                .perSeatPriceTranskey.toCurrentLanguage
                            : AppLanguageTranslation
                                .budgetPerSeatTranskey.toCurrentLanguage,
                        hintText: controller
                                .offerRideBottomSheetParameters.isCreateOffer
                            ? AppLanguageTranslation
                                .perSeatPriceTranskey.toCurrentLanguage
                            : AppLanguageTranslation
                                .budgetPerSeatTranskey.toCurrentLanguage,
                        textInputType: TextInputType.number,
                        controller: controller.seatPriceController,
                        prefixIcon: const SvgPictureAssetWidget(
                            AppAssetImages.calendar),
                      ),
                      AppGaps.hGap16,
                      CustomTextFormField(
                        labelText: AppLanguageTranslation
                            .selectDateTimeTranskey.toCurrentLanguage,
                        hintText: 'Start Date',
                        isReadOnly: true,
                        controller: TextEditingController(
                          text:
                              '${DateFormat('yyyy-MM-dd').format(controller.selectedDate.value)}      ${controller.selectedTime.value.hourOfPeriod} : ${controller.selectedTime.value.minute} ${controller.selectedTime.value.period.name}',
                        ),
                        prefixIcon: const SvgPictureAssetWidget(
                            AppAssetImages.calendar),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 100),
                          );
                          if (pickedDate != null) {
                            controller.updateSelectedStartDate(pickedDate);
                          }

                          final TimeOfDay? pickedTime = await showTimePicker(
                            // ignore: use_build_context_synchronously
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            controller.updateSelectedStartTime(pickedTime);
                          }

                          controller.update();
                        },
                      ),
                      if (controller
                          .offerRideBottomSheetParameters.isCreateOffer)
                        AppGaps.hGap16,
                      if (controller
                          .offerRideBottomSheetParameters.isCreateOffer)
                        DropdownButtonFormFieldWidget<AllCategoriesDoc>(
                            hintText: 'Select Category',
                            items: controller.categories,
                            getItemText: (p0) {
                              return p0.name;
                            },
                            onChanged: (value) {
                              controller.selectedCategory = value;
                              controller.update();
                            }),
                      if (controller
                          .offerRideBottomSheetParameters.isCreateOffer)
                        AppGaps.hGap16,
                      if (controller
                          .offerRideBottomSheetParameters.isCreateOffer)
                        CustomTextFormField(
                          controller: controller.vehicleNumberController,
                          hintText: 'Vehicle Number',
                        ),
                      AppGaps.hGap21,
                      StretchedTextButtonWidget(
                          onTap: controller.onSubmitButtonTap,
                          buttonText: AppLanguageTranslation
                              .submitTranskey.toCurrentLanguage)
                    ],
                  ),
                ),
              ),
            ));
  }
}
