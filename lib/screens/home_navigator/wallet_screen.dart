import 'package:car2gouser/controller/menu_screen_controller/wallet_screen_controller.dart';
import 'package:car2gouser/models/api_responses/wallet_history_response.dart';
import 'package:car2gouser/models/enums/wallet_transaction/wallet_transaction_by.dart';
import 'package:car2gouser/models/enums/wallet_transaction/wallet_transaction_from.dart';
import 'package:car2gouser/models/enums/wallet_transaction/wallet_transaction_mode.dart';
import 'package:car2gouser/models/enums/wallet_transaction/wallet_transaction_status.dart';
import 'package:car2gouser/models/enums/wallet_transaction/wallet_transaction_type.dart';
import 'package:car2gouser/screens/bottomsheet_screen/delete_card_bottomsheet.dart';
import 'package:car2gouser/screens/bottomsheet_screen/edit_card_bottomsheet.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/double.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:car2gouser/widgets/core_widgets/spaces.dart';
import 'package:car2gouser/widgets/screen_widget/add_new_card_widget.dart';
import 'package:car2gouser/widgets/screen_widget/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<WalletScreenController>(
        init: WalletScreenController(),
        global: true,
        builder: (controller) => RefreshIndicator(
              onRefresh: () async => controller.getWalletDetails(),
              child: Stack(alignment: Alignment.topCenter, children: [
                Positioned(
                  top: -2,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.262,
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
                        padding: const EdgeInsets.only(top: 118),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
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
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: CustomScrollView(
                                    slivers: [
                                      const SliverToBoxAdapter(
                                          child: AppGaps.hGap94),
                                      SliverToBoxAdapter(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          width: 1.5,
                                                          color: AppColors
                                                              .primaryColor)),
                                                  /*<----------Withdraw Button in wallet screen--------------->*/
                                                  child: RawButtonWidget(
                                                      borderRadiusValue: 10.0,
                                                      backgroundColor: AppColors
                                                          .primaryButtonColor,
                                                      onTap: () async {
                                                        await Get.toNamed(
                                                            AppPageNames
                                                                .topUpScreen);
                                                        controller.update();
                                                        controller
                                                            .getWalletDetails();
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const SvgPictureAssetWidget(
                                                            AppAssetImages
                                                                .topUpSVGLogoLine,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                          AppGaps.wGap10,
                                                          Center(
                                                            child: Text(
                                                              AppLanguageTranslation
                                                                  .topUpTransKey
                                                                  .toCurrentLanguage,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: AppTextStyles
                                                                  .labelTextStyle
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .primaryColor),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            ]),
                                      ),
                                      const SliverToBoxAdapter(
                                          child: AppGaps.hGap32),
                                      SliverToBoxAdapter(
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Payment Method',
                                            style: AppTextStyles
                                                .titleSemiSmallSemiboldTextStyle
                                                .copyWith(
                                                    color:
                                                        AppColors.primaryColor),
                                          ),
                                        ),
                                      ),
                                      const SliverToBoxAdapter(
                                          child: AppGaps.hGap16),
                                      if (!controller.isAddedCard) ...[
                                        SliverToBoxAdapter(
                                            child: AddNewCardWidget()),
                                      ],

                                      if (controller.isAddedCard) ...[
                                        SliverToBoxAdapter(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: AddedNewCardWidget(
                                                    cardName: 'Liton Nandi',
                                                    cardNumber:
                                                        '**888888888888',
                                                    img: AppAssetImages
                                                        .moneyIconImage,
                                                  )),
                                                ],
                                              ),
                                              AppGaps.hGap24,
                                              Align(
                                                  alignment: Alignment.topLeft,
                                                  child: RawButtonWidget(
                                                    onTap: () {
                                                      Get.toNamed(
                                                        AppPageNames
                                                            .addCardScreen,
                                                      );
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            AppAssetImages
                                                                .plusIconSVGLogoLine),
                                                        Text(
                                                          'Add New Card',
                                                          style: AppTextStyles
                                                              .semiSmallXBoldTextStyle
                                                              .copyWith(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],

                                      //                    Expanded(
                                      //     child: RefreshIndicator(
                                      //   onRefresh: () async {
                                      //     controller.getWithdrawMethod();
                                      //     controller.update();
                                      //   },
                                      //   child: CustomScrollView(
                                      //     slivers: [
                                      //       controller.withdrawMethod.isNotEmpty
                                      //           ? SliverList.separated(
                                      //               itemCount: controller.withdrawMethod.length,
                                      //               itemBuilder: (context, index) {
                                      //                 final withdrawOption =
                                      //                     controller.withdrawMethod[index];
                                      //                 return SelectWithdrawMethodWidget(
                                      //                   paymentOptionImage:
                                      //                       withdrawOption.type.logo,
                                      //                   cancelReason: withdrawOption,
                                      //                   selectedCancelReason: controller
                                      //                       .selectedSavedWithdrawMethod,
                                      //                   paymentOption: withdrawOption.type.name,
                                      //                   hasShadow: controller
                                      //                           .selectedwithdrawMethodIndex ==
                                      //                       index,
                                      //                   onTap: () {
                                      //                     controller.selectedwithdrawMethodIndex =
                                      //                         index;
                                      //                     controller.selectedSavedWithdrawMethod =
                                      //                         withdrawOption;
                                      //                     controller.update();
                                      //                   },
                                      //                   radioOnChange: (Value) {
                                      //                     controller.selectedwithdrawMethodIndex =
                                      //                         index;
                                      //                     controller.selectedSavedWithdrawMethod =
                                      //                         withdrawOption;
                                      //                     controller.update();
                                      //                   },
                                      //                   index: index,
                                      //                   selectedPaymentOptionIndex: controller
                                      //                       .selectedwithdrawMethodIndex,
                                      //                 );
                                      //               },
                                      //               separatorBuilder: (context, index) =>
                                      //                   AppGaps.hGap16,
                                      //             )
                                      //           : const SliverToBoxAdapter(
                                      //               child: Center(
                                      //                 child: Text('No Withdraw Method Found'),

                                      //               ),
                                      //             ),
                                      //     ],
                                      //   ),
                                      // )),

                                      const SliverToBoxAdapter(
                                          child: AppGaps.hGap24),
                                      SliverToBoxAdapter(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                AppLanguageTranslation
                                                    .transactionsHistoryTransKey
                                                    .toCurrentLanguage,
                                                style: AppTextStyles
                                                    .titleBoldTextStyle),
                                            Container(
                                              alignment: Alignment.bottomCenter,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(AppPageNames
                                                      .transactionHistoryScreen);
                                                },

                                                /*<-----All transaction history----->*/
                                                child: RichText(
                                                  text: TextSpan(
                                                      text:
                                                          AppLanguageTranslation
                                                              .seeAllTransKey
                                                              .toCurrentLanguage,
                                                      style: AppTextStyles
                                                          .bodySemiboldTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .primaryColor)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SliverToBoxAdapter(
                                          child: AppGaps.hGap10),
                                      /*<------ You Have no transaction yet----->*/
                                      controller.isLoading
                                          ? SliverToBoxAdapter()
                                          : controller.walletDetails
                                                  .transactions.isEmpty
                                              ? SliverToBoxAdapter(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      /* <---- Empty transaction history ----> */
                                                      EmptyScreenWidget(
                                                        localImageAssetURL:
                                                            AppAssetImages
                                                                .confirmIconImage,
                                                        title: AppLanguageTranslation
                                                            .noTransactionTransKey
                                                            .toCurrentLanguage,
                                                        shortTitle:
                                                            AppLanguageTranslation
                                                                .youHaveNoTransactionYetTransKey
                                                                .toCurrentLanguage,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : SliverList.separated(
                                                  itemCount: controller
                                                      .walletDetails
                                                      .transactions
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final transactionHistoryList =
                                                        controller.walletDetails
                                                                .transactions[
                                                            index];
                                                    /*<------transaction message----->*/
                                                    return TransactionListWidget(
                                                      dateTime:
                                                          transactionHistoryList
                                                              .createdAt,
                                                      amount:
                                                          transactionHistoryList
                                                              .amount,
                                                      by: transactionHistoryList
                                                          .byAsEnum,
                                                      from:
                                                          transactionHistoryList
                                                              .fromAsEnum,
                                                      mode:
                                                          transactionHistoryList
                                                              .modeAsEnum,
                                                      status:
                                                          transactionHistoryList
                                                              .statusAsEnum,
                                                      type:
                                                          transactionHistoryList
                                                              .typeAsEnum,
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          AppGaps.hGap16),
                                      const SliverToBoxAdapter(
                                        child: AppGaps.hGap80,
                                      ),
                                      const SliverToBoxAdapter(
                                          child: AppGaps.hGap10),
                                    ],
                                  ),
                                ))))),

                /*<-----------Transaction status and Wallet balance------>*/
                Positioned(
                  top: 30,
                  child: ScaffoldBodyWidget(
                    child: Container(
                      height: screenHeight * 0.2,
                      width: screenWidth * 0.88,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image:
                                  AssetImage(AppAssetImages.transactionStatus),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
/*                               Text(
                                controller.walletDetails.currency.symbol,
                                style: AppTextStyles
                                    .titleExtraLargeBoldTextStyle
                                    .copyWith(
                                        color: AppColors.primaryButtonColor),
                              ), */
                              AppGaps.wGap10,
                              Text(
                                controller.walletDetails.currentBalance.total
                                    .getCurrencyFormattedText(),
                                style: AppTextStyles
                                    .titleExtraLargeBoldTextStyle
                                    .copyWith(
                                        color: AppColors.primaryButtonColor),
                              ),
                            ],
                          ),
                          AppGaps.hGap6,
                          Text(
                            AppLanguageTranslation
                                .walletBalanceTransKey.toCurrentLanguage,
                            style: AppTextStyles.notificationBoldDateSection
                                .copyWith(color: AppColors.primaryButtonColor),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
              ]),
            ));
  }
}

