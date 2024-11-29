import 'package:car2gouser/controller/car_pooling/request_ride_bottomsheet_controller.dart';
import 'package:car2gouser/models/api_responses/carpolling/all_categories_response.dart';
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

class RequestRideBottomsheet extends StatelessWidget {
  const RequestRideBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestRideBottomSheetScreenController>(
        init: RequestRideBottomSheetScreenController(),
        builder: (controller) => Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
              decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RawButtonWidget(
                          borderRadiusValue: 14,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            child: const Center(
                              child: SvgPictureAssetWidget(
                                AppAssetImages.arrowLeftSVGLogoLine,
                                color: AppColors.primaryTextColor,
                                height: 18,
                                width: 18,
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.back();
                          },
                        ),
                        Text(
                          AppLanguageTranslation
                              .requestRideTranskey.toCurrentLanguage,
                          style: AppTextStyles.titleBoldTextStyle,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          height: 40,
                          width: 40,
                        ),
                      ],
                    ),
                    AppGaps.hGap10,
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLanguageTranslation
                                .requestRideTranskey.toCurrentLanguage,
                            style: AppTextStyles.labelTextStyle,
                          ),
                          AppGaps.hGap8,
                          /*<------- Pickup Location Field ------>*/
                          LocationPickUpTextFormField(
                            isReadOnly: true,
                            hintText: controller.requestDetails.from.address,
                            prefixIcon: const SvgPictureAssetWidget(
                                AppAssetImages.currentLocationSVGLogoLine),
                          ),
                          /*<------- Pickdown Location Field ------>*/
                          LocationPickDownTextFormField(
                            isReadOnly: true,
                            hintText: controller.requestDetails.to.address,
                            prefixIcon: const SvgPictureAssetWidget(
                                AppAssetImages.solidLocationSVGLogoLine),
                          ),
                          AppGaps.hGap24,
                          Text(
                            AppLanguageTranslation
                                .selectSeatTranskey.toCurrentLanguage,
                            style: AppTextStyles.bodyLargeSemiboldTextStyle,
                          ),
                          /* <---- for extra 8px gap in height ----> */
                          AppGaps.hGap8,
                          Obx(() => Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 62,
                                      width: 179,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      child: Row(
                                        children: [
                                          const SvgPictureAssetWidget(
                                            AppAssetImages
                                                .multiplePeopleSVGLogoLine,
                                            height: 18,
                                            width: 18,
                                          ),
                                          AppGaps.wGap16,
                                          /*<------- Number of seat selection  ------>*/
                                          Expanded(
                                            child: PlusMinusCounterRow(
                                                isDecrement: controller.seat > 1
                                                    ? true
                                                    : false,
                                                onRemoveTap:
                                                    controller.onSeatRemoveTap,
                                                counterText: controller
                                                    .seat.value
                                                    .toString(),
                                                onAddTap:
                                                    controller.onSeatAddTap),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          AppGaps.hGap24,
                          Text(
                            AppLanguageTranslation
                                .budgetPerSeatTranskey.toCurrentLanguage,
                            style: AppTextStyles.bodyLargeSemiboldTextStyle,
                          ),
                          AppGaps.hGap8,
                          /*<------- Rate per seat selection ------>*/
                          Obx(() => Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 62,
                                      width: 179,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      child: PlusMinusCounterRow(
                                          isDecrement: controller.rate.value > 1
                                              ? true
                                              : false,
                                          onRemoveTap:
                                              controller.onRateRemoveTap,
                                          counterText:
                                              controller.rate.value.toString(),
                                          onAddTap: controller.onRateAddTap),
                                    ),
                                  ),
                                ],
                              )),
                          if (controller.type) AppGaps.hGap16,
                          if (controller.type)
                            /*<------- Time & Date  ------>*/
                            CustomTextFormField(
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
                                  controller
                                      .updateSelectedStartDate(pickedDate);
                                }

                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  controller
                                      .updateSelectedStartTime(pickedTime);
                                }

                                controller.update();
                              },
                            ),
                          if (controller.type) AppGaps.hGap16,
                          if (controller.type)
                            /*<-------Select vehicle category  ------>*/
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
                          if (controller.type) AppGaps.hGap16,
                          if (controller.type)
                            CustomTextFormField(
                              controller: controller.vehicleNumberController,
                              hintText: 'Vehicle Number',
                            ),
                          AppGaps.hGap21,
                          AppGaps.hGap32,
                          /*<-------  Request Ride Button------>*/
                          CustomStretchedButtonWidget(
                            onTap: controller.requestRide,
                            child: Text(
                              AppLanguageTranslation
                                  .requestRideTranskey.toCurrentLanguage,
                            ),
                          ),
                          AppGaps.hGap20,
                        ],
                      ),
                    ))
                  ]),
            ));
  }
}
