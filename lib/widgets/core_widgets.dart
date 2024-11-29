import 'dart:async';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:car2gouser/models/location_model.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets/autocomplete.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';

/*<------- ExpansionTile widget ------>*/
class ExpansionTileWidget extends StatelessWidget {
  final Widget titleWidget;
  final List<Widget> children;

  const ExpansionTileWidget({
    Key? key,
    required this.titleWidget,
    required this.children,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.bodyTextColor),
            borderRadius: BorderRadius.circular(10)),
        child: ExpansionTile(
          title: titleWidget,
          children: children,
        ));
  }
}

/*<------- Custom padded body widget for scaffold ------>*/
class CustomScaffoldBodyWidget extends StatelessWidget {
  final Widget child;
  const CustomScaffoldBodyWidget({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppGaps.screenPaddingValue),
      child: child,
    );
  }
}

class ScaffoldBodyWidget extends StatelessWidget {
  final Widget child;
  final bool hasNoAppbar;
  const ScaffoldBodyWidget(
      {Key? key, required this.child, this.hasNoAppbar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasNoAppbar
        ? Padding(
            padding: AppComponents.screenHorizontalPadding,
            child: SafeArea(top: true, child: child),
          )
        : Padding(
            padding: AppComponents.screenHorizontalPadding,
            child: child,
          );
  }
}

// ignore: must_be_immutable
class CustomScaffold extends StatelessWidget {
  PreferredSizeWidget? appBar;
  final Widget? body;
  Widget? floatingActionButton;
  FloatingActionButtonLocation? floatingActionButtonLocation;
  FloatingActionButtonAnimator? floatingActionButtonAnimator;
  List<Widget>? persistentFooterButtons;
  AlignmentDirectional persistentFooterAlignment =
      AlignmentDirectional.centerEnd;
  Widget? drawer;
  void Function(bool)? onDrawerChanged;
  Widget? endDrawer;
  void Function(bool)? onEndDrawerChanged;
  Widget? bottomNavigationBar;
  Widget? bottomSheet;
  Color? backgroundColor;
  bool? resizeToAvoidBottomInset;
  bool primary = true;
  DragStartBehavior drawerDragStartBehavior = DragStartBehavior.start;
  bool extendBody = false;
  bool extendBodyBehindAppBar = false;
  Color? drawerScrimColor;
  double? drawerEdgeDragWidth;
  bool drawerEnableOpenDragGesture = true;
  bool endDrawerEnableOpenDragGesture = true;
  String? restorationId;

  CustomScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: extendBody,
      appBar: appBar,
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
                height: screenHeight * 0.28,
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
                padding: const EdgeInsets.only(top: 18),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: screenWidth,
                    decoration: const ShapeDecoration(
                      color: AppColors.primaryButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    child: body,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      drawerDragStartBehavior: drawerDragStartBehavior,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      drawerScrimColor: drawerScrimColor,
      endDrawer: endDrawer,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      floatingActionButtonLocation: floatingActionButtonLocation,
      onDrawerChanged: onDrawerChanged,
      key: key,
      onEndDrawerChanged: onEndDrawerChanged,
      persistentFooterAlignment: persistentFooterAlignment,
      persistentFooterButtons: persistentFooterButtons,
      primary: primary,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      restorationId: restorationId,
    );
  }
}

class SingleOfferItem extends StatelessWidget {
  final Function()? onTap;
  final String image;
  final String name;
  final String type;
  final double? rating;
  final int? totalRides;
  final int seatAvailable;
  final int seatBooked;
  final double pricePerSeat;
  final LocationModel pickUpLocation;
  final LocationModel dropLocation;
  final DateTime dateAndTime;
  const SingleOfferItem(
      {super.key,
      this.onTap,
      required this.image,
      required this.name,
      this.type = 'vehicle',
      this.rating = 4.5,
      this.totalRides = 50,
      required this.seatAvailable,
      required this.seatBooked,
      required this.pricePerSeat,
      required this.pickUpLocation,
      required this.dropLocation,
      required this.dateAndTime});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 110,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.fromBorderColor),
              borderRadius: BorderRadius.circular(18),
              color: Colors.white),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, top: 16.0, right: 16.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: image.isEmpty
                              ? Image.asset(AppAssetImages.profileMan)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImageWidget(
                                    imageURL: image,
                                    cacheHeight: 30,
                                    cacheWidth: 30,
                                  ),
                                ),
                        ),
                        AppGaps.wGap12,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                )),
                            Row(
                              children: [
                                const SvgPictureAssetWidget(
                                  AppAssetImages.starSVGLogoSolid,
                                  color: AppColors.primaryColor,
                                ),
                                AppGaps.wGap4,
                                Text(
                                    '${Helper.getRoundedDecimalUpToTwoDigitText(rating ?? 4.5)} ($totalRides ${type == "passenger" ? "Trip" : "Ride"}${totalRides! > 1 ? "s" : ""})',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.bodyTextColor,
                                    ))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            "\$ ${Helper.getRoundedDecimalUpToTwoDigitText(pricePerSeat)} Per Seat",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryTextColor)),
                        AppGaps.hGap2,
                        Row(
                          children: [
                            for (int i = 0; i < seatAvailable; i++)
                              const Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: SvgPictureAssetWidget(
                                  AppAssetImages.seat,
                                ),
                              ),
                            if (type == 'vehicle')
                              for (int i = 0; i < seatBooked; i++)
                                const Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: SvgPictureAssetWidget(
                                    AppAssetImages.seat,
                                    color: AppColors.bodyTextColor,
                                  ),
                                ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              AppGaps.hGap12,

              /*<------- Second Row ------>*/
              Row(children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 16,
                            ),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(children: [
                                    const SvgPictureAssetWidget(
                                      AppAssetImages.pointOnMapSvgIcon,
                                      height: 10,
                                      width: 10,
                                    ),
                                    Container(
                                      width: 2,
                                      height: 6.5,
                                      color: AppColors.dividerColor,
                                    )
                                  ]),
                                  AppGaps.wGap6,
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 1),
                                      child: Text(
                                        pickUpLocation.address,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.bodyTextColor,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(children: [
                                  Container(
                                    width: 2,
                                    height: 6.5,
                                    color: AppColors.dividerColor,
                                  ),
                                  const SvgPictureAssetWidget(
                                    AppAssetImages.pointOnMapSvgIcon,
                                    color: AppColors.primaryColor,
                                    height: 10,
                                    width: 10,
                                  ),
                                ]),
                                AppGaps.wGap6,
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 1),
                                    child: Text(
                                      dropLocation.address,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.bodyTextColor,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SvgPictureAssetWidget(
                          AppAssetImages.calendar,
                          height: 10,
                          width: 10,
                        ),
                        AppGaps.wGap6,
                        Text(
                          Helper.ddMMMFormattedDate(dateAndTime),
                          // "22 Feb",
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColors.bodyTextColor),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const SvgPictureAssetWidget(AppAssetImages.clock),
                        AppGaps.wGap6,
                        Text(
                          Helper.hhmmFormattedTime(dateAndTime),
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColors.bodyTextColor),
                        )
                      ],
                    )
                  ],
                ),
                AppGaps.wGap16
              ])
            ],
          )),
    );
  }
}

