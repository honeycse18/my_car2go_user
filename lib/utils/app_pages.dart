import 'package:car2gouser/screens/accept_ride_request_screen.dart';
import 'package:car2gouser/screens/add_location_screen.dart';
import 'package:car2gouser/screens/auth/login_password_screen.dart';
import 'package:car2gouser/screens/auth/login_screen.dart';
import 'package:car2gouser/screens/auth/verification_screen.dart';
import 'package:car2gouser/screens/car_pooling/cancel_ride_reason.dart';
import 'package:car2gouser/screens/car_pooling/choose_you_need_screen.dart';
import 'package:car2gouser/screens/car_pooling/pooling_request_details_screen.dart';
import 'package:car2gouser/screens/car_pooling/pooling_request_screen.dart';
import 'package:car2gouser/screens/car_pooling/view_request_screen.dart';
import 'package:car2gouser/screens/chat_screen.dart';
import 'package:car2gouser/screens/home_navigator/add_card_screen.dart';
import 'package:car2gouser/screens/home_navigator/picked_location_screen.dart';
import 'package:car2gouser/screens/image_zoom.dart';
import 'package:car2gouser/screens/intro_screen.dart';
import 'package:car2gouser/screens/menu_screen_pages/add_coupon_page.dart';
import 'package:car2gouser/screens/menu_screen_pages/car_pooling_history_screen.dart';
import 'package:car2gouser/screens/menu_screen_pages/contact_us_.dart';
import 'package:car2gouser/screens/menu_screen_pages/faqa_screen.dart';
import 'package:car2gouser/screens/menu_screen_pages/languagescreen/language_screen.dart';
import 'package:car2gouser/screens/menu_screen_pages/about_us.dart';
import 'package:car2gouser/screens/menu_screen_pages/change_password_screen.dart';
import 'package:car2gouser/screens/menu_screen_pages/apply_coupon_page.dart';
import 'package:car2gouser/screens/menu_screen_pages/delete_account.dart';
import 'package:car2gouser/screens/menu_screen_pages/help_support.dart';
import 'package:car2gouser/screens/menu_screen_pages/notification_screen.dart';
import 'package:car2gouser/screens/menu_screen_pages/password_change_success_screen.dart';
import 'package:car2gouser/screens/menu_screen_pages/privacy_policy_screen.dart';
import 'package:car2gouser/screens/menu_screen_pages/settings_screen.dart';
import 'package:car2gouser/screens/menu_screen_pages/terms_and_condition_screen.dart';
import 'package:car2gouser/screens/menu_screen_pages/transaction_history_screen.dart';
import 'package:car2gouser/screens/home_navigator/wallet_screen.dart';
import 'package:car2gouser/screens/menu_screen_pages/use_coupon_page.dart';
import 'package:car2gouser/screens/menu_screen_pages/withrow_screen.dart';
import 'package:car2gouser/screens/profile_screen.dart';
import 'package:car2gouser/screens/pooling_offerdetails_screen.dart';
import 'package:car2gouser/screens/registration/Signup_screen.dart';
import 'package:car2gouser/screens/registration/create_new_password_screen.dart';
import 'package:car2gouser/screens/saved_location_screen.dart';
import 'package:car2gouser/screens/select_car_screen.dart';
import 'package:car2gouser/screens/select_location_screen.dart';
import 'package:car2gouser/screens/car_pooling/ride_share_screen.dart';
import 'package:car2gouser/screens/select_payment_methods_screen.dart';
import 'package:car2gouser/screens/splash_screen.dart';
import 'package:car2gouser/screens/topup_screen.dart';
import 'package:car2gouser/screens/unknownScreen.dart';
import 'package:car2gouser/screens/zoom_drawer_screen.dart';
import 'package:car2gouser/utils/constants/app_page_names.dart';
import 'package:get/get.dart';

