import 'dart:developer';

import 'package:car2gouser/models/api_responses/wallet_details.dart';
import 'package:car2gouser/models/api_responses/wallet_history_response.dart';
import 'package:car2gouser/models/core_api_responses/api_response.dart';
import 'package:car2gouser/models/core_api_responses/paginated_data_response.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionHistoryScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  String symbol = '';
  PagingController<int, WalletTransaction> transactionHistoryPagingController =
      PagingController(firstPageKey: 1);
/* <---- Get Transaction History from API ----> */

  var selectedFilter = 'All'.obs; // Default value

  void updateFilter(String filter) {
    selectedFilter.value = filter;
  }

  Future<void> getTransactionHistory(int currentPageNumber) async {
    final response = await APIRepo.getWalletTransactionHistoryUpdated(
        queries: {'page': currentPageNumber.toString()});
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    _onSuccessGetChatUsersList(response);
  }

  void _onSuccessGetChatUsersList(
      APIResponse<PaginatedDataResponse<WalletTransaction>> response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      transactionHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    transactionHistoryPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }
/*<----------- Fetch screen navigation argument----------->*/

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      symbol = argument;
      update();
    }
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameters();
    transactionHistoryPagingController.addPageRequestListener((pageKey) {
      getTransactionHistory(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    transactionHistoryPagingController.dispose();
    super.onClose();
  }
}