class PickupAndDropLocationPickerWidget extends StatelessWidget {
  final String pickUpText;
  final String dropText;
  final bool isPickupEditable;
  final bool isDropEditable;
  final bool? hasCentralHorizontalBar;
  final Function()? onPickupEditTap;
  final Function()? onDropEditTap;
  final Function()? onPickUpTap;
  final Function()? onDropTap;
  const PickupAndDropLocationPickerWidget(
      {super.key,
      required this.pickUpText,
      required this.dropText,
      this.isPickupEditable = false,
      this.isDropEditable = false,
      this.hasCentralHorizontalBar = true,
      this.onPickupEditTap,
      this.onDropEditTap,
      this.onPickUpTap,
      this.onDropTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.fromBorderColor),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 24,
              top: 15,
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(children: [
                const SvgPictureAssetWidget(AppAssetImages.pointOnMapSvgIcon),
                Container(
                  width: 3,
                  height: 17,
                  color: AppColors.dividerColor,
                )
              ]),
              AppGaps.wGap12,
              Expanded(
                child: GestureDetector(
                  onTap: onPickUpTap,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      pickUpText.isNotEmpty ? pickUpText : 'Pickup Location',
                      style: const TextStyle(
                          color: AppColors.bodyTextColor,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
              ),
              if (isPickupEditable)
                GestureDetector(
                  onTap: onPickupEditTap,
                  child: const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline),
                      )),
                )
            ]),
          ),
          if (hasCentralHorizontalBar ?? true)
            Container(
              height: 0.5,
              color: AppColors.dividerColor,
            ),
          Container(
            padding: const EdgeInsets.only(left: 24, bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(children: [
                  Container(
                    width: 3,
                    height: 17,
                    color: AppColors.dividerColor,
                  ),
                  const SvgPictureAssetWidget(
                    AppAssetImages.dropLocationSVGLogoLine,
                    color: AppColors.primaryColor,
                  ),
                ]),
                AppGaps.wGap12,
                Expanded(
                  child: GestureDetector(
                    onTap: onDropTap,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Text(
                        dropText.isNotEmpty ? dropText : 'Drop Location',
                        style: const TextStyle(
                            color: AppColors.bodyTextColor,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ),
                if (isDropEditable)
                  GestureDetector(
                    onTap: onDropEditTap,
                    child: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline),
                        )),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}

/*<-------  Credit card widget with 3 shadows towards bottom ------>*/
class PaymentCardWidget extends StatelessWidget {
  final Widget child;
  const PaymentCardWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 232,
      alignment: Alignment.topCenter,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(child: Container(alignment: Alignment.topCenter)),
          Container(
            height: 208,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left: 32, right: 32, top: 24),
            decoration: BoxDecoration(
              color: const Color(0xFF7A63EB).withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          Container(
            height: 208,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF7A63EB).withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          Container(
            height: 208,
            decoration: const BoxDecoration(
              color: Color(0xFF7A63EB),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

/*<-------Custom list tile widget of white background color  ------>*/
class CustomMessageListTileWidget extends StatelessWidget {
  final bool hasShadow;
  final double elevation;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final EdgeInsets paddingValue;
  final BorderRadius borderRadius;
  const CustomMessageListTileWidget(
      {Key? key,
      required this.child,
      this.onTap,
      this.paddingValue =
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      this.onLongPress,
      this.borderRadius =
          const BorderRadius.all(AppComponents.defaultBorderRadius),
      this.hasShadow = false,
      this.elevation = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: hasShadow ? elevation : 0,
      shadowColor: Colors.grey.withOpacity(0.9),
      borderRadius: borderRadius,
      child: Material(
        color: AppColors.fromInnerColor,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            alignment: Alignment.topLeft,
            padding: paddingValue,
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: AppColors.fromBorderColor, width: 1)),
            child: child,
          ),
        ),
      ),
    );
  }
}

class EmptyScreenWidget extends StatelessWidget {
  final String localImageAssetURL;
  final bool isSVGImage;
  final String title;
  final String shortTitle;
  final double height;
  const EmptyScreenWidget({
    Key? key,
    required this.localImageAssetURL,
    required this.title,
    this.shortTitle = '',
    this.isSVGImage = false,
    this.height = 231,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height,
          //  width: 254,
          child: isSVGImage
              ? SvgPicture.asset(localImageAssetURL, height: 231)
              : Image.asset(localImageAssetURL),
        ),
        AppGaps.hGap32,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.titleBoldTextStyle,
              ),
              AppGaps.hGap8,
              Text(shortTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLargeTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}

/*<------- Custom padded bottom bar widget for scaffold ------>*/
class CustomScaffoldBottomBarWidget extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  const CustomScaffoldBottomBarWidget(
      {Key? key, required this.child, this.backgroundColor, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppGaps.bottomNavBarPadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

/*<------- Custom TextButton stretches the width of the screen with small elevation ------>*/
class CustomStretchedOutlinedButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomStretchedOutlinedButtonWidget({
    Key? key,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.backgroundColor,
                minimumSize: const Size(30, 62),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
              child: child),
        ),
      ],
    );
  }
}

/*<-------  Custom TextButton stretches the width of the screen with small elevation ------>*/
class CustomStretchedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  final Color? backgroundColor;
  const CustomStretchedTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: onTap == null
                  ? LinearGradient(colors: [
                      Color.lerp(backgroundColor ?? AppColors.primaryColor,
                              Colors.white, 0.5) ??
                          (backgroundColor ?? AppColors.primaryColor)
                              .withOpacity(0.5),
                      Color.lerp(backgroundColor ?? AppColors.primaryColor,
                              Colors.white, 0.5) ??
                          (backgroundColor ?? AppColors.primaryColor)
                    ])
                  : LinearGradient(colors: [
                      backgroundColor ?? AppColors.primaryColor,
                      Color.lerp(backgroundColor ?? AppColors.primaryColor,
                              Colors.white, 0.1) ??
                          (backgroundColor ?? AppColors.primaryColor)
                              .withOpacity(0.4),
                    ]),
            ),
            child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                elevation: onTap == null ? 0 : 10,
                shadowColor: AppColors.primaryColor.withOpacity(0.25),
                minimumSize: const Size(30, 62),
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(AppComponents.defaultBorderRadius)),
              ),
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style:
                    onTap == null ? const TextStyle(color: Colors.white) : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomSheetTopNotch extends StatelessWidget {
  const BottomSheetTopNotch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 53,
        height: 3,
        child: Container(
          decoration: const ShapeDecoration(
              shape: StadiumBorder(), color: AppColors.bodyTextColor),
        ),
      ),
    );
  }
}

/*<------- Custom TextButton with small elevation shadow ------>*/
class CustomTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const CustomTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: onTap == null
              ? LinearGradient(colors: [
                  Color.lerp(AppColors.primaryColor, Colors.white, 0.5) ??
                      AppColors.primaryColor.withOpacity(0.5),
                  Color.lerp(AppColors.primaryColor, Colors.white, 0.5) ??
                      AppColors.primaryColor.withOpacity(0.5)
                ])
              : LinearGradient(colors: [
                  AppColors.primaryColor,
                  Color.lerp(AppColors.primaryColor, Colors.white, 0.4) ??
                      AppColors.primaryColor.withOpacity(0.4),
                ])),
      child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              elevation: onTap == null ? 0 : 10,
              shadowColor: AppColors.primaryColor.withOpacity(0.25),
              minimumSize: const Size(30, 62),
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(AppComponents.defaultBorderRadius))),
          child: Text(buttonText,
              textAlign: TextAlign.center,
              style:
                  onTap == null ? const TextStyle(color: Colors.white) : null)),
    );
  }
}

/* /*<------- Custom TextButton stretches the width of the screen with small elevation ------>*/
class CustomStretchedButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomStretchedButtonWidget({
    Key? key,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  elevation: 10,
                  shadowColor: AppColors.primaryColor.withOpacity(0.25),
                  backgroundColor: onTap == null
                      ? AppColors.bodyTextColor
                      : AppColors.primaryColor,
                  minimumSize: const Size(30, 62),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)))),
              child: child),
        ),
      ],
    );
  }
}
 */

/*<------- Custom TextButton stretches the width of the screen with small elevation ------>*/
class CustomStretchedButtonWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final void Function()? onLongPress;

  final void Function()? onTap;
  const CustomStretchedButtonWidget({
    Key? key,
    this.onTap,
    required this.child,
    this.isLoading = false,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        onLongPress: onLongPress,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          elevation: 10,
          shadowColor: AppColors.primaryColor.withOpacity(0.25),
          backgroundColor: onTap == null
              ? AppColors.fromBorderColor
              : AppColors.primaryColor,
          minimumSize: const Size.fromHeight(54),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : child);
  }
}

/*<------- Custom toggle button of tab widget ------>*/
class CustomTabToggleButtonWidget extends StatelessWidget {
  final bool isSelected;
  final String text;
  final void Function()? onTap;
  const CustomTabToggleButtonWidget(
      {Key? key, required this.isSelected, required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      animationDuration: Duration.zero,
      color: isSelected ? AppColors.primaryColor : Colors.transparent,
      elevation: isSelected ? 10 : 0,
      shadowColor: isSelected ? AppColors.primaryColor.withOpacity(0.25) : null,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: isSelected ? Colors.white : null),
          ),
        ),
      ),
    );
  }
}

/*<-------Svg picture Insert  ------>*/

class SvgPictureAssetWidget extends StatelessWidget {
  final String assetName;
  final double? height;
  final double? width;
  final Color? color;
  final String? package;
  final BoxFit fit;
  const SvgPictureAssetWidget(this.assetName,
      {super.key,
      this.height,
      this.width,
      this.color,
      this.package,
      this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetName,
        height: height,
        width: width,
        fit: fit,
        colorFilter: color == null
            ? const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)
            : ColorFilter.mode(color!, BlendMode.srcIn));
  }
}

/*<------- Custom list tile widget of white background color ------>*/
class CustomListTileWidget extends StatelessWidget {
  final bool hasShadow;
  final double elevation;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final EdgeInsets paddingValue;
  final BorderRadius borderRadius;
  const CustomListTileWidget(
      {Key? key,
      required this.child,
      this.onTap,
      this.paddingValue = const EdgeInsets.all(AppGaps.screenPaddingValue),
      this.onLongPress,
      this.borderRadius =
          const BorderRadius.all(AppComponents.defaultBorderRadius),
      this.hasShadow = false,
      this.elevation = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: hasShadow ? elevation : 0,
      shadowColor: Colors.black.withOpacity(0.05),
      borderRadius: borderRadius,
      child: Material(
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            alignment: Alignment.topLeft,
            padding: paddingValue,
            decoration: BoxDecoration(borderRadius: borderRadius),
            child: child,
          ),
        ),
      ),
    );
  }
}