/*<-------All page route-------->*/
class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage(name: AppPageNames.rootScreen, page: () => const SplashScreen()),
    GetPage(
        name: AppPageNames.notificationScreen,
        page: () => const NotificationScreen()),
    GetPage(
        name: AppPageNames.deleteAccount,
        page: () => const DeleteAccountScreen()),
    GetPage(
        name: AppPageNames.applyCouponScreen,
        page: () => const ApplyCouponScreen()),
    GetPage(
        name: AppPageNames.useCouponScreen,
        page: () => const UseCouponScreen()),
    GetPage(
        name: AppPageNames.addCouponScreen,
        page: () => const AddCouponScreen()),
    GetPage(name: AppPageNames.settings, page: () => const SettingsScreen()),
    GetPage(
        name: AppPageNames.withrowScreen, page: () => const WithdrawScreen()),
    GetPage(
        name: AppPageNames.addLocationScreen,
        page: () => const AddLocationScreen()),
    GetPage(
        name: AppPageNames.transactionHistoryScreen,
        page: () => const TransactionHistoryScreen()),
    GetPage(
      name: AppPageNames.termsConditionScreen,
      page: () => const TermsConditionScreen(),
    ),
    GetPage(
      name: AppPageNames.contactUsScreen,
      page: () => const ContactUsScreen(),
    ),
    GetPage(
        name: AppPageNames.privacyPolicy,
        page: () => const PrivacyPolicyScreen()),
    GetPage(name: AppPageNames.introScreen, page: () => const IntroScreen()),
    GetPage(name: AppPageNames.loginScreen, page: () => const LoginScreen()),
    GetPage(name: AppPageNames.aboutUs, page: () => const AboutUsScreen()),
    GetPage(name: AppPageNames.faqaScreen, page: () => const FaqaScreen()),
    GetPage(
        name: AppPageNames.addCardScreen, page: () => const AddCardScreen()),
    GetPage(
        name: AppPageNames.languageScreen, page: () => const LanguageScreen()),
    GetPage(
        name: AppPageNames.pickedLocationScreen,
        page: () => const PickedLocationScreen()),
    GetPage(
        name: AppPageNames.selectCarScreen,
        page: () => const SelectCarScreen()),
    GetPage(
        name: AppPageNames.acceptedRequestScreen,
        page: () => const AcceptedRideRequestScreen()),
    GetPage(
        name: AppPageNames.savedLocationScreen,
        page: () => const SavedLocationScreen()),
    GetPage(
        name: AppPageNames.helpSupport, page: () => const HelpSupportScreen()),
    GetPage(name: AppPageNames.walletScreen, page: () => const WalletScreen()),
    GetPage(
        name: AppPageNames.transactionScreen, page: () => const LoginScreen()),
    GetPage(
        name: AppPageNames.withrowScreen, page: () => const AboutUsScreen()),
    GetPage(name: AppPageNames.topUpScreen, page: () => const TopUpScreen()),
    GetPage(
        name: AppPageNames.selectLocationScreen,
        page: () => const SelectLocationScreen()),
    GetPage(
        name: AppPageNames.changePasswordPromptScreen,
        page: () => const ChangePasswordPromptScreen()),
    GetPage(
        name: AppPageNames.passwordChangedScreen,
        page: () => const PasswordChangSuccessScreen()),
    GetPage(
        name: AppPageNames.verificationScreen,
        page: () => const VerificationScreen()),
    GetPage(
        name: AppPageNames.registrationScreen,
        page: () => const RegistrationScreen()),
    GetPage(
        name: AppPageNames.logInPasswordScreen,
        page: () => const LoginPasswordScreen()),
    GetPage(
        name: AppPageNames.createNewPasswordScreen,
        page: () => const CreateNewPasswordScreen()),
    GetPage(
        name: AppPageNames.zoomDrawerScreen,
        page: () => const ZoomDrawerScreen()),
    GetPage(
        name: AppPageNames.profileScreen, page: () => const ProfileScreen()),

    /*<--------car pooling------->*/
    GetPage(
        name: AppPageNames.rideShareScreen,
        page: () => const RideShareScreen()),
    GetPage(
        name: AppPageNames.carPoolingHistroyScreen,
        page: () => const CarPollingHistoryScreen()),
    GetPage(
        name: AppPageNames.chooseYouNeedScreen,
        page: () => const ChooseYouNeedScreen()),
    GetPage(
        name: AppPageNames.pullingRequestOverviewScreen,
        page: () => const PullingRequestOverviewScreen()),
    GetPage(
        name: AppPageNames.pullingOfferDetailsScreen,
        page: () => const PullingOfferDetailsScreen()),
    GetPage(
        name: AppPageNames.pullingRequestDetailsScreen,
        page: () => const PullingRequestDetailsScreen()),
    GetPage(
        name: AppPageNames.selectPaymentMethodsScreen,
        page: () => const SelectPaymentMethodsScreen()),
    GetPage(name: AppPageNames.chatScreen, page: () => const ChatScreen()),
    GetPage(
        name: AppPageNames.viewRequestsScreen,
        page: () => const ViewRequestsScreen()),
    GetPage(
        name: AppPageNames.cancelRideReason,
        page: () => const ChooseReasonCancelRide()),
    GetPage(
        name: AppPageNames.imageZoomScreen,
        page: () => const ImageZoomScreen()),
  ];

  static final GetPage<dynamic> unknownScreenPageRoute = GetPage(
    name: AppPageNames.unknownScreen,
    page: () => const UnKnownScreen(),
  );
}
