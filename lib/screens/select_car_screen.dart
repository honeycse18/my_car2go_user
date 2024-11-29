import 'package:bottom_picker/bottom_picker.dart';
import 'package:car2gouser/controller/select_car_screen_controller.dart';
import 'package:car2gouser/models/api_responses/nearest_cars_list_response.dart';
import 'package:car2gouser/screens/bottomsheet_screen/coupon_bottomsheet.dart';
import 'package:car2gouser/screens/bottomsheet_screen/payment_bottomsheet.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/double.dart';
import 'package:car2gouser/utils/extensions/list_of_string.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:car2gouser/widgets/screen_widget/car_item.dart';
import 'package:car2gouser/widgets/select_car_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SelectCarScreen extends StatelessWidget {
  const SelectCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<SelectCarScreenController>(
        init: SelectCarScreenController(),
        global: false,
        builder: ((controller) => PopScope(
              onPopInvoked: (isPopped) async {
                controller.onClose();
              },
              child: CustomScaffold(
                  extendBodyBehindAppBar: true,
                  extendBody: false,
                  /* <-------- AppBar --------> */
                  appBar: CoreWidgets.appBarWidget(
                      screenContext: context,
                      titleText: AppLanguageTranslation
                          .selectCarTransKey.toCurrentLanguage,
                      hasBackButton: true),
                  /* <-------- Body Content --------> */
                  /*  body: Stack(children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      /* <-------- Initialize google map--------> */
                      child: GoogleMap(
                        mapType: MapType.normal,
                        mapToolbarEnabled: false,
                        zoomControlsEnabled: false,
                        myLocationEnabled: false,
                        compassEnabled: true,
                        zoomGesturesEnabled: true,
                        initialCameraPosition:
                            // AppSingleton.instance.defaultCameraPosition,
                            CameraPosition(
                                target: LatLng(
                                    (controller.cameraPosition.latitude) - 7.7,
                                    controller.cameraPosition.longitude),
                                zoom: controller.zoomLevel),
                        markers: controller.googleMapMarkers,
                        polylines: controller.googleMapPolyLines,
                        onMapCreated: controller.onGoogleMapCreated,
                        // onTap: controller.onGoogleMapTap,
                      ),
                    ),
                  ),
                  SlidingUpPanel(
                        defaultPanelState: PanelState.OPEN,
                      color: Colors.transparent,
                      boxShadow: null,
                      minHeight: screenHeight * 0.3,
                      maxHeight: screenHeight * 0.8,
                      panel: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(right: 20),
                          decoration: const BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(40),
                            ),
                          ),
                          child: Column(
                            children: [
                              AppGaps.hGap10,
                              Container(
                                width: 60,
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 3,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Color(0xFFA5A5A5),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: ScaffoldBodyWidget(
                                  child: CustomScrollView(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    slivers: [
                                      const SliverToBoxAdapter(
                                        child: AppGaps.hGap8,
                                      ),
                                      SliverToBoxAdapter(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                // padding: const EdgeInsets.fromLTRB(23, 19, 12, 19),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 23),
                                                height: 60,
                                                width: 366,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    18),
                                                            topRight:
                                                                Radius.circular(
                                                                    18)),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .fromBorderColor)),
                                                child: Row(
                                                  children: [
                                                    const SvgPictureAssetWidget(
                                                        AppAssetImages
                                                            .dropLocationSVGLogoLine),
                                                    AppGaps.wGap8,
                                                    Expanded(
                                                      child: Text(
                                                        controller
                                                                .pickupLocation
                                                                ?.address ??
                                                            '',
                                                        maxLines: 2,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SliverToBoxAdapter(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 60,
                                                width: 366,
                                                // padding: const EdgeInsets.fromLTRB(23, 19, 12, 19),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 23),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    18),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    18)),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .fromBorderColor)),
                                                child: Row(
                                                  children: [
                                                    const SvgPictureAssetWidget(
                                                        AppAssetImages
                                                            .solidLocationSVGLogoLine),
                                                    AppGaps.wGap8,
                                                    Expanded(
                                                        child: Text(
                                                      controller.dropLocation
                                                              ?.address ??
                                                          '',
                                                      maxLines: 2,
                                                    )),
                                                    TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                          AppLanguageTranslation
                                                              .editTransKey
                                                              .toCurrentLanguage,
                                                          style: AppTextStyles
                                                              .bodyTextStyle,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (controller.isScheduleRide)
                                        const SliverToBoxAdapter(
                                            child: AppGaps.hGap16),
                                      if (controller.isScheduleRide)
                                        SliverToBoxAdapter(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLanguageTranslation
                                                    .selectTimeDateTransKey
                                                    .toCurrentLanguage,
                                                style: AppTextStyles
                                                    .titleSemiSmallBoldTextStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (controller.isScheduleRide)
                                        const SliverToBoxAdapter(
                                            child: AppGaps.hGap16),
                                      if (controller.isScheduleRide)
                                        SliverToBoxAdapter(
                                          child: CustomTextFormField(
                                            hintText: 'Start Date & Time',
                                            isReadOnly: true,
                                            controller: TextEditingController(
                                              text:
                                                  '${DateFormat('dd/MM/yyyy').format(controller.selectedBookingDate.value)}      ${controller.selectedBookingTime.value.hourOfPeriod} : ${controller.selectedBookingTime.value.minute} ${controller.selectedBookingTime.value.period.name}',
                                            ),
                                            prefixIcon:
                                                const SvgPictureAssetWidget(
                                                    AppAssetImages.calendar),
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(
                                                    DateTime.now().year + 100),
                                              );
                                              if (pickedDate != null) {
                                                controller
                                                    .updateSelectedStartDate(
                                                        pickedDate);
                                              }

                                              final TimeOfDay? pickedTime =
                                                  // ignore: use_build_context_synchronously
                                                  await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                              if (pickedTime != null) {
                                                controller
                                                    .updateSelectedStartTime(
                                                        pickedTime);
                                              }

                                              controller.update();
                                            },
                                          ),
                                        ),
                                      const SliverToBoxAdapter(
                                          child: AppGaps.hGap16),
                                      SliverToBoxAdapter(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLanguageTranslation
                                                  .nearestToYouTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .titleSemiSmallBoldTextStyle,
                                            ),
                                            GestureDetector(
                                                onTap: controller
                                                    .onResetListButtonTap,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 12),
                                                  child: Text(
                                                    AppLanguageTranslation
                                                        .resetListTransKey
                                                        .toCurrentLanguage,
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .primaryColor),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                      const SliverToBoxAdapter(
                                          child: AppGaps.hGap16),
                                      SliverList.separated(
                                          itemBuilder: (context, index) {
                                            NearestCarsListRide ride =
                                                controller.rides[index];
                                            return SelectCarWidget(
                                                symbol: ride.currency,
                                                onTap: () =>
                                                    controller.onRideTap(ride),
                                                isSelected: ride ==
                                                    controller.selectedRide,
                                                vehicleCategory:
                                                    ride.category.name,
                                                color: ride.color,
                                                seat: ride.capacity,
                                                carImage:
                                                    ride.images.firstOrNull ??
                                                        '',
                                                amount: ride.total,
                                                transportName: ride.model,
                                                distanceInTime: ride.time.text);
                                          },
                                          separatorBuilder: (context, index) =>
                                              AppGaps.hGap16,
                                          itemCount: controller.rides.length),
                                      const SliverToBoxAdapter(
                                          child: AppGaps.hGap16),
                                      SliverToBoxAdapter(
                                        child: Text(
                                          AppLanguageTranslation
                                              .choseAsYouLikeTransKey
                                              .toCurrentLanguage,
                                          style: AppTextStyles
                                              .titleSemiSmallBoldTextStyle,
                                        ),
                                      ),
                                      const SliverToBoxAdapter(
                                          child: AppGaps.hGap16),
                                      SliverList.separated(
                                          itemBuilder: (context, index) {
                                            NearestCarsListCategory category =
                                                controller.categories[index];
                                            return SelectCarCategoryPagesWidget(
                                              onTap: () => controller
                                                  .onCategoryClick(category.id),
                                              tagline: AppLanguageTranslation
                                                  .yourRideOurServiceTransKey
                                                  .toCurrentLanguage,
                                              transportName: category.name,
                                              image: category.image,
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              AppGaps.hGap16,
                                          itemCount:
                                              controller.categories.length),
                                      const SliverToBoxAdapter(
                                          child: AppGaps.hGap75)
                                    ],
                                  ),
                                ),
                              )),
                            ],
                          )))
                ]),
                /* <-------- Bottom Bar--------> */
                 */

                  body: Stack(
                    children: [
                      Positioned.fill(
                        bottom: screenHeight * 0.27,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                          child: GoogleMap(
                            mapType: MapType.normal,
                            mapToolbarEnabled: false,
                            zoomControlsEnabled: false,
                            myLocationEnabled: false,
                            compassEnabled: true,
                            zoomGesturesEnabled: true,
                            initialCameraPosition:
                                // AppSingleton.instance.defaultCameraPosition,
                                CameraPosition(
                                    target: LatLng(
                                        (controller.cameraPosition.latitude) -
                                            7.7,
                                        controller.cameraPosition.longitude),
                                    zoom: controller.zoomLevel),
                            markers: controller.googleMapMarkers,
                            polylines: controller.googleMapPolyLines,
                            onMapCreated: controller.onGoogleMapCreated,
                          ),
                        ),
                      ),
                      /* Obx(
                        () => controller.rideAccepted.value
                            ?  */
                      SlidingUpPanel(
                        defaultPanelState: PanelState.OPEN,
                        color: Colors.transparent,
                        boxShadow: null,
                        minHeight: MediaQuery.of(context).size.height * 0.3,
                        maxHeight: MediaQuery.of(context).size.height * 0.60,
                        panelBuilder: (sc) => Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.topLeft,
                          decoration: const BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(40),
                            ),
                          ),
                          child: Column(
                            children: [
                              AppGaps.hGap10,
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 9),
                                  child: ScaffoldBodyWidget(
                                    child: CustomScrollView(
                                      controller: sc,
                                      slivers: [
                                        if (!controller.isScheduleRide)
                                          ..._nearbyVehiclesForRideNowWidgets(
                                              context, controller),
                                        if (controller.isScheduleRide)
                                          ..._nearbyVehicleListForScheduleWidget(
                                              context, controller),
                                        const SliverToBoxAdapter(
                                            child: VerticalGap(30)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      // ),
                    ],
                  ),
                  bottomNavigationBar: Container(
                    height: 136,
                    child: PhysicalModel(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.white,
                      elevation: 18,
                      shadowColor: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 12, right: 16, bottom: 12),
                        child: Column(
                          children: [
                            Row(children: [
                              RawButtonWidget(
                                onTap: () {
                                  Get.bottomSheet(PaymentBottomsheet());
                                },
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Payment method',
                                          style: AppTextStyles
                                              .bodySmallTextStyle
                                              .copyWith(
                                                  color:
                                                      AppColors.bodyTextColor),
                                        ),
                                        AppGaps.hGap4,
                                        Text(
                                          'Cash',
                                          style: AppTextStyles
                                              .bodyLargeSemiboldTextStyle
                                              .copyWith(
                                                  color:
                                                      AppColors.primaryColor),
                                        ),
                                      ],
                                    ),
                                    AppGaps.wGap20,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            AppGaps.hGap20,
                                            SvgPicture.asset(AppAssetImages
                                                .arrowRightSVGLogoLine),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              AppGaps.wGap40,
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Container(
                                  height: 20,
                                  width: 1,
                                  color: AppColors.separatorColor,
                                ),
                              ),
                              AppGaps.wGap30,
                              RawButtonWidget(
                                onTap: () {
                                  Get.toNamed(AppPageNames.useCouponScreen);
                                },
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Coupon',
                                          style: AppTextStyles
                                              .bodySmallTextStyle
                                              .copyWith(
                                                  color:
                                                      AppColors.bodyTextColor),
                                        ),
                                        AppGaps.hGap4,
                                        Text(
                                          'Apply Code',
                                          style: AppTextStyles
                                              .bodyLargeSemiboldTextStyle
                                              .copyWith(
                                                  color:
                                                      AppColors.primaryColor),
                                        ),
                                      ],
                                    ),
                                    AppGaps.wGap10,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        AppGaps.wGap55,
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            AppGaps.hGap20,
                                            SvgPicture.asset(AppAssetImages
                                                .arrowRightSVGLogoLine),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            AppGaps.hGap10,
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomStretchedButtonWidget(
                                  onTap: controller.onRideNowButtonTap,
                                  onLongPress: () {
                                    // TODO: Fake data implementation
                                  },
                                  child: Text(controller.isScheduleRide
                                      ? 'Ride Now'
                                      : 'Schedule Ride'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            )));
  }

  List<Widget> _nearbyVehiclesForRideNowWidgets(
          BuildContext context, SelectCarScreenController controller) =>
      [
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nearby vehicle',
                style: AppTextStyles.titlesemiSmallMediumTextStyle,
              ),
              GestureDetector(
                onTap: () {
                  controller.openDateTimePicker(context);
                  controller.isScheduleRide = true;
                },
                child: Container(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppAssetImages.calender1SVGLogoLine),
                        AppGaps.wGap5,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: controller.selectedDateTime, // Date part
                                style:
                                    AppTextStyles.bodySmallTextStyle.copyWith(
                                  color: Colors.grey, // Date color
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppGaps.wGap8,
                        SvgPicture.asset(AppAssetImages.arrowDownSVGLogoLine),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

/*         SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose as your need',
                style: AppTextStyles.titlesemiSmallMediumTextStyle,
              ),
              GestureDetector(
                onTap: () {
                  controller.openDateTimePicker(context);
                  controller.isScheduleRide = true;
                },
                child: Container(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppAssetImages.calender1SVGLogoLine),
                        AppGaps.wGap5,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: controller.selectedDateTime
                                    .split('\n')[0], // Time part
                                style:
                                    AppTextStyles.bodyMediumTextStyle.copyWith(
                                  color: Colors.black, // Time color
                                ),
                              ),
                              TextSpan(
                                text: '\n', // Newline
                              ),
                              TextSpan(
                                text: controller.selectedDateTime, // Date part
                                style:
                                    AppTextStyles.bodySmallTextStyle.copyWith(
                                  color: Colors.grey, // Date color
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppGaps.wGap8,
                        SvgPicture.asset(AppAssetImages.arrowDownSVGLogoLine),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ), */
        const SliverToBoxAdapter(child: AppGaps.hGap16),
        SliverList.separated(
          itemBuilder: (context, index) {
            final nearbyVehicle = controller.rides[index];
            return CarItem(
              distance:
                  nearbyVehicle.driverDistanceFromPickupPoint.distance.text,
              time: nearbyVehicle.driverDistanceFromPickupPoint.duration.text,
              amount: nearbyVehicle.estimatedFare.total,
              imageURL: nearbyVehicle.images.safeFirst(),
              seat: nearbyVehicle.seat,
              vehicleCategory: '${nearbyVehicle.brand} ${nearbyVehicle.model}',
              isSelected: controller.selectedRide?.id == nearbyVehicle.id,
              onTap: () => controller.onRideTap(nearbyVehicle),
            );
          },
          separatorBuilder: (context, index) => AppGaps.hGap16,
          itemCount: controller.rides.length,
        ),
        SliverToBoxAdapter(child: AppGaps.hGap75),
        SliverToBoxAdapter(
          child: Text(
            'Choose as your need',
            style: AppTextStyles.titlesemiSmallMediumTextStyle,
          ),
        ),
        SliverList.separated(
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            return SelectCarCategoryPagesWidget(
              onTap: () => controller.onCategoryClick(category),
              isSelected: controller.selectedCategory?.id == category.id,
              seat: 4,
              transportName: category.brand,
              image: category.images.safeFirst(),
              realPrice: 100,
              discountPrice: 80,
            );
          },
          separatorBuilder: (context, index) => AppGaps.hGap16,
          itemCount: controller.categories.length,
        ),
        const SliverToBoxAdapter(child: AppGaps.hGap16),
      ];

  List<Widget> _nearbyVehicleListForScheduleWidget(
          BuildContext context, SelectCarScreenController controller) =>
      [
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLanguageTranslation.nearbyVehicleTransKey.toCurrentLanguage,
                style: AppTextStyles.titlesemiSmallMediumTextStyle,
              ),
              GestureDetector(
                onTap: () {
                  controller.openDateTimePicker(context);
                  controller.isScheduleRide = false;
                },
                child: Container(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppAssetImages.calender1SVGLogoLine),
                        AppGaps.wGap5,
                        Text(
                          'Now',
                          style: AppTextStyles.bodyMediumTextStyle,
                        ),
                        AppGaps.wGap8,
                        SvgPicture.asset(AppAssetImages.arrowDownSVGLogoLine),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(child: AppGaps.hGap16),
        SliverToBoxAdapter(
          child: CarItem(
            distance: '800m',
            time: '5mins away',
            amount: 80,
            imageURL: AppAssetImages.carDarkLogoSolid,
            seat: 4,
            vehicleCategory: 'Premium',
            isSelected: true,
          ),
        ),
        SliverToBoxAdapter(child: AppGaps.hGap16),
        SliverToBoxAdapter(
          child: Text(
            'Choose as your need',
            style: AppTextStyles.titlesemiSmallMediumTextStyle,
          ),
        ),
        SliverToBoxAdapter(child: AppGaps.hGap16),
        SliverList.separated(
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            return SelectCarCategoryPagesWidget(
              onTap: () => controller.onCategoryClick(category),
              isSelected: controller.selectedCategory?.id == category.id,
              seat: 4,
              transportName: category.brand,
              image: category.images.safeFirst(),
              realPrice: 100,
              discountPrice: 80,
            );
          },
          separatorBuilder: (context, index) => AppGaps.hGap16,
          itemCount: controller.categories.length,
        ),
        SliverToBoxAdapter(child: AppGaps.hGap75),
        const SliverToBoxAdapter(child: AppGaps.hGap16),
      ];
}