/*<-------  Custom list tile widget of white background colors ------>*/
class CustomSettingsListTileWidget extends StatelessWidget {
  final bool hasShadow;
  final double elevation;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final EdgeInsets paddingValue;
  final BorderRadius borderRadius;
  const CustomSettingsListTileWidget(
      {Key? key,
      required this.child,
      this.onTap,
      this.paddingValue = const EdgeInsets.all(AppGaps.screenPaddingValue),
      this.onLongPress,
      this.borderRadius =
          const BorderRadius.all(AppComponents.defaultBorderRadius),
      this.hasShadow = false,
      this.elevation = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: hasShadow ? elevation : 0,
      shadowColor: Colors.black.withOpacity(0.05),
      borderRadius: borderRadius,
      child: Material(
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            alignment: Alignment.topLeft,
            padding: paddingValue,
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: AppColors.fromBorderColor)),
            child: child,
          ),
        ),
      ),
    );
  }
}

/*<-------Custom TextButton stretches the width of the screen with small elevation  ------>*/

class CustomStretchedOnlyTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const CustomStretchedOnlyTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                  minimumSize: const Size(30, 32),
                  visualDensity: const VisualDensity(),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(AppComponents.defaultBorderRadius))),
              child: Text(buttonText)),
        ),
      ],
    );
  }
}

/*<------- Custom TextFormField configured with Theme. ------>*/
class CustomTextFormField extends StatelessWidget {
  final String? initialText;
  final String? labelText;
  final Color? labelTextColor;
  final String? hintText;
  final String? errorText;
  final Widget? errorWidget;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final bool isRequired;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final double prefixSpaceSize;
  final double suffixSpaceSize;
  const CustomTextFormField({
    Key? key,
    this.initialText,
    this.labelText,
    this.labelTextColor,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.focusNode,
    this.isRequired = false,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.onFieldSubmitted,
    this.prefixSpaceSize = 24,
    this.suffixSpaceSize = 10,
    this.errorWidget,
    this.errorText,
  }) : super(key: key);

  /*<------- TextField widget ------>*/
  Widget textFormFieldWidget() {
    return SizedBox(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: initialText,
        controller: controller,
        focusNode: focusNode,
        onTap: onTap,
        readOnly: isReadOnly,
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          prefix: AppGaps.wGap24,
          error: errorWidget,
          errorText: errorText,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap10,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /*<-------If label text is not null, then show label as a separate Text widget.
    wrapped inside column widget.
     Else, just return the TextFormField widget.  ------>*/
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

/*<------- Updated date and time ------>*/

/*<------- Custom TextFormField configured with Theme. ------>*/
class CustomDateAndTimeTextFormField extends StatelessWidget {
  final String? initialText;
  final String? labelText;
  final Color? labelTextColor;
  final String? hintText;
  final String? errorText;
  final Widget? errorWidget;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final bool isRequired;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final double prefixSpaceSize;
  final double suffixSpaceSize;
  const CustomDateAndTimeTextFormField({
    Key? key,
    this.initialText,
    this.labelText,
    this.labelTextColor,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 20, maxWidth: 30),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 20, maxWidth: 30),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.focusNode,
    this.isRequired = false,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.onFieldSubmitted,
    this.prefixSpaceSize = 24,
    this.suffixSpaceSize = 10,
    this.errorWidget,
    this.errorText,
  }) : super(key: key);

  /*<------- TextField widget ------>*/
  Widget textFormFieldWidget() {
    return SizedBox(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: initialText,
        controller: controller,
        focusNode: focusNode,
        onTap: onTap,
        readOnly: isReadOnly,
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: hintText,
          prefix: AppGaps.wGap5,
          error: errorWidget,
          errorText: errorText,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 10, right: 3),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          suffixIconConstraints: suffixIconConstraints,
          suffixIcon: suffixIcon != null ? suffixIcon : null,
        ),
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /*<-------If label text is not null, then show label as a separate Text widget.
    wrapped inside column widget.
     Else, just return the TextFormField widget.  ------>*/
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

/*<------- Custom TextFormField configured with Theme. ------>*/
class LocationPickUpTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hasShadow;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  const LocationPickUpTextFormField({
    Key? key,
    this.focusNode,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
  }) : super(key: key);

  /*<------- TextField widget ------>*/
  Widget textFormFieldWidget() {
    return SizedBox(
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0))),
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0))),
          prefix: AppGaps.wGap10,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 25),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap10,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /*<------- 
     If label text is not null, then show label as a separate Text widget
    wrapped inside column widget.
    Else, just return the TextFormField widget. ------>*/
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

/*<-------  Custom TextFormField configured with Theme. ------>*/
class LocationPickDownTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hasShadow;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  const LocationPickDownTextFormField({
    Key? key,
    this.focusNode,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
  }) : super(key: key);

  Widget textFormFieldWidget() {
    return SizedBox(
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18))),
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18))),
          prefix: AppGaps.wGap10,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 25),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap5,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /*<-------   If label text is not null, then show label as a separate Text widget.
     wrapped inside column widget.
    Else, just return the TextFormField widget.------>*/
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

/*<-------Custom TextFormField configured with Theme.s  ------>*/
class CustomPhoneInputTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final String? initialText;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hasShadow;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  const CustomPhoneInputTextFormField({
    Key? key,
    this.focusNode,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.initialText,
  }) : super(key: key);

  Widget textFormFieldWidget() {
    return SizedBox(
      child: TextFormField(
        focusNode: focusNode,
        initialValue: initialText,
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.fromBorderColor),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.fromBorderColor),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          prefix: AppGaps.wGap10,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 25),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap5,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          // Text field
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      // Text field
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

/*<----Radio widget without additional padding----->*/
class CustomRadioWidget extends StatelessWidget {
  final Object value;
  final Object? groupValue;
  final Function(Object?) onChanged;
  const CustomRadioWidget(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: Radio<Object>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}

/*<-------Custom IconButton widget various attributes-------->*/
class CustomIconButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Border? border;
  final Widget child;
  final Color backgroundColor;
  final Size fixedSize;
  final Radius borderRadiusRadiusValue;
  final bool isCircleShape;
  final bool hasShadow;
  const CustomIconButtonWidget(
      {Key? key,
      this.onTap,
      required this.child,
      this.backgroundColor = Colors.white,
      this.fixedSize = const Size(20, 20),
      this.borderRadiusRadiusValue = const Radius.circular(14),
      this.border,
      this.isCircleShape = false,
      this.hasShadow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fixedSize.height,
      width: fixedSize.width,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          shape: isCircleShape ? BoxShape.circle : BoxShape.rectangle,
          borderRadius:
              isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
          border: border),
      child: Material(
        color: backgroundColor,
        shape: isCircleShape ? const CircleBorder() : null,
        shadowColor: hasShadow ? Colors.black.withOpacity(0.4) : null,
        elevation: hasShadow ? 8 : 0,
        borderRadius:
            isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
        child: InkWell(
          onTap: onTap,
          customBorder: isCircleShape ? const CircleBorder() : null,
          borderRadius: BorderRadius.all(borderRadiusRadiusValue),
          child: Center(child: child),
        ),
      ),
    );
  }
}

/*<-------Custom large text button widget-------->*/
class CustomLargeTextButtonWidget extends StatelessWidget {
  final bool isSmallScreen;
  final void Function()? onTap;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  const CustomLargeTextButtonWidget({
    Key? key,
    this.onTap,
    required this.text,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.isSmallScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            foregroundColor: textColor,
            fixedSize:
                isSmallScreen ? const Size(140, 55) : const Size(175, 65),
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            backgroundColor: backgroundColor,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(AppComponents.defaultBorderRadius))),
        child: Text(text));
  }
}

/*<-------Raw list tile does not have a background color-------->*/
class CustomRawListTileWidget extends StatelessWidget {
  final Widget child;
  final bool colorCng;
  final bool isShadow;
  final void Function()? onTap;
  final Radius? borderRadiusRadiusValue;
  const CustomRawListTileWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.borderRadiusRadiusValue,
    this.colorCng = false,
    this.isShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: !colorCng ? Colors.transparent : AppColors.backgroundColor,
      shadowColor: isShadow
          ? Colors.black.withOpacity(0.15)
          : Colors.white.withOpacity(0.0),
      elevation: 20,
      borderRadius: borderRadiusRadiusValue != null
          ? BorderRadius.all(borderRadiusRadiusValue!)
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadiusRadiusValue != null
            ? BorderRadius.all(borderRadiusRadiusValue!)
            : null,
        child: child,
      ),
    );
  }
}