/* <-------- Transaction Widget-------> */

class TransactionListWidget extends StatelessWidget {
  // final String title;
  // final String text1;
  // final String text2;
  // final String type;
  final DateTime dateTime;
  final void Function()? onTap;
  final WalletTransactionStatus status;
  final WalletTransactionFrom from;
  final WalletTransactionBy by;
  final WalletTransactionType type;
  final WalletTransactionMode mode;
  final double amount;
  const TransactionListWidget({
    super.key,
    // required this.title,
    // required this.text1,
    // required this.text2,
    required this.type,
    required this.dateTime,
    this.onTap,
    this.status = WalletTransactionStatus.unknown,
    this.from = WalletTransactionFrom.unknown,
    this.by = WalletTransactionBy.unknown,
    this.mode = WalletTransactionMode.unknown,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      borderRadiusValue: 8,
      onTap: onTap,
      child: Container(
        height: 56,
        width: 392,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.bodyTextColor)),
        child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10),
            child: TransactionWidget(
              dateTime: dateTime,
              title: title,
              icon: icon,
              backColor: iconBackgroundColor,
              text1: statusText,
              text2: amount.getCurrencyFormattedText(),
            )),
      ),
    );
  }

  String get title => switch (mode) {
        WalletTransactionMode.deposit => switch (from) {
            WalletTransactionFrom.topUp => 'Top up',
            // _ => '',
            _ => from.viewableTextTransKey.toCurrentLanguage,
          },
        WalletTransactionMode.expense => switch (type) {
            WalletTransactionType.subscription => 'Subscription',
            // _ => '',
            _ => type.viewableTextTransKey.toCurrentLanguage,
          },
        _ => '',
      };

  Widget get icon => switch (mode) {
        WalletTransactionMode.deposit => const SvgPictureAssetWidget(
            AppAssetImages.arrowUpRightSVGLogoLine,
            color: AppColors.successColor),
        WalletTransactionMode.expense => const SvgPictureAssetWidget(
            AppAssetImages.arrowDownRightRedSVGLogoLine,
            color: AppColors.errorColor),
        _ => const SizedBox.shrink(),
      };

  Color get iconBackgroundColor => switch (mode) {
        WalletTransactionMode.deposit => AppColors.walletAddMoneyColor,
        WalletTransactionMode.expense => AppColors.walletWithdrawMoneyColor,
        _ => Colors.white,
      };

  String get statusText => switch (status) {
        WalletTransactionStatus.pending => WalletTransactionStatus
            .pending.viewableTextTransKey.toCurrentLanguage,
        _ => status.viewableTextTransKey.toCurrentLanguage,
      };
}
