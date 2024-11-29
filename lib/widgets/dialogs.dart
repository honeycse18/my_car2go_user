import 'dart:typed_data';

import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:car2gouser/widgets/screen_widget/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class AppDialogs {
  /*<------- Success dialog ------>*/
  static Future<Object?> showSuccessDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.successTransKey.toCurrentLanguage;
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.successImage),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: AppColors.successColor),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomDialogButtonWidget(
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.okTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

  static Future<Object?> showTopUpSuccessDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.successTransKey.toCurrentLanguage;
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.topupSuccessImage),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: AppColors.primaryColor),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeTextStyle
              .copyWith(color: AppColors.secondaryTextColor)),
      actionWidgets: [
        CustomStretchedButtonWidget(
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.goHomeTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

/*<------- Password change success dialog ------>*/
  static Future<Object?> showPassChangedSuccessDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle = titleText ??
        AppLanguageTranslation.successfullyChangedTransKey.toCurrentLanguage;
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: AppColors.successColor),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomDialogButtonWidget(
            onTap: () {
              Get.back();
            },
            child: Text(AppLanguageTranslation.loginTransKey.toCurrentLanguage))
      ],
    ));
  }

/*<------- Error Dialog ------>*/
  static Future<Object?> showErrorDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.sorryTransKey.toCurrentLanguage;
    /*<------- Vibrate the phone ------>*/
    final hasVibrator = await Vibration.hasVibrator();

    /*<------- Check if hasVibrator is not null and is true ------>*/
    if (hasVibrator == true) {
      /*<------- Vibrate for 500 milliseconds ------>*/
      Vibration.vibrate(duration: 500);
    }
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.errorImage),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: Colors.red),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomDialogButtonWidget(
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.okTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

/*<------- Expire dialog ------>*/
  static Future<Object?> showExpireDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.sorryTransKey.toCurrentLanguage;

    final hasVibrator = await Vibration.hasVibrator();

    /*<------- Check if hasVibrator is not null and is true ------>*/
    if (hasVibrator == true) {
      Vibration.vibrate(duration: 500);
    }
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: Colors.red),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomDialogButtonWidget(
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.loginTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

/*<-------  Share Ride success dialog------>*/
  static Future<Object?> shareRideSuccessDialog({
    String? titleText,
    required String messageText,
    required Future<void> Function() homeButtonTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? homeButtonText,
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: Colors.white,
        titleWidget: Column(
          children: [
            Image.asset(
              AppAssetImages.paymentSuccessDialougIconImage,
              color: AppColors.primaryColor,
            ),
            AppGaps.hGap16,
            Center(
              child: Text(
                  titleText ??
                      AppLanguageTranslation
                          .yourRequestSendSuccessfulTranskey.toCurrentLanguage,
                  style: AppTextStyles.titleSmallSemiboldTextStyle,
                  textAlign: TextAlign.center),
            ),
          ],
        ),
        contentWidget: Text(messageText,
            style: AppTextStyles.bodyLargeSemiboldTextStyle,
            textAlign: TextAlign.center),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: homeButtonText ??
                      AppLanguageTranslation.goHomeTransKey.toCurrentLanguage,
                  onTap: () async {
                    await homeButtonTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

/*<------- Confirm dialog ------>*/
  static Future<Object?> showConfirmDialog({
    String? titleText,
    required String messageText,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: Colors.white,
        titleWidget: Column(
          children: [
            Image.asset(AppAssetImages.confirmImage),
            AppGaps.hGap16,
            Text(
                titleText ??
                    AppLanguageTranslation.confirmTransKey.toCurrentLanguage,
                style: AppTextStyles.titleSmallSemiboldTextStyle
                    .copyWith(color: const Color(0xFF3B82F6)),
                textAlign: TextAlign.center),
          ],
        ),
        contentWidget: Text(
          messageText,
          style: AppTextStyles.bodyLargeSemiboldTextStyle,
          textAlign: TextAlign.center,
        ),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedOutlinedTextButtonWidget(
                  buttonText: noButtonText ??
                      AppLanguageTranslation.noTransKey.toCurrentLanguage,
                  onTap: onNoTap ??
                      () {
                        Get.back();
                      },
                ),
              ),
              AppGaps.wGap12,
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: yesButtonText ??
                      AppLanguageTranslation.yesTransKey.toCurrentLanguage,
                  onTap: () async {
                    await onYesTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

/*<------- Actionable dialog ------>*/
  static Future<Object?> showActionableDialog(
      {String? titleText,
      required String messageText,
      Color titleTextColor = AppColors.errorColor,
      String? buttonText,
      int? waitTime,
      bool barrierDismissible = true,
      void Function()? onTap}) async {
    return await Get.dialog(
        barrierDismissible: barrierDismissible,
        AlertDialogWidget(
          backgroundColor: AppColors.errorColor,
          titleWidget: Text(
              titleText ??
                  AppLanguageTranslation.errorTransKey.toCurrentLanguage,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: titleTextColor),
              textAlign: TextAlign.center),
          contentWidget: Text(messageText,
              style: AppTextStyles.bodyLargeSemiboldTextStyle),
          actionWidgets: [
            CustomStretchedTextButtonWidget(
              buttonText: buttonText ??
                  AppLanguageTranslation.okTransKey.toCurrentLanguage,
              onTap: onTap,
            )
          ],
        ));
  }

  static Future<Object?> showScheduleRideDialog(
      {String? titleText,
      required String messageText,
      Color titleTextColor = AppColors.errorColor,
      String? buttonText,
      int? waitTime,
      bool barrierDismissible = true,
      void Function()? onTap}) async {
    return await Get.dialog(
        barrierDismissible: barrierDismissible,
        ScheduleRideAlertDialogWidget(
          backgroundColor: Colors.white,
          titleWidget: Text(
              titleText ??
                  AppLanguageTranslation.errorTransKey.toCurrentLanguage,
              style: AppTextStyles.semiSmallXBoldTextStyle
                  .copyWith(color: titleTextColor),
              textAlign: TextAlign.center),
          contentWidget: Container(
            height: 320,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.dialogColor),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('dfgjksdhgsgh',
                          style: AppTextStyles.bodyLargeSemiboldTextStyle),
                    ),
                  ),
                ),
                AppGaps.hGap16,
                LocationDetailsWidget(
                  pickupLocation: 'Pickup Location',
                  dropLocation: 'Drop Location',
                  distance: 'Distance',
                ),
                AppGaps.hGap16,
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12.0),
                  child: CustomStretchedTextButtonWidget(
                    buttonText: buttonText ??
                        AppLanguageTranslation.okTransKey.toCurrentLanguage,
                    onTap: onTap,
                  ),
                )
              ],
            ),
          ),
          // actionWidgets: [
          //   CustomStretchedTextButtonWidget(
          //     buttonText: buttonText ??
          //         AppLanguageTranslation.okTransKey.toCurrentLanguage,
          //     onTap: onTap,
          //   )
          // ],
        ));
  }