/*<-------Horizontal dashed line-------->*/
class CustomHorizontalDashedLineWidget extends StatelessWidget {
  const CustomHorizontalDashedLineWidget({
    Key? key,
    this.height = 1,
    this.color = Colors.black,
  }) : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

/*<--------Vertical dashed line------->*/
class CustomVerticalDashedLineWidget extends StatelessWidget {
  const CustomVerticalDashedLineWidget({
    Key? key,
    this.width = 1,
    this.color = Colors.black,
  }) : super(key: key);
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxHeight = constraints.constrainWidth();
        const dashHeight = 4.0;
        final dashWidth = width;
        final dashCount = (boxHeight / (2 * dashHeight)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

/*<-------Highlight and details text widget-------->*/
class HighlightAndDetailTextWidget extends StatelessWidget {
  final String slogan;
  final String subtitle;
  final bool isSpaceShorter;
  final Color textColor;
  final Color subtextColor;

  const HighlightAndDetailTextWidget({
    Key? key,
    required this.slogan,
    required this.subtitle,
    this.isSpaceShorter = false,
    this.textColor = AppColors.primaryTextColor,
    this.subtextColor = AppColors.bodyTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(slogan,
            textAlign: TextAlign.center,
            style: AppTextStyles.titleBoldTextStyle.copyWith(color: textColor)),
        isSpaceShorter ? AppGaps.hGap8 : AppGaps.hGap16,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLargeTextStyle
                  .copyWith(color: subtextColor)),
        ),
      ],
    );
  }
}

/*<-------Loading text widget-------->*/
class LoadingTextWidget extends StatelessWidget {
  final bool isSmall;
  const LoadingTextWidget({
    super.key,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isSmall ? 15 : 20,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white, borderRadius: AppComponents.smallBorderRadius),
      ),
    );
  }
}

/*<--------Custom IconButton widget various attributes------->*/
class IconButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Border? border;
  final Widget child;
  final Color backgroundColor;
  final Size fixedSize;
  final Radius borderRadiusRadiusValue;
  final bool isCircleShape;
  final bool hasShadow;
  const IconButtonWidget(
      {Key? key,
      this.onTap,
      required this.child,
      this.backgroundColor = Colors.white,
      this.fixedSize = const Size(40, 40),
      this.borderRadiusRadiusValue = const Radius.circular(12),
      this.border,
      this.isCircleShape = false,
      this.hasShadow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fixedSize.height,
      width: fixedSize.width,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        shape: isCircleShape ? BoxShape.circle : BoxShape.rectangle,
        borderRadius:
            isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
        border: border ??
            Border.all(color: Colors.white.withOpacity(0.4), width: 1.42),
      ),
      child: Material(
        color: backgroundColor,
        shape: isCircleShape ? const CircleBorder() : null,
        shadowColor: hasShadow ? Colors.black.withOpacity(0.4) : null,
        elevation: hasShadow ? 8 : 0,
        borderRadius:
            isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
        child: InkWell(
          onTap: onTap,
          customBorder: isCircleShape ? const CircleBorder() : null,
          borderRadius: BorderRadius.all(borderRadiusRadiusValue),
          child: Center(child: child),
        ),
      ),
    );
  }
}

/*<--------Custom TextButton widget which is very tight to child text------->*/
class CustomTightTextButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  const CustomTightTextButtonWidget({
    Key? key,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity)),
        child: child);
  }
}

/*<-------Custom TextButton stretches the width of the screen-------->*/
class StretchedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color color;
  final Color fontColor;
  final bool isSmallSizedButton;
  final void Function()? onTap;
  const StretchedTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
    this.backgroundColor = AppColors.primaryColor,
    this.color = Colors.white,
    this.fontColor = Colors.white,
    this.isSmallSizedButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonWidget(
              borderRadiusValue: 8,
              onTap: onTap,
              color: color,
              fixedSize: isSmallSizedButton ? null : const Size(211, 55),
              backgroundColor: backgroundColor,
              child: Text(
                buttonText,
                style: AppTextStyles.bodyLargeSemiboldTextStyle
                    .copyWith(color: fontColor),
              )),
        ),
      ],
    );
  }
}

/*<-------Button widget-------->*/
class ButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Color color;
  final Color backgroundColor;
  final Widget child;
  final Size? fixedSize;
  final double borderRadiusValue;

  const ButtonWidget({
    Key? key,
    this.onTap,
    this.color = AppColors.primaryButtonColor,
    this.backgroundColor = AppColors.primaryColor,
    required this.child,
    this.fixedSize,
    this.borderRadiusValue = AppConstants.borderRadiusValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: color,
          disabledForegroundColor: AppColors.primaryButtonColor,
          disabledBackgroundColor: AppColors.secondaryFont2Color,
          backgroundColor: backgroundColor,
          minimumSize: const Size(30, 44),
          fixedSize: fixedSize,
          shape: RoundedRectangleBorder(
              borderRadius: AppConstants.borderRadius(borderRadiusValue)),
        ),
        child: child);
  }
}

/*<--------Custom grid item widget------->*/
class CustomGridSingleItemWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Color? borderColor;
  final BorderRadius borderRadius;
  final void Function()? onTap;
  const CustomGridSingleItemWidget({
    Key? key,
    required this.onTap,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.padding = const EdgeInsets.all(7.5),
    required this.child,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              border:
                  borderColor != null ? Border.all(color: borderColor!) : null),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

/*<--------Alert dialog widget------->*/
class AlertDialogWidget extends StatelessWidget {
  final List<Widget>? actionWidgets;
  final Widget? contentWidget;
  final Widget? titleWidget;
  final Color? backgroundColor;
  const AlertDialogWidget({
    super.key,
    this.actionWidgets,
    this.contentWidget,
    this.titleWidget,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      titlePadding: AppComponents.dialogTitlePadding,
      contentPadding: AppComponents.dialogContentPadding,
      shape: const RoundedRectangleBorder(
          borderRadius: AppComponents.dialogBorderRadius),
      title: titleWidget,
      content: contentWidget,
      actions: actionWidgets,
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: AppComponents.dialogActionPadding,
      buttonPadding: EdgeInsets.zero,
    );
  }
}

class ScheduleRideAlertDialogWidget extends StatelessWidget {
  final List<Widget>? actionWidgets;
  final Widget? contentWidget;
  final Widget? titleWidget;
  final Color? backgroundColor;
  const ScheduleRideAlertDialogWidget({
    super.key,
    this.actionWidgets,
    this.contentWidget,
    this.titleWidget,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      titlePadding: AppComponents.dialogTitlePadding,
      contentPadding: AppComponents.dialogContentPadding,
      shape: const RoundedRectangleBorder(
          borderRadius: AppComponents.dialogBorderRadius),
      title: titleWidget,
      content: contentWidget,
      actions: actionWidgets,
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: AppComponents.dialogActionPadding,
      buttonPadding: EdgeInsets.zero,
    );
  }
}

/*<-------Custom dialog button widget-------->*/
class CustomDialogButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomDialogButtonWidget({
    Key? key,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            elevation: 10,
            shadowColor: AppColors.primaryColor.withOpacity(0.25),
            backgroundColor: onTap == null
                ? AppColors.bodyTextColor
                : AppColors.primaryColor,
            minimumSize: const Size(128, 33),
            shape: const StadiumBorder()),
        child: child);
  }
}

/*<--------Custom TextButton stretches------->*/
class CustomStretchedOutlinedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final Image? image;
  final Color? backgroundColor;
  final void Function()? onTap;

  const CustomStretchedOutlinedTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
    this.image,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              backgroundColor: backgroundColor,
              minimumSize: const Size(30, 62),
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(AppComponents.defaultBorderRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (image != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: image,
                  ),
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ColoredOutlinedIconTextButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final void Function()? onTap;
  const ColoredOutlinedIconTextButton({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: icon,
      onPressed: onTap,
      label:
          Text(text, style: AppTextStyles.bodyTextStyle.copyWith(fontSize: 16)),
      style: OutlinedButton.styleFrom(
          // backgroundColor: AppColors.coloredOutlinedButtonBackground,
          foregroundColor: AppColors.primaryTextColor,
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppColors.fromBorderColor),
              borderRadius: BorderRadius.circular(8)),
          minimumSize: const Size.fromHeight(56)),
    );
  }
}

/*<-------Notification dot widget-------->*/
class NotificationDotWidget extends StatelessWidget {
  final bool isRead;
  const NotificationDotWidget({super.key, this.isRead = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: isRead
              ? AppColors.primaryButtonColor.withOpacity(0.2)
              : AppColors.primaryColor,
          shape: BoxShape.circle),
    );
  }
}

