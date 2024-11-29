import 'dart:developer';

import 'package:car2gouser/models/api_responses/get_wallet_details_response.dart';
import 'package:car2gouser/models/api_responses/wallet_details.dart';
import 'package:car2gouser/models/api_responses/wallet_history_response.dart';
import 'package:car2gouser/models/core_api_responses/api_response.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WalletScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  bool isAddedCard = true;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  WalletDetails walletDetails = WalletDetails.empty();
  // PagingController<int, TransactionHistoryItems> transactionHistoryPagingController = PagingController(firstPageKey: 1);
/* <---- Get Transaction History from API ----> */
/*   Future<void> getTransactionHistory(int currentPageNumber) async {
    WalletTransactionHistoryResponse? response =
        await APIRepo.getTransactionHistory(currentPageNumber);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetChatUsersList(response);
  }

  void onSuccessGetChatUsersList(WalletTransactionHistoryResponse response) {
    transactionHistoryPagingController.appendLastPage(response.data.docs);
    return;
  } */
/* <---- Get wallet details from API  ----> */

  Future<void> getWalletDetails() async {
    isLoading = true;
    final response = await APIRepo.getWalletDetailsUpdated();
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.message);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);
      return;
    }
    log((response
        .toJson(
          (data) => data.toJson(),
        )
        .toString()));
    walletDetails = response.data;
    update();
  }

  /* <---- Initial state ----> */

  @override
  void onInit() {
    getWalletDetails();
    // transactionHistoryPagingController.addPageRequestListener((pageKey) { getTransactionHistory(pageKey); });
    super.onInit();
  }
}