/*<------- Confirm payment dialog ------>*/
  static Future<Object?> showConfirmPaymentDialog({
    String titleText = '',
    required double amount,
    required double totalAmount,
    required String symbol,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String noButtonText = 'Cancel',
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: AppColors.backgroundColor,
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGaps.hGap16,
            Center(
              child: Text(titleText,
                  style: AppTextStyles.titleSmallSemiboldTextStyle
                      .copyWith(color: const Color(0xFF3B82F6)),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
        contentWidget: Row(
          children: [
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(24),
              height: 185,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment Details',
                    style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                  ),
                  AppGaps.hGap8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount',
                        style: AppTextStyles.bodyLargeMediumTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      Row(
                        children: [
                          Text(symbol,
                              style: AppTextStyles.bodyLargeMediumTextStyle
                                  .copyWith(color: AppColors.bodyTextColor)),
                          AppGaps.wGap4,
                          Text(amount.toStringAsFixed(2),
                              style: AppTextStyles.bodyLargeMediumTextStyle
                                  .copyWith(color: AppColors.bodyTextColor)),
                        ],
                      ),
                    ],
                  ),
                  AppGaps.hGap8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount',
                        style: AppTextStyles.bodyLargeMediumTextStyle
                            .copyWith(color: AppColors.errorColor),
                      ),
                      Row(
                        children: [
                          Text(symbol,
                              style: AppTextStyles.bodyLargeMediumTextStyle
                                  .copyWith(color: AppColors.errorColor)),
                          AppGaps.wGap4,
                          Text(0.toStringAsFixed(2),
                              style: AppTextStyles.bodyLargeMediumTextStyle
                                  .copyWith(color: AppColors.errorColor)),
                        ],
                      ),
                    ],
                  ),
                  AppGaps.hGap12,
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 1,
                        decoration: const BoxDecoration(
                            color: AppColors.fromBorderColor),
                      ))
                    ],
                  ),
                  AppGaps.hGap12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Grand Total',
                        style: AppTextStyles.bodyBoldTextStyle,
                      ),
                      Row(
                        children: [
                          Text(symbol, style: AppTextStyles.bodyBoldTextStyle),
                          AppGaps.wGap4,
                          Text(totalAmount.toStringAsFixed(2),
                              style: AppTextStyles.bodyBoldTextStyle),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedOutlinedTextButtonWidget(
                  buttonText: noButtonText,
                  onTap: onNoTap ??
                      () {
                        Get.back();
                      },
                ),
              ),
              AppGaps.wGap12,
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: yesButtonText ?? 'Confirm To Pay',
                  onTap: () async {
                    await onYesTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

/*<------- Image processing dialog ------>*/
  static Future<Object?> showImageProcessingDialog() async {
    return await Get.dialog(
        AlertDialogWidget(
          titleWidget: Text(
              AppLanguageTranslation.imageProcessingTransKey.toCurrentLanguage,
              style: AppTextStyles.headlineLargeBoldTextStyle,
              textAlign: TextAlign.center),
          contentWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              AppGaps.hGap16,
              Text(AppLanguageTranslation.pleaseWaitTransKey.toCurrentLanguage),
            ],
          ),
        ),
        barrierDismissible: false);
  }
  /*<------- Processing Dialog ------>*/

  static Future<Object?> showProcessingDialog({String? message}) async {
    return await Get.dialog(
        AlertDialogWidget(
          titleWidget: Text(
              message ??
                  AppLanguageTranslation.processingTransKey.toCurrentLanguage,
              style: AppTextStyles.headlineLargeBoldTextStyle,
              textAlign: TextAlign.center),
          contentWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              AppGaps.hGap16,
              Text(AppLanguageTranslation.pleaseWaitTransKey.toCurrentLanguage),
            ],
          ),
        ),
        barrierDismissible: false);
  }

  static Future<dynamic> showSingleImageUploadConfirmDialog({
    String? titleText,
    required Uint8List selectedImageData,
    required String messageText,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: Colors.white,
        titleWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox( height: 120, child: Image.asset(AppAssetImages.confirmImage)),
            // AppGaps.hGap16,
            Text(titleText ?? 'Confirmation',
                style: AppTextStyles.titleSmallSemiboldTextStyle
                    .copyWith(color: const Color(0xFF3B82F6)),
                textAlign: TextAlign.center),
          ],
        ),
        contentWidget: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 64,
                width: 80,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image:
                              Image.memory(selectedImageData, fit: BoxFit.cover)
                                  .image,
                          fit: BoxFit.cover)),
                )),
            const VerticalGap(8),
            Text(messageText,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLargeSemiboldTextStyle),
          ],
        ),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedOutlinedTextButtonWidget(
                  buttonText: noButtonText ??
                      AppLanguageTranslation.noTransKey.toCurrentLanguage,
                  onTap: onNoTap ??
                      () {
                        Get.back();
                      },
                ),
              ),
              AppGaps.wGap12,
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: yesButtonText ??
                      AppLanguageTranslation.yesTransKey.toCurrentLanguage,
                  onTap: () async {
                    await onYesTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future<dynamic> showMultipleImageUploadConfirmDialog({
    String? titleText,
    required List<Uint8List?> selectedImageData,
    required String messageText,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: Colors.white,
        titleWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox( height: 120, child: Image.asset(AppAssetImages.confirmImage)),
            // AppGaps.hGap16,
            Text(titleText ?? 'Confirmation',
                style: AppTextStyles.titleSmallSemiboldTextStyle
                    .copyWith(color: const Color(0xFF3B82F6)),
                textAlign: TextAlign.center),
          ],
        ),
        contentWidget: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(builder: (context) {
              return SizedBox(
                  height: 64,
                  width: context.width * 0.7,
                  // width: 200,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final imageData = selectedImageData[index];
                        return Container(
                          height: 64,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: imageData == null
                                      ? Image.asset(AppAssetImages
                                              .imagePlaceholderIconImage)
                                          .image
                                      : Image.memory(imageData,
                                              fit: BoxFit.cover)
                                          .image,
                                  fit: BoxFit.cover)),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const HorizontalGap(10),
                      itemCount: selectedImageData.length));
            }),
            const VerticalGap(8),
            Text(messageText,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLargeSemiboldTextStyle),
          ],
        ),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedOutlinedTextButtonWidget(
                  buttonText: noButtonText ??
                      AppLanguageTranslation.noTransKey.toCurrentLanguage,
                  onTap: onNoTap ??
                      () {
                        Get.back();
                      },
                ),
              ),
              AppGaps.wGap12,
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: yesButtonText ??
                      AppLanguageTranslation.yesTransKey.toCurrentLanguage,
                  onTap: () async {
                    await onYesTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }
}