/*<--------Custom app bar widget------->*/
class CoreWidgets {
  /// Custom app bar widget
  static AppBar appBarWidget({
    required BuildContext screenContext,
    Color? appBarBackgroundColor,
    Widget? titleWidget,
    String? titleText,
    List<Widget>? actions,
    Widget? leading,
    bool hasBackButton = false,
    bool automaticallyImplyLeading = false,
  }) {
    return AppBar(
      backgroundColor: appBarBackgroundColor,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: hasBackButton
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: RawButtonWidget(
                  onTap: () {
                    Get.back();
                  },
                  child: Center(
                    child: const SvgPictureAssetWidget(
                      AppAssetImages.backButtonSVGLogoLine,
                      color: AppColors.primaryButtonColor,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20),
              child: leading,
            ),
      title: Text(
        titleText ?? '',
        style: AppTextStyles.titleBoldTextStyle
            .copyWith(color: AppColors.primaryButtonColor),
      ),
      actions: actions,
    );
  }

  static PagedChildBuilderDelegate<ItemType>
      pagedChildBuilderDelegate<ItemType>({
    required Widget Function(BuildContext, ItemType, int) itemBuilder,
    Widget Function(BuildContext)? errorIndicatorBuilder,
    Widget Function(BuildContext)? noItemFoundIndicatorBuilder,
    Widget Function(BuildContext)? firstPageLoadingIndicatorBuilder,
    Widget Function(BuildContext)? newPageLoadingIndicatorBuilder,
  }) {
    final firstPageProgressIndicatorBuilder =
        firstPageLoadingIndicatorBuilder ??
            (context) => const Center(child: CircularProgressIndicator());
    final newPageProgressIndicatorBuilder = newPageLoadingIndicatorBuilder ??
        (context) => const Center(child: CircularProgressIndicator());
    final pageErrorIndicatorBuilder =
        errorIndicatorBuilder ?? (context) => const ErrorPaginationWidget();
    final noItemsFoundIndicatorBuilder = noItemFoundIndicatorBuilder ??
        (context) => const ErrorPaginationWidget();
    return PagedChildBuilderDelegate<ItemType>(
        itemBuilder: itemBuilder,
        firstPageErrorIndicatorBuilder: pageErrorIndicatorBuilder,
        newPageErrorIndicatorBuilder: pageErrorIndicatorBuilder,
        noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
        firstPageProgressIndicatorBuilder: firstPageProgressIndicatorBuilder,
        newPageProgressIndicatorBuilder: newPageProgressIndicatorBuilder,
        animateTransitions: true,
        transitionDuration: const Duration(milliseconds: 200));
  }
}

/*<--------Error pagination widget------->*/
class ErrorPaginationWidget extends StatelessWidget {
  final String errorMessage;
  const ErrorPaginationWidget({
    Key? key,
    this.errorMessage = 'Error occurred while loading',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 150,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ErrorLoadedIconWidget(isLargeIcon: true),
            AppGaps.hGap5,
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMediumTextStyle,
            ),
          ],
        ));
  }
}

/*<--------Error loaded icon widget------->*/
class ErrorLoadedIconWidget extends StatelessWidget {
  final bool isLargeIcon;
  const ErrorLoadedIconWidget({
    Key? key,
    this.isLargeIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Icon(Icons.error_outline,
            size: isLargeIcon ? 40 : null, color: AppColors.errorColor));
  }
}

/*<-------Minus, counter, plus buttons row for product cart counter.-------->*/
class PlusMinusCounterRow extends StatelessWidget {
  final void Function()? onRemoveTap;
  final String counterText;
  final bool isDecrement;
  final void Function()? onAddTap;
  const PlusMinusCounterRow({
    Key? key,
    required this.onRemoveTap,
    required this.counterText,
    required this.isDecrement,
    required this.onAddTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 86,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RawButtonWidget(
            borderRadiusValue: 8,
            onTap: isDecrement ? onRemoveTap : null,
            child: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                  color: Color(0xFFF4F5FA),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Center(
                child: SvgPictureAssetWidget(
                  AppAssetImages.minusSVGLogoSolid,
                  color: isDecrement ? AppColors.primaryColor : Colors.grey,
                  height: 5,
                  width: 5,
                ),
              ),
            ),
          ),
          AppGaps.wGap10,
          Expanded(
            child: Center(
              child: Text(
                counterText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 12, color: AppColors.primaryTextColor),
              ),
            ),
          ),
          AppGaps.wGap10,
          RawButtonWidget(
            borderRadiusValue: 8,
            onTap: onAddTap,
            child: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: const Center(
                  child: SvgPictureAssetWidget(
                AppAssetImages.plusSVGLogoSolid,
                color: Colors.white,
                height: 20,
                width: 20,
              )),
            ),
          ),
        ],
      ),
    );
  }
}

/* <-------- Raw button widget -------> */
class RawButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final double? borderRadiusValue;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final double elevation;
  final Color? shadowColor;
  final bool isCircleShape;

  const RawButtonWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.borderRadiusValue,
    this.backgroundColor,
    this.focusNode,
    this.elevation = 0,
    this.shadowColor,
    this.isCircleShape = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: isCircleShape ? const CircleBorder() : null,
      borderRadius: isCircleShape
          ? null
          : borderRadiusValue != null
              ? BorderRadius.all(Radius.circular(borderRadiusValue!))
              : null,
      child: InkWell(
        onTap: onTap,
        customBorder: isCircleShape ? const CircleBorder() : null,
        borderRadius: isCircleShape
            ? null
            : borderRadiusValue != null
                ? BorderRadius.all(Radius.circular(borderRadiusValue!))
                : null,
        child: child,
      ),
    );
  }
}

/*<-------Single star widget-------->*/
class SingleStarWidget extends StatelessWidget {
  const SingleStarWidget({
    super.key,
    required this.review,
  });

  final double review;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SvgPictureAssetWidget(
          AppAssetImages.starSVGLogoSolid,
          height: 8,
          width: 8,
          color: AppColors.primaryColor,
        ),
        AppGaps.wGap5,
        Text(
          '$review',
          style: AppTextStyles.smallestMediumTextStyle,
        )
      ],
    );
  }
}

class LocalAssetSVGIcon extends StatelessWidget {
  final String iconLocalAssetLocation;
  final Color color;
  final double height;
  final double? width;
  const LocalAssetSVGIcon(this.iconLocalAssetLocation,
      {Key? key, required, required this.color, this.height = 24, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(iconLocalAssetLocation,
        height: height,
        width: width ?? height,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
  }
}

/*<-------- Tight  icon button that does not have any padding, margin around it------->*/
class TightIconButtonWidget extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;
  const TightIconButtonWidget({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity),
        onPressed: onTap,
        icon: icon);
  }
}

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageURL;
  final BoxFit boxFit;
  final int? cacheHeight;
  final int? cacheWidth;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  const CachedNetworkImageWidget({
    Key? key,
    required this.imageURL,
    this.boxFit = BoxFit.cover,
    this.cacheHeight,
    this.cacheWidth,
    this.imageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageURL.isEmpty
        ? Image.asset(AppAssetImages.imagePlaceholderIconImage,
            fit: BoxFit.contain)
        : CachedNetworkImage(
            imageUrl: imageURL,
            placeholder: (context, url) =>
                const LoadingImagePlaceholderWidget(),
            errorWidget: (context, url, error) => const ErrorLoadedIconWidget(),
            imageBuilder: imageBuilder,
            memCacheHeight: cacheHeight,
            memCacheWidth: cacheWidth,
            fit: boxFit);
  }
}

class LoadingImagePlaceholderWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const LoadingImagePlaceholderWidget({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: LoadingPlaceholderWidget(
          child: Image.asset(AppAssetImages.imagePlaceholderIconImage)),
    );
  }
}

class LoadingPlaceholderWidget extends StatelessWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  const LoadingPlaceholderWidget({
    Key? key,
    required this.child,
    this.baseColor = AppColors.bodyTextColor,
    this.highlightColor = AppColors.bodyTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: baseColor, highlightColor: highlightColor, child: child);
  }
}

class NoImageAvatarWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  const NoImageAvatarWidget({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: AppColors.primaryColor, shape: BoxShape.circle),
      child: Text(
        Helper.avatar2LetterUsername(firstName, lastName),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

/*<-------Intro light and detail text widget-------->*/
class IntrolightAndDetailTextWidget extends StatelessWidget {
  final String slogan;
  final String subtitle;
  final bool isSpaceShorter;
  const IntrolightAndDetailTextWidget({
    Key? key,
    required this.slogan,
    required this.subtitle,
    this.isSpaceShorter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          slogan,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: AppTextStyles.titleBoldTextStyle.copyWith(color: Colors.white),
        ),
        isSpaceShorter ? AppGaps.hGap8 : AppGaps.hGap16,
        Text(subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style:
                AppTextStyles.titleBoldTextStyle.copyWith(color: Colors.white)),
        AppGaps.hGap5,
      ],
    );
  }
}

/*<------- Highlighted title, subtitle columned texts-------->*/
class SloganTitleSubtitleTextColumnWidget extends StatelessWidget {
  const SloganTitleSubtitleTextColumnWidget({
    Key? key,
    required this.titleText,
    this.midTitleText = '',
    required this.subtitleText,
  }) : super(key: key);

