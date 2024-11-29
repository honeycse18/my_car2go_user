// import 'package:car2gouser/controller/introscreen_controller.dart';
import 'package:car2gouser/controller/menu_screen_controller/transaction_history_screen_controller.dart';
import 'package:car2gouser/models/api_responses/wallet_details.dart';
import 'package:car2gouser/models/api_responses/wallet_history_response.dart';
import 'package:car2gouser/screens/home_navigator/wallet_screen.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_gaps.dart';
import 'package:car2gouser/utils/constants/app_images.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/constants/app_text_styles.dart';
import 'package:car2gouser/utils/extensions/datetime.dart';
import 'package:car2gouser/utils/extensions/double.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  var valueChoose = "-1";
    return GetBuilder<TransactionHistoryScreenController>(
      init: TransactionHistoryScreenController(),
      global: false,
      builder: (controller) => CustomScaffold(
        /*<------- AppBar  ------>*/
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText:
              AppLanguageTranslation.allTransactionTransKey.toCurrentLanguage,
          hasBackButton: true,
        ),
        /*<------- Body Content ------>*/
        body: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Column(
            children: [
              Expanded(
                child: ScaffoldBodyWidget(
                    child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                        child: Row(
                      children: [
                        Text(
                          AppLanguageTranslation
                              .transactionsHistoryTransKey.toCurrentLanguage,
                          style: AppTextStyles.titleSemiSmallSemiboldTextStyle
                              .copyWith(color: AppColors.primaryColor),
                        ),
                        AppGaps.wGap10,
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: DropdownButton<String>(
                            value: controller.selectedFilter.value,
                            icon: Icon(Icons.arrow_drop_down,
                                size: 16), // Small arrow icon
                            underline: SizedBox(), // Remove the underline
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.updateFilter(newValue);
                                controller.update();
                              }
                            },
                            items: <String>[
                              'All',
                              'Pending',
                              'Success',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),

                            hint: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "All",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down, size: 16),
                              ],
                            ),
                          ),
                        )),
                      ],
                    )),
/*                     SliverToBoxAdapter(
                      child: TransactionListWidget(
                        dateTime: DateTime.now(),
                        title: 'Add money',
                        text1: 'Pending',
                        text2: '\$40.00',
                        type: 'pending',
                      ),
                    ), */
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap20,
                    ),
                    PagedSliverList.separated(
                      pagingController:
                          controller.transactionHistoryPagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<WalletTransaction>(
                              noItemsFoundIndicatorBuilder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /*<------- Empty transaction history ------>*/
                            EmptyScreenWidget(
                                localImageAssetURL:
                                    AppAssetImages.confirmIconImage,
                                title: AppLanguageTranslation
                                    .youHaveNoTransactionHistoryTransKey
                                    .toCurrentLanguage,
                                shortTitle: '')
                          ],
                        );
                      }, itemBuilder: (context, item, index) {
                        final transactionHistoryList = item;
                        return TransactionListWidget(
                          dateTime: transactionHistoryList.createdAt,
                          amount: transactionHistoryList.amount,
                          by: transactionHistoryList.byAsEnum,
                          from: transactionHistoryList.fromAsEnum,
                          mode: transactionHistoryList.modeAsEnum,
                          status: transactionHistoryList.statusAsEnum,
                          type: transactionHistoryList.typeAsEnum,
                        );
                      }),
                      separatorBuilder: (context, index) => AppGaps.hGap16,
                    )
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
