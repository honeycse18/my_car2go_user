import 'package:car2gouser/models/api_responses/dashboard_police_response.dart';
import 'package:car2gouser/models/api_responses/faq_response.dart';
import 'package:car2gouser/models/api_responses/faq_response_updated.dart';
import 'package:car2gouser/models/core_api_responses/api_list_response.dart';
import 'package:car2gouser/utils/constants/app_language_translations.dart';
import 'package:car2gouser/utils/extensions/string.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:car2gouser/utils/helpers/api_repo.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqaScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  PoliceData faqData = PoliceData.empty();
  List<FaqResponseUpdated> faqs = [];

  // PagingController<int, FaqItems> faqPagingController =
  //     PagingController(firstPageKey: 1);

  /*<-----------Get FAQA item list from API ----------->*/

  Future<void> getFaqItemList() async {
    final response = await APIRepo.getFaqs();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);

      return;
    } else if (response.error) {
      APIHelper.onFailure(response.message);

      return;
    }
    onSuccessGetFaqs(response);
  }

  void onSuccessGetFaqs(APIListResponse<FaqResponseUpdated> response) {
    // final isLastPage = !response.data.hasNextPage;
    // if (isLastPage) {
    //   faqPagingController.appendLastPage(response.data.docs);
    //   return;
    // }
    // final nextPageNumber = response.data.page + 1;
    // faqPagingController.appendPage(response.data.docs, nextPageNumber);
    faqs = response.data;
    update();
  }
  /*<-----------Get dashboard details from API ----------->*/

  Future<void> getDashBoardDetails() async {
    DashboardEmergencyDataResponse? response =
        await APIRepo.getDashBoardEmergencyDataDetails();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    _onSuccessGetDashBoard(response);
  }

  void _onSuccessGetDashBoard(DashboardEmergencyDataResponse response) async {
    faqData = response.data;
    update();
  }

/*   Future<void> launchMailApp(String emailAddress) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  } */

  void onWhatsappTap() {}
/* <---- Initial state ----> */

  @override
  void onInit() {
    getDashBoardDetails();
    //faqPagingController.addPageRequestListener((pageKey) {});
    getFaqItemList();

    super.onInit();
  }
}