  final String titleText;
  final String midTitleText;
  final String subtitleText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(titleText,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleLargeBoldTextStyle
                          .copyWith(color: Colors.black)),
                  Text(midTitleText,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleLargeBoldTextStyle
                          .copyWith(color: AppColors.primaryColor)),
                ],
              ),
              AppGaps.hGap16,
              Text(subtitleText,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyTextStyle
                      .copyWith(color: AppColors.primaryColor)),
            ],
          ),
        ),
      ],
    );
  }
}

/*<-------Custom padded bottom bar widget for scaffold-------->*/
class ScaffoldBottomBarWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  const ScaffoldBottomBarWidget(
      {Key? key,
      required this.child,
      this.backgroundColor,
      this.borderRadius,
      this.padding = AppGaps.bottomNavBarPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

/*<-------Custom TextButton widget which is very tight to child text-------->*/
class TightSmallTextButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final TextStyle textStyle;
  const TightSmallTextButtonWidget({
    Key? key,
    this.onTap,
    required this.text,
    this.textStyle = AppTextStyles.bodyMediumTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity)),
        child: Text(text, style: textStyle));
  }
}

/*<--------Phone number text field widget------->*/
class PhoneNumberTextFormFieldWidget extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final bool isRequired;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  final CountryCode? initialCountryCode;
  final bool isLabelWhiteText;
  final bool isFilled;
  final Color? fillColor;
  final void Function(CountryCode)? onCountryCodeChanged;
  const PhoneNumberTextFormFieldWidget({
    super.key,
    this.labelText,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.isRequired = false,
    this.initialCountryCode,
    this.onCountryCodeChanged,
    this.isLabelWhiteText = false,
    this.isFilled = false,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      labelText: labelText,
      prefixIconConstraints: const BoxConstraints(maxHeight: 32, maxWidth: 147),
      suffixIcon: suffixIcon,
      isPasswordTextField: isPasswordTextField,
      isReadOnly: isReadOnly,
      textInputType: TextInputType.phone,
      suffixIconConstraints: suffixIconConstraints,
      controller: controller,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines,
      fillColor: fillColor,
      isLabelWhiteText: isLabelWhiteText,
      isRequired: isRequired,
      onTap: onTap,
      prefixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CountryCodePicker(
            initialSelection: initialCountryCode?.code,
            onChanged: onCountryCodeChanged,
            builder: (country) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 25,
                    child: Image.asset(country?.flagUri ?? '',
                        package: 'country_code_picker'),
                  ),
                  AppGaps.wGap8,
                  const SvgPictureAssetWidget(
                      AppAssetImages.arrowDownSVGLogoLine,
                      color: AppColors.secondaryColor),
                  AppGaps.wGap5,
                  Container(
                      height: 26, width: 2, color: AppColors.fromBorderColor),
                  AppGaps.wGap16,
                  Text(
                    country?.dialCode ?? '',
                    style: AppTextStyles.bodyTextStyle
                        .copyWith(color: AppColors.bodyTextColor),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      hintText: hintText,
    );
  }
}

/*<-------used for pick country code-------->*/
class CustomPhoneNumberTextFormFieldWidget extends StatelessWidget {
  final String? initialText;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final bool isRequired;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  final CountryCode? initialCountryCode;
  final CountryCode? selectedCountryCode;
  final bool isLabelWhiteText;
  final bool isFilled;
  final Color? fillColor;
  final void Function(CountryCode)? onCountryCodeChanged;
  const CustomPhoneNumberTextFormFieldWidget({
    super.key,
    this.labelText,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.isRequired = false,
    this.initialCountryCode,
    this.selectedCountryCode,
    this.onCountryCodeChanged,
    this.isLabelWhiteText = false,
    this.isFilled = false,
    this.fillColor,
    this.initialText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 56,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    border: Border.all(color: AppColors.fromBorderColor)),
                child: IgnorePointer(
                  ignoring: isReadOnly,
                  child: ExcludeSemantics(
                    excluding: isReadOnly,
                    child: CountryCodePicker(
                      initialSelection: initialCountryCode?.code,
                      onChanged: onCountryCodeChanged,
                      builder: (country) {
                        return SizedBox(
                          height: 56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(country?.flagUri ?? '',
                                  package: 'country_code_picker',
                                  fit: BoxFit.cover),
                              AppGaps.wGap10,
                              Expanded(
                                  child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      country?.name ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.bodyMediumTextStyle
                                          .copyWith(
                                              color:
                                                  AppColors.primaryTextColor),
                                    ),
                                  ),
                                  AppGaps.wGap30,
                                ],
                              )),
                              const SvgPictureAssetWidget(
                                  AppAssetImages.arrowDownSVGLogoLine,
                                  color: AppColors.secondaryColor),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        CustomPhoneInputTextFormField(
          labelText: labelText,
          prefixIconConstraints: const BoxConstraints(maxHeight: 56),
          suffixIcon: suffixIcon,
          isReadOnly: isReadOnly,
          textInputType: TextInputType.phone,
          suffixIconConstraints: suffixIconConstraints,
          initialText: initialText,
          controller: controller,
          validator: validator,
          minLines: minLines,
          maxLines: maxLines,
          onTap: onTap,
          prefixIcon: Text(
            initialCountryCode?.dialCode ?? '',
            style: AppTextStyles.bodyTextStyle
                .copyWith(color: AppColors.bodyTextColor),
          ),
          hintText: hintText,
        ),
      ],
    );
  }
}

/*<-------Custom TextFormField configured with Theme.-------->*/
class TextFormFieldWidget extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle hintTextStyle;
  final Widget? labelPrefixIcon;
  final bool isPasswordTextField;
  final bool isReadOnly;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final int? minLines;
  final int maxLines;
  final double suffixRightPaddingSize;
  final BoxConstraints prefixIconConstraints;
  final BoxConstraints suffixIconConstraints;
  final double prefixLeftPaddingSize;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool isFilled;
  final bool isLabelWhiteText;
  final bool isRequired;
  final Color? fillColor;
  final InputBorder? border;
  const TextFormFieldWidget({
    Key? key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.isPasswordTextField = false,
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.labelPrefixIcon,
    this.suffixRightPaddingSize = 24,
    this.hintTextStyle = AppTextStyles.bodyMediumTextStyle,
    this.prefixLeftPaddingSize = 24,
    this.validator,
    this.suffixIconConstraints = const BoxConstraints(maxHeight: 24),
    this.isFilled = true,
    this.fillColor,
    this.border,
    this.isLabelWhiteText = false,
    this.isRequired = false,
    this.prefixIconConstraints = const BoxConstraints(maxHeight: 24),
  }) : super(key: key);

  Widget textFormFieldWidget() {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        obscuringCharacter: '*',
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        minLines: minLines,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintTextStyle,
          border: border,
          enabledBorder: border,
          filled: isFilled,
          fillColor: fillColor,
          prefixIconConstraints: prefixIconConstraints,
          suffixIconConstraints: suffixIconConstraints,
          prefix: prefixIcon != null ? AppGaps.wGap16 : null,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: prefixLeftPaddingSize),
            child: prefixIcon ?? AppGaps.emptyGap,
          ),
          suffix: suffixIcon != null ? AppGaps.wGap16 : null,
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: suffixRightPaddingSize),
            child: suffixIcon ?? AppGaps.emptyGap,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelPrefixIcon != null
                  ? Container(
                      alignment: Alignment.topLeft,
                      constraints: const BoxConstraints(minHeight: 10),
                      child: labelPrefixIcon)
                  : AppGaps.emptyGap,
              labelPrefixIcon != null ? AppGaps.wGap15 : AppGaps.emptyGap,
              Expanded(
                child: Row(
                  children: [
                    Text(labelText!,
                        /* style: AppTextStyles.bodyMediumTextStyle.copyWith(
                          color: isLabelWhiteText
                              ? Colors.white
                              : const Color(0xFF3A416F)), */
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    if (isRequired)
                      Text(
                        ' *',
                        style: AppTextStyles.bodyLargeSemiboldTextStyle
                            .copyWith(color: AppColors.errorColor),
                      )
                  ],
                ),
              ),
            ],
          ),
          AppGaps.hGap8,
          textFormFieldWidget(),
        ],
      );
    } else {
      return textFormFieldWidget();
    }
  }
}

/*<-------Check box widget-------->*/
class CheckboxWidget extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  const CheckboxWidget({super.key, this.value = false, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 19,
      height: 20,
      child: Checkbox(value: value, onChanged: onChanged),
    );
  }
}

class CustomMessageTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final double boxHeight;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  const CustomMessageTextFormField({
    Key? key,
    this.labelText,
    this.boxHeight = 62,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
  }) : super(key: key);

  Widget textFormFieldWidget() {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide:
                  BorderSide(color: AppColors.fromBorderColor, width: 1)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide:
                  BorderSide(color: AppColors.fromBorderColor, width: 1)),
          hintText: hintText,
          prefix: AppGaps.wGap10,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap10,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          // Text field
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

class Custom2MessageTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final double boxHeight;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  const Custom2MessageTextFormField({
    Key? key,
    this.labelText,
    this.boxHeight = 40,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
  }) : super(key: key);

  Widget textFormFieldWidget() {
    return SizedBox(
      height: (maxLines > 1 || (minLines ?? 1) > 1) ? null : boxHeight,
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide:
                  BorderSide(color: AppColors.fromBorderColor, width: 1)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide:
                  BorderSide(color: AppColors.fromBorderColor, width: 1)),
          hintText: hintText,
          prefix: AppGaps.wGap10,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap10,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

/*<-------Drop down button form field widget------->*/
class DropdownButtonFormFieldWidget<T> extends StatelessWidget {
  final T? value;
  final String hintText;
  final Widget? prefixIcon;
  final bool isDisabled;
  final bool isLoading;
  final String? labelText;
  final List<T>? items;
  final String Function(T)? getItemText;
  final BoxConstraints prefixIconConstraints;
  final Widget Function(T)? getItemChild;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final TextEditingController? controller;
  final bool isDense;
  const DropdownButtonFormFieldWidget(
      {super.key,
      this.value,
      required this.hintText,
      this.prefixIcon,
      this.items,
      this.getItemText,
      required this.onChanged,
      this.prefixIconConstraints =
          const BoxConstraints(maxHeight: 48, maxWidth: 48),
      this.labelText,
      this.validator,
      this.controller,
      this.isLoading = false,
      this.getItemChild,
      this.isDense = true,
      this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: AppTextStyles.labelTextStyle,
          ),
        if (labelText != null) AppGaps.hGap8,
        Builder(builder: (context) {
          if (isLoading) {
            return const DropdownButtonFormFieldLoadingWidget();
          }
          return IgnorePointer(
            ignoring: isDisabled,
            child: DropdownButtonFormField<T>(
              isExpanded: true,
              isDense: isDense,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              value: value,
              borderRadius: AppComponents.defaultBorder,
              hint: Text(hintText),
              disabledHint: Text(hintText,
                  style: AppTextStyles.labelTextStyle.copyWith(
                      color: AppColors.bodyTextColor.withOpacity(0.5))),
              icon: SizedBox(
                height: 24,
                width: 24,
                child: SvgPictureAssetWidget(
                    AppAssetImages.arrowDownSVGLogoLine,
                    color: _isDisabled()
                        ? AppColors.bodyTextColor.withOpacity(0.5)
                        : AppColors.primaryTextColor),
              ),
              decoration: InputDecoration(
                  prefixIconConstraints: prefixIconConstraints,
                  prefixIcon: prefixIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: prefixIcon,
                        )
                      : null,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 20)),
              items: items
                  ?.map((e) =>
                      DropdownMenuItem(value: e, child: _getItemChildWidget(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          );
        }),
      ],
    );
  }

  Widget _getItemChildWidget(T element) {
    if (getItemChild != null) {
      return getItemChild!(element);
    }
    if (getItemText != null) {
      return Text(getItemText!(element));
    }
    return AppGaps.emptyGap;
  }

  bool _isDisabled() =>
      onChanged == null || (items == null || (items?.isEmpty ?? true));
}

class DropdownButtonFormFieldLoadingWidget extends StatelessWidget {
  const DropdownButtonFormFieldLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: Container(
        height: 60,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: AppComponents.defaultBorder,
            border: Border.all(width: 2)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 120, child: LoadingTextWidget()),
              Spacer(),
              LocalAssetSVGIcon(AppAssetImages.arrowDownSVGLogoLine,
                  color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}

class AppAutocompleteWidget<T extends Object> extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;

  final Widget? prefixIcon;
  final String? hintText;
  final bool isLoading;
  final bool showCrossButton;
  final void Function(T option) onOptionSelected;
  final String? errorText;
  final Widget Function(T option, bool isHighlighted) optionWidget;
  final String? initialText;
  final FutureOr<Iterable<T>> Function(String query) optionsBuilder;
  const AppAutocompleteWidget(
      {super.key,
      this.isLoading = false,
      required this.onOptionSelected,
      this.errorText,
      required this.optionWidget,
      this.showCrossButton = true,
      this.hintText,
      this.initialText,
      required this.optionsBuilder,
      this.prefixIcon,
      this.focusNode,
      this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return AutocompleteWidget<T>(
      initialValue:
          initialText == null ? null : TextEditingValue(text: initialText!),
      focusNode: focusNode,
      textEditingController: textEditingController,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              CustomTextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        hintText: hintText,
        onFieldSubmitted: (value) => onFieldSubmitted(),
        prefixIcon: prefixIcon,
        suffixIcon: Stack(
          alignment: Alignment.center,
          children: [
            if (isLoading)
              const SizedBox.square(
                dimension: 32,
                child: CircularProgressIndicator(),
              ),
            if (showCrossButton)
              TightIconButtonWidget(
                icon: const Icon(Icons.close),
                onTap: () => textEditingController.clear(),
              )
          ],
        ),
      ),
      optionsBuilder: (textEditingValue) async {
        final query = textEditingValue.text.trim();
        if (query.isEmpty) {
          return [];
        }
        return await optionsBuilder(query);
      },
      optionWidget: optionWidget,
      onSelected: onOptionSelected,
    );
  }
}

class PasswordValidatorRuleWidget extends StatelessWidget {
  final bool isValid;
  final String text;
  const PasswordValidatorRuleWidget(
      {super.key, required this.isValid, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox.square(
          dimension: 24,
          child: isValid
              ? const Icon(
                  Icons.check,
                  color: AppColors.successColor,
                )
              : const Icon(Icons.close, color: AppColors.errorColor),
        ),
        const HorizontalGap(12),
        Expanded(
          child: Text(text,
              style: AppTextStyles.bodyTextStyle.copyWith(
                color: isValid
                    ? AppColors.bodyTextColor
                    : AppColors.primaryTextColor,
              )),
        ),
      ],
    );
  }
}

class PasswordFormFieldWidget extends StatelessWidget {
  final String? Function(String?)? passwordValidator;
  final TextEditingController controller;
  final bool hidePassword;
  final String? label;
  final String? hint;
  final bool showValidatorRules;
  final void Function()? onPasswordVisibilityToggleButtonTap;
  const PasswordFormFieldWidget({
    super.key,
    required this.passwordValidator,
    required this.controller,
    required this.hidePassword,
    required this.label,
    this.hint,
    this.onPasswordVisibilityToggleButtonTap,
    this.showValidatorRules = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = passwordValidator?.call(controller.text) != null;
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            validator: showValidatorRules ? null : passwordValidator,
            controller: controller,
            isPasswordTextField: hidePassword,
            labelText: label,
            hintText: '********',
            prefixIcon:
                const SvgPictureAssetWidget(AppAssetImages.unlockSVGLogoLine),
            suffixIcon: IconButton(
                padding: EdgeInsets.zero,
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                color: Colors.transparent,
                onPressed: onPasswordVisibilityToggleButtonTap,
                icon: SvgPictureAssetWidget(
                    hidePassword
                        ? AppAssetImages.hideSVGLogoLine
                        : AppAssetImages.showSVGLogoLine,
                    color: hidePassword
                        ? AppColors.bodyTextColor
                        : AppColors.primaryColor)),
            errorWidget: showValidatorRules
                ? (hasError
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            const VerticalGap(8),
                            PasswordValidatorRuleWidget(
                                isValid: Helper.isPasswordMoreThanMinimumLength(
                                    controller.text),
                                text: 'Minimum 8 characters'),
                            const VerticalGap(8),
                            PasswordValidatorRuleWidget(
                                isValid: Helper.isPasswordHasUppercaseCharacter(
                                        controller.text) &&
                                    Helper.isPasswordHasLowercaseCharacter(
                                        controller.text) &&
                                    Helper.isPasswordHasDigitCharacter(
                                        controller.text),
                                text:
                                    'At least 1 uppercase, 1 lowercase and 1 digit (0-9) character'),
                            const VerticalGap(8),
                            PasswordValidatorRuleWidget(
                                isValid: Helper.isPasswordHasSpecialCharacter(
                                    controller.text),
                                text:
                                    'At least 1 special character (!@#\$%^&*)'),
                          ])
                    : null)
                : null,
          ),
        ]);
  }
}

class ListTileWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const ListTileWidget({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      onTap: onTap,
      borderRadiusValue: 8,
      child: Container(
        constraints: const BoxConstraints(minHeight: 75),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.fromBorderColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: child,
        ),
      ),
    );
  }
}

class SelectImageButton extends StatelessWidget {
  final void Function()? onTap;
  const SelectImageButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
        borderRadiusValue: AppConstants.uploadImageButtonBorderRadiusValue,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(
                  AppConstants.uploadImageButtonBorderRadiusValue))),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(AppAssetImages.arrowUpRightSVGLogoLine,
                  color: AppColors.primaryColor, height: 40),
              AppGaps.hGap2,
              const Text('Tap here to upload images',
                  style: AppTextStyles.bodySemiboldTextStyle),
            ]),
          ),
        ));
  }
}

class MixedImageWidget extends StatelessWidget {
  final dynamic imageData;
  final BoxFit boxFit;
  final int? cacheHeight;
  final int? cacheWidth;
  final Widget Function(
      BuildContext context, ImageProvider<Object> imageProvider)? imageBuilder;
  const MixedImageWidget({
    Key? key,
    required this.imageData,
    this.boxFit = BoxFit.cover,
    this.cacheHeight,
    this.cacheWidth,
    this.imageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeholderImageWidget = Image.asset(
        AppAssetImages.imagePlaceholderIconImage,
        fit: BoxFit.contain);
    final memoryImageWidget =
        Image.memory((imageData is Uint8List) ? imageData : Uint8List(0));
    if (imageData is String) {
      return imageData.isEmpty
          ? imageBuilder == null
              ? Image.asset(AppAssetImages.imagePlaceholderIconImage,
                  fit: BoxFit.contain)
              : imageBuilder!.call(
                  context,
                  Image.asset(AppAssetImages.imagePlaceholderIconImage,
                          fit: BoxFit.contain)
                      .image)
          : CachedNetworkImage(
              imageUrl: imageData,
              placeholder: (context, url) =>
                  const LoadingImagePlaceholderWidget(),
              errorWidget: (context, url, error) =>
                  const ErrorLoadedIconWidget(),
              imageBuilder: imageBuilder,
              memCacheHeight: cacheHeight,
              memCacheWidth: cacheWidth,
              fit: boxFit);
    }
    if (imageData is Uint8List) {
      return imageBuilder == null
          ? Image.memory(imageData,
              fit: boxFit, cacheHeight: cacheHeight, cacheWidth: cacheWidth)
          : imageBuilder!.call(context, memoryImageWidget.image);
    }
    return imageBuilder == null
        ? placeholderImageWidget
        : imageBuilder!.call(context, placeholderImageWidget.image);
  }
}

/* <-------- Selected Local Image Widget for Single Image Upload -------> */
class SingleMixedImageUploadWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final dynamic imageData;
  final void Function()? onTap;
  final void Function()? onImageDeleteTap;
  final void Function()? onImageUploadTap;

  const SingleMixedImageUploadWidget({
    super.key,
    required this.label,
    this.isRequired = false,
    this.onTap,
    this.onImageDeleteTap,
    this.onImageUploadTap,
    this.imageData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.labelTextStyle,
            ),
            if (isRequired)
              Text(
                ' *',
                style: AppTextStyles.bodySemiboldTextStyle
                    .copyWith(color: AppColors.errorColor),
              )
          ],
        ),
        AppGaps.hGap16,
        SizedBox(
          height: 140,
          width: 140,
          child: RawButtonWidget(
            borderRadiusValue: AppConstants.defaultBorderRadiusValue,
            onTap: onTap,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Positioned.fill(
                  child: switch (imageData) {
                    String() => CachedNetworkImageWidget(
                        imageURL: imageData,
                        imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: AppComponents.defaultBorder,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                    Uint8List() => Container(
                        decoration: BoxDecoration(
                          borderRadius: AppComponents.defaultBorder,
                          image: DecorationImage(
                            image: (imageData as Uint8List).isEmpty
                                ? Image.asset(
                                        AppAssetImages
                                            .imagePlaceholderIconImage,
                                        fit: BoxFit.contain)
                                    .image
                                : Image.memory((imageData as Uint8List)).image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    null => Container(
                        decoration: const BoxDecoration(
                          borderRadius: AppComponents.defaultBorder,
                        ),
                        child: Center(
                          child: SelectImageButton(onTap: onImageUploadTap),
                        ),
                      ),
                    _ => Container(
                        decoration: const BoxDecoration(
                          borderRadius: AppComponents.defaultBorder,
                        ),
                        child: const Center(child: Text('Unknown image type')),
                      ),
                  },
                ),
                if (imageData case (String() || Uint8List()))
                  Positioned(
                    top: 5,
                    right: 5,
                    child: TightIconButtonWidget(
                      icon: const LocalAssetSVGIcon(
                        AppAssetImages.trashSVGLogoLine,
                        color: AppColors.errorColor,
                      ),
                      onTap: onImageDeleteTap,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/* <-------- multiple image input -------> */
class MultiImageUploadSectionWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final List<String> imageURLs;
  final void Function()? onImageUploadTap;
  final void Function(int index)? onImageTap;
  final void Function(int index)? onImageEditTap;
  final void Function(int index)? onImageDeleteTap;
  const MultiImageUploadSectionWidget({
    super.key,
    required this.label,
    this.isRequired = false,
    required this.imageURLs,
    this.onImageUploadTap,
    this.onImageEditTap,
    this.onImageDeleteTap,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.labelTextStyle,
            ),
            if (isRequired)
              Text(
                ' *',
                style: AppTextStyles.bodySemiboldTextStyle
                    .copyWith(color: AppColors.errorColor),
              )
          ],
        ),
        AppGaps.hGap16,
        MultiImageUploadWidget(
          imageURLs: imageURLs,
          onImageTap: onImageTap,
          onImageUploadTap: onImageUploadTap,
          onImageEditTap: onImageEditTap,
          onImageDeleteTap: onImageDeleteTap,
        ),
      ],
    );
  }
}

/* <-------- Multi Image Upload Widget -------> */
class MultiImageUploadWidget extends StatelessWidget {
  final List<String> imageURLs;
  final void Function()? onImageUploadTap;
  final void Function(int)? onImageTap;
  final void Function(int)? onImageEditTap;
  final void Function(int)? onImageDeleteTap;
  const MultiImageUploadWidget(
      {super.key,
      required this.imageURLs,
      this.onImageUploadTap,
      this.onImageEditTap,
      this.onImageDeleteTap,
      this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(18))),
      child: Builder(
          builder: (context) => imageURLs.isEmpty
              ? SelectImageButton(onTap: onImageUploadTap)
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == imageURLs.length) {
                      return SizedBox(
                          width: 180,
                          child: SelectImageButton(onTap: onImageUploadTap));
                    }
                    final imageURL = imageURLs[index];
                    return SizedBox(
                      width: 180,
                      child: SelectedNetworkImageWidget(
                        imageURL: imageURL,
                        onTap: onImageTap != null
                            ? () => onImageTap!(index)
                            : null,
                        onEditButtonTap: onImageEditTap != null
                            ? () => onImageEditTap!(index)
                            : null,
                        showDeleteButton: true,
                        onDeleteButtonTap: onImageDeleteTap != null
                            ? () => onImageDeleteTap!(index)
                            : null,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => AppGaps.wGap12,
                  itemCount: imageURLs.length + 1)),
    );
  }
}

/* <-------- Selected Network Image Widget -------> */
class SelectedNetworkImageWidget extends StatelessWidget {
  final String imageURL;
  final void Function()? onTap;
  final void Function()? onEditButtonTap;
  final bool showDeleteButton;
  final void Function()? onDeleteButtonTap;

  const SelectedNetworkImageWidget({
    super.key,
    required this.imageURL,
    this.onTap,
    this.onEditButtonTap,
    this.onDeleteButtonTap,
    this.showDeleteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 140,
      child: RawButtonWidget(
        borderRadiusValue: AppConstants.defaultBorderRadiusValue,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned.fill(
              child: CachedNetworkImageWidget(
                imageURL: imageURL,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: AppComponents.defaultBorder,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Builder(
                builder: (context) {
                  if (showDeleteButton) {
                    return Row(
                      children: [
                        TightIconButtonWidget(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onTap: onEditButtonTap),
                        AppGaps.wGap8,
                        TightIconButtonWidget(
                            icon: const Icon(Icons.delete_forever_outlined,
                                color: AppColors.errorColor),
                            onTap: onDeleteButtonTap),
                      ],
                    );
                  }
                  return TightIconButtonWidget(
                      icon: const LocalAssetSVGIcon(
                          AppAssetImages.arrowUpRightRedSVGLogoLine,
                          color: Colors.white),
                      onTap: onEditButtonTap);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BackArrowButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Color color;
  const BackArrowButtonWidget({
    super.key,
    this.onTap,
    this.color = AppColors.primaryButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return TightIconButtonWidget(
      onTap: onTap,
      icon: SizedBox.square(
        dimension: 24,
        child: SvgPictureAssetWidget(
          AppAssetImages.backButtonSVGLogoLine,
          color: color,
        ),
      ),
    );
  }
}
