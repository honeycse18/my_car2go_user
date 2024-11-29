import 'dart:convert';
import 'dart:developer';

import 'package:car2gouser/models/api_responses/country_list_response.dart';
import 'package:car2gouser/models/api_responses/about_us_response.dart';
import 'package:car2gouser/models/api_responses/carpolling/all_categories_response.dart';
import 'package:car2gouser/models/api_responses/carpolling/nearest_pulling_requests_response.dart';
import 'package:car2gouser/models/api_responses/carpolling/post_pulling_request_response.dart';
import 'package:car2gouser/models/api_responses/carpolling/pulling_offer_details_response.dart';
import 'package:car2gouser/models/api_responses/chat_message_list_response.dart';
import 'package:car2gouser/models/api_responses/chat_message_list_sender_response.dart';
import 'package:car2gouser/models/api_responses/contact_us_response.dart';
import 'package:car2gouser/models/api_responses/coupon_code_list_response.dart';
import 'package:car2gouser/models/api_responses/dashboard_police_response.dart';
import 'package:car2gouser/models/api_responses/faq_response.dart';
import 'package:car2gouser/models/api_responses/faq_response_updated.dart';
import 'package:car2gouser/models/api_responses/find_account_response.dart';
import 'package:car2gouser/models/api_responses/get_user_data_response.dart';
import 'package:car2gouser/models/api_responses/get_wallet_details_response.dart';
import 'package:car2gouser/models/api_responses/google_map_poly_lines_response.dart';
import 'package:car2gouser/models/api_responses/languages_response.dart';
import 'package:car2gouser/models/api_responses/live_location_response.dart';
import 'package:car2gouser/models/api_responses/login_response.dart';
import 'package:car2gouser/models/api_responses/multiple_image_upload_response.dart';
import 'package:car2gouser/models/api_responses/nearest_cars_list_response.dart';
import 'package:car2gouser/models/api_responses/notification_list_response.dart';
import 'package:car2gouser/models/api_responses/otp_request_response.dart';
import 'package:car2gouser/models/api_responses/otp_verification_response.dart';
import 'package:car2gouser/models/api_responses/profile_details.dart';
import 'package:car2gouser/models/api_responses/pulling_request_details_response.dart';
import 'package:car2gouser/models/api_responses/recent_location_response.dart';
import 'package:car2gouser/models/api_responses/registration_response.dart';
import 'package:car2gouser/models/api_responses/ride_details_response.dart';
import 'package:car2gouser/models/api_responses/ride_history_response.dart';
import 'package:car2gouser/models/api_responses/saved_location_list_response.dart';
import 'package:car2gouser/models/api_responses/schedule_ride_post_response.dart';
import 'package:car2gouser/models/api_responses/search_nearest_vehicle_response.dart';
import 'package:car2gouser/models/api_responses/send_user_profile_update_otp_response.dart';
import 'package:car2gouser/models/api_responses/share_ride_history_response.dart';
import 'package:car2gouser/models/api_responses/single_image_upload_response.dart';
import 'package:car2gouser/models/api_responses/site_settings.dart';
import 'package:car2gouser/models/api_responses/social_google_login_response.dart';
import 'package:car2gouser/models/api_responses/support_text_response.dart';
import 'package:car2gouser/models/api_responses/t/login/login.dart';
import 'package:car2gouser/models/api_responses/t/property_find_response/forget_pass/update_password.dart';
import 'package:car2gouser/models/api_responses/t/property_find_response/forget_password_response.dart';
import 'package:car2gouser/models/api_responses/t/property_find_response/registration_verify/request_otp.dart';
import 'package:car2gouser/models/api_responses/forgot_password_verify_otp.dart';
import 'package:car2gouser/models/api_responses/t/saved_Location/address_list_response/address_list_response.dart';
import 'package:car2gouser/models/api_responses/t/saved_Location/update_address_response/update_address_response.dart';
import 'package:car2gouser/models/api_responses/top_up_response.dart';
import 'package:car2gouser/models/api_responses/user_details_response.dart';
import 'package:car2gouser/models/api_responses/wallet_details.dart';
import 'package:car2gouser/models/api_responses/wallet_history_response.dart';
import 'package:car2gouser/models/core_api_responses/api_list_response.dart';
import 'package:car2gouser/models/core_api_responses/api_response.dart';
import 'package:car2gouser/models/core_api_responses/paginated_data_response.dart';
import 'package:car2gouser/models/core_api_responses/raw_api_response.dart';
import 'package:car2gouser/models/enums/api/api_request_content_type.dart';
import 'package:car2gouser/models/enums/api/api_rest_method.dart';
import 'package:car2gouser/utils/api_client.dart';
import 'package:car2gouser/utils/constants/app_constants.dart';
import 'package:car2gouser/utils/helpers/api_helper.dart';
import 'package:get/get_connect/http/src/http.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class APIRepo {
  /*<--------Get routes polylines from google API------->*/
  static Future<GoogleMapPolyLinesResponse?> getRoutesPolyLines(
      double originLatitude,
      double originLongitude,
      double targetLatitude,
      double targetLongitude) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'origin': '$originLatitude,$originLongitude',
        'destination': '$targetLatitude,$targetLongitude',
        'sensor': 'false',
        'key': AppConstants.googleAPIKey,
      };
      final Response response = await APIClient.instance.requestGetMapMethod(
          url: '/maps/api/directions/json', queries: queries);
      APIHelper.postAPICallCheck(response);
      final GoogleMapPolyLinesResponse responseModel =
          GoogleMapPolyLinesResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
  /*<-------- Google Login API ------->*/

  static Future<SocialGoogleLoginResponse?> socialGoogleLoginVerify(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('/api/user/verify-google-user', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SocialGoogleLoginResponse responseModel =
          SocialGoogleLoginResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<-------Get FAQ item list from API-------->*/
  static Future<FaqResponse?> getFaqItemList(int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/faq/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final FaqResponse responseModel =
          FaqResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
/*<-------Get ride history from API-------->*/

  static Future<RideHistoryResponse?> getRideHistory(
      {int page = 1, String filter = ''}) async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'page': '$page'};
      if (filter.isNotEmpty) {
        queries['status'] = filter;
      }
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/ride/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RideHistoryResponse responseModel =
          RideHistoryResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }
/*<-------Get dashboard emergency date details from API-------->*/

  static Future<DashboardEmergencyDataResponse?>
      getDashBoardEmergencyDataDetails() async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/settings', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final DashboardEmergencyDataResponse responseModel =
          DashboardEmergencyDataResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
/*<-------Get  contact us details from API-------->*/

  static Future<ContactUsResponse?> getContactUsDetails() async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'slug': 'contact_us',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ContactUsResponse responseModel =
          ContactUsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
/*<-------Contact us message-------->*/

  static Future<RawAPIResponse?> postContactUsMessage(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/contact',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
/*<-------Get about us from API-------->*/

  static Future<AboutUsResponse?> getAboutUsText() async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'slug': 'about_us'};

      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      /*<-------After post API call checking, any issues, errors found throw exception-------->*/
      APIHelper.postAPICallCheck(response);
      final AboutUsResponse responseModel =
          AboutUsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
/*<-------Get support text from API-------->*/

  static Future<SupportTextResponse?> getSupportText(
      {required String slug}) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'slug': slug};

      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      APIHelper.postAPICallCheck(response);
      final SupportTextResponse responseModel =
          SupportTextResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Find Account------->*/
  static Future<FindAccountResponse?> findAccount(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response =
          await APIClient.instance.requestPostMethodAsURLEncoded(
        url: '/api/user/find',
        requestBody: requestBody,
      );
      APIHelper.postAPICallCheck(response);
      final FindAccountResponse responseModel =
          FindAccountResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<FindAccountDataRefactored>?> findAccountUpdated(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/auth/identification/check',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<FindAccountDataRefactored>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: FindAccountDataRefactored(),
        dataFromJson: FindAccountDataRefactored.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;

    /// If the user does not exist, the [FindAccountDataRefactored.role] will be [AppConstants.userRoleUnknown].
    ///
    /// The [FindAccountDataRefactored.account] will be true if the user exists, false otherwise.
    ///
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

  static Future<APIResponse<ProfileDetails>?> getProfileUpdated(
      {String? authToken}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/user/profile',
      apiClient: APIClient.instance.apiClient,
      headers: APIHelper.getAuthHeaderMap(token: authToken),
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<ProfileDetails>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: ProfileDetails.empty(),
        dataFromJson: ProfileDetails.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

/*<--------Get share ride history------->*/
  static Future<ShareRideHistoryResponse?> getShareRideHistory(
      {int page = 1, String filter = '', String action = ''}) async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'page': '$page'};
      if (filter.isNotEmpty) {
        queries['status'] = filter;
      }
      if (action.isNotEmpty) {
        queries['action'] = action;
      }
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/pulling/history',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ShareRideHistoryResponse responseModel =
          ShareRideHistoryResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

/*<--------Get pooling offer details from API------->*/
  static Future<PoolingOfferDetailsResponse?> getPoolingOfferDetails(
      String requestId) async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'_id': requestId};
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/pulling/offer',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final PoolingOfferDetailsResponse responseModel =
          PoolingOfferDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

/*<--------Get notification list------->*/
  static Future<NotificationListResponse?> getNotificationList(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/notification/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final NotificationListResponse responseModel =
          NotificationListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Payment tap------->*/
  static Future<RawAPIResponse?> onPaymentTap(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/ride/payment',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Get nearest request from API------->*/
  static Future<NearestPoolingRequestsResponse?> getNearestRequests(
      Map<String, String> params, int page) async {
    try {
      await APIHelper.preAPICallCheck();
      if (page > 0) {
        params['page'] = '$page';
      }
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/pulling/nearest',
              queries: params,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final NearestPoolingRequestsResponse responseModel =
          NearestPoolingRequestsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

/*<--------Read Notification------->*/
  static Future<RawAPIResponse?> readNotification(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/notification/read',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Read all notification------->*/
  static Future<RawAPIResponse?> readAllNotification(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/notification/read/all',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Get ride details from API------->*/
  static Future<RideDetailsResponse?> getRideDetails(String rideId) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': rideId,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/ride',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RideDetailsResponse responseModel =
          RideDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Update saved location------->*/
  // static Future<RawAPIResponse?> updateSavedLocation(
  //     Map<String, dynamic> requestBody) async {
  //   try {
  //     await APIHelper.preAPICallCheck();
  //     final Response response = await APIClient.instance
  //         .requestPatchMethodAsJSONEncoded(
  //             url: '/api/location',
  //             requestBody: requestBody,
  //             headers: APIHelper.getAuthHeaderMap());
  //     APIHelper.postAPICallCheck(response);
  //     final RawAPIResponse responseModel =
  //         RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
  //     if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
  //       responseModel.success = true;
  //     }
  //     return responseModel;
  //   } catch (exception) {
  //     APIHelper.handleExceptions(exception);
  //     return null;
  //   }
  // }

  static Future<APIResponse<void>?> updateSavedAddress(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.patchMethod,
      url: '/saved-address/update',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      headers: APIHelper.getAuthHeaderMap(),
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) => APIResponse<void>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: null,
        dataFromJson: (data) {},
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

/*<--------Cancel pending request------->*/
  static Future<RawAPIResponse?> cancelPendingRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/ride/request/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Get nearest cars list------->*/
  static Future<NearestCarsListResponse?> getNearestCarsList(
      {double lat = 0,
      double lng = 0,
      double destLat = 0,
      double destLng = 0,
      String? categoryId,
      int? limit}) async {
    try {
      final Map<String, dynamic> queries = {
        "lat": lat.toString(),
        "lng": lng.toString(),
        "destination": '$destLat,$destLng'
      };
      if (categoryId != null) {
        queries["category"] = categoryId;
      }
      if (limit != null) {
        queries['limit'] = limit.toString();
      }
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/ride/nearest',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final NearestCarsListResponse responseModel =
          NearestCarsListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<SearchNearestVehiclesResponse>?>
      getNearestCarsListUpdated({Map<String, dynamic>? requestBody}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/ride-request/search-nearest-vehicles',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<SearchNearestVehiclesResponse>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: SearchNearestVehiclesResponse(),
        dataFromJson: SearchNearestVehiclesResponse.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

/*<--------Update ride status------->*/
  static Future<RawAPIResponse?> updateRideStatus(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/ride',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /*<-------Fetch language-------->*/
  static Future<LanguagesResponse?> fetchLanguages() async {
    try {
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        '/api/languages',
        headers: APIHelper.getAuthHeaderMap(),
      );

      APIHelper.postAPICallCheck(response);
      final LanguagesResponse responseModel =
          LanguagesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<-------Get id user details from API-------->*/
  static Future<GetUserDataResponse?> getIdUserDetails(String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': id,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/user/details',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final GetUserDataResponse responseModel =
          GetUserDataResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LiveLocationResponse?> getRideLiveLocation(
      String rideId) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': rideId,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/ride/location',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final LiveLocationResponse responseModel =
          LiveLocationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Create new password------->*/
  static Future<RawAPIResponse?> createNewPassword(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/user/reset-password', requestBody: requestBody);
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<void>?> createNewPasswordUpdated(
      Map<String, dynamic> requestBody,
      {required String token}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/auth/forget-password/submit',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(token: token),
      parseResponseToModel: (response) => APIResponse<void>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: null,
        dataFromJson: (data) {},
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

/*<--------Request for ride------->*/
  static Future<ScheduleRideResponse?> requestForRide(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/ride/request',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      log(jsonEncode(requestBody));
      APIHelper.postAPICallCheck(response);
      final ScheduleRideResponse responseModel =
          ScheduleRideResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

/*<--------Add favourite location------->*/
  // static Future<RawAPIResponse?> addFavoriteLocation(
  //     Map<String, dynamic> requestBody) async {
  //   try {
  //     await APIHelper.preAPICallCheck();
  //     final Response response = await APIClient.instance
  //         .requestPostMethodAsJSONEncoded(
  //             url: '/api/location',
  //             requestBody: requestBody,
  //             headers: APIHelper.getAuthHeaderMap());
  //     APIHelper.postAPICallCheck(response);
  //     final RawAPIResponse responseModel =
  //         RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
  //     if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
  //       responseModel.success = true;
  //     }
  //     return responseModel;
  //   } catch (exception) {
  //     APIHelper.handleExceptions(exception);
  //     return null;
  //   }
  // }

  static Future<APIResponse<void>?> createNewAddress(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/saved-address/create',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) => APIResponse<void>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: null,
        dataFromJson: (data) {},
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

/*<-------Get country list from API-------->*/
  static Future<CountryListResponse?> getCountryList() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/countries', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final CountryListResponse responseModel =
          CountryListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Get all categories from API------->*/
  static Future<AllCategoriesResponse?> getAllCategories() async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'limit': '100'};
      final Response response =
          await APIClient.instance.requestGetMethodAsJSONEncoded(
        url: '/api/category/list',
        queries: queries,
      );
      APIHelper.postAPICallCheck(response);
      final AllCategoriesResponse responseModel =
          AllCategoriesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

/*<--------Request ride------->*/
  static Future<RawAPIResponse?> requestRide(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestPostMethodAsJSONEncoded(
        url: '/api/pulling/request',
        requestBody: requestBodyJson,
        headers: APIHelper.getAuthHeaderMap(),
      );

      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Get recent location list from API------->*/
  static Future<RecentLocationResponse?> getRecentLocationList(
      {String? search}) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {};
      if (search != null && search.isNotEmpty) {
        queries['search'] = search;
      }
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/location/recent',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RecentLocationResponse responseModel =
          RecentLocationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Get coupon list from API------->*/
  static Future<CouponCodeListResponse?> getCouponList() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/coupon/offer', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final CouponCodeListResponse responseModel =
          CouponCodeListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Update password------->*/
  static Future<RawAPIResponse?> updatePassword(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/user/password',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  //forget password

  static Future<APIResponse<ForgetPasswordResponse>?> forgetPasswordUpdated(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/auth/forget-password/send-otp',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<ForgetPasswordResponse>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: ForgetPasswordResponse(),
        dataFromJson: ForgetPasswordResponse.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

/*<--------Create new request------->*/
  static Future<PostPoolingRequestResponse?> createNewRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/pulling/offer',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final PostPoolingRequestResponse responseModel =
          PostPoolingRequestResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

/*<--------Get transaction history------->*/
  static Future<WalletTransactionHistoryResponse?> getTransactionHistory(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {'page': '$currentPageNumber'};
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/wallet/history',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final WalletTransactionHistoryResponse responseModel =
          WalletTransactionHistoryResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Get wallet details------->*/
  static Future<GetWalletDetailsResponse?> getWalletDetails() async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/wallet', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final GetWalletDetailsResponse responseModel =
          GetWalletDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<WalletDetails>?> getWalletDetailsUpdated() async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/wallet/user-transaction/summary',
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<WalletDetails>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: WalletDetails.empty(),
        dataFromJson: WalletDetails.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<PaginatedDataResponse<WalletTransaction>>?>
      getWalletTransactionHistoryUpdated(
          {required Map<String, String> queries}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/wallet/user-transactions',
      queries: queries,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<PaginatedDataResponse<WalletTransaction>>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: PaginatedDataResponse.empty(),
        dataFromJson: (data) => PaginatedDataResponse.getSafeObject(
          data,
          docFromJson: (item) => WalletTransaction.getSafeObject(item),
        ),
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

/*<--------Read message------->*/
  static Future<RawAPIResponse?> readMessage(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/message',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Get chat message list------->*/
  static Future<ChatMessageListResponse?> getChatMessageList(
      int currentPageNumber, String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
        'with': id,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/message/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ChatMessageListResponse responseModel =
          ChatMessageListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Update user profile------->*/
  static Future<RawAPIResponse?> updateUserProfile(dynamic requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      String contentType = 'multipart/form-data';
      if (requestBody is String) {
        contentType = 'application/json';
      }
      final Response response = await APIClient.instance.apiClient.patch(
          '/api/user/',
          body: requestBody,
          contentType: contentType,
          headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Send message------->*/
  static Future<ChatMessageListSendResponse?> sendMessage(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/message',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ChatMessageListSendResponse responseModel =
          ChatMessageListSendResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Start ride with submit otp------->*/
  static Future<RawAPIResponse?> startRideWithSubmitOtp(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/pulling/request/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Registration------->*/
  static Future<RegistrationResponse?> registration(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/user/registration', requestBody: requestBody);
      APIHelper.postAPICallCheck(response);
      final RegistrationResponse responseModel =
          RegistrationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<RegistrationDataUpdated>?> registrationUpdated(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/user/register',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<RegistrationDataUpdated>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: RegistrationDataUpdated(),
        dataFromJson: RegistrationDataUpdated.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

/*<-------Request Otp-------->*/
  static Future<OtpRequestResponse?> requestOTP(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/user/send-otp', requestBody: requestBody);

      APIHelper.postAPICallCheck(response);
      final OtpRequestResponse responseModel =
          OtpRequestResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<RequestOtp>?> requestForgotPasswordOTPUpdated(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/auth/forget-password/send-otp',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) => APIResponse<RequestOtp>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: RequestOtp(),
        dataFromJson: RequestOtp.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

//requestOTPupdated

  static Future<APIResponse<RequestOtp>?> requestOTPUpdated(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/otp/send',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) => APIResponse<RequestOtp>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: RequestOtp(),
        dataFromJson: RequestOtp.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

/*<--------Delete saved location------->*/
  // static Future<RawAPIResponse?> deleteSavedLocation({String? id}) async {
  //   try {
  //     await APIHelper.preAPICallCheck();

  //     final Map<String, dynamic> queries = {'_id': id};
  //     final Response response = await APIClient.instance
  //         .requestDeleteMethodAsJSONEncoded(
  //             url: '/api/location',
  //             queries: queries,
  //             headers: APIHelper.getAuthHeaderMap());
  //     APIHelper.postAPICallCheck(response);
  //     final RawAPIResponse responseModel =
  //         RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
  //     if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
  //       responseModel.success = true;
  //     }
  //     return responseModel;
  //   } catch (exception) {
  //     APIHelper.handleExceptions(exception);
  //     return null;
  //   }
  // }

  static Future<APIResponse<RawAPIResponse>?> deleteSavedAddress(
      {required String id}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.deleteMethod,
      url: '/saved-address',
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      queries: {'_id': id},
      parseResponseToModel: (response) =>
          APIResponse<RawAPIResponse>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: RawAPIResponse.empty(),
        dataFromJson: RawAPIResponse.getAPIResponseObjectSafeValue,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

/*<--------Payment accept car rent request------->*/
  static Future<RawAPIResponse?> paymentAcceptCarRentRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/pulling/payment',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Verify OTP------->*/
  static Future<OtpVerificationResponse?> verifyOTP(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/user/verify-otp', requestBody: requestBody);
      APIHelper.postAPICallCheck(response);
      final OtpVerificationResponse responseModel =
          OtpVerificationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Verify OTP Updated------->*/
  static Future<APIResponse<ForgotPasswordVerifyOTP>?> forgotPasswordVerifyOTP(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/auth/forget-password/verify-otp',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<ForgotPasswordVerifyOTP>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: ForgotPasswordVerifyOTP(),
        dataFromJson: ForgotPasswordVerifyOTP.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

/*<--------Update share ride request------->*/
  static Future<RawAPIResponse?> updateShareRideRequest(
      {required String requestId,
      String action = 'accepted',
      String? reason}) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, String> requestBody = {
        '_id': requestId,
        'status': action
      };
      if (reason != null && reason.isNotEmpty) {
        requestBody['cancel_reason'] = reason;
      }
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/pulling/request/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

/*<--------Get saved location list------->*/
  // static Future<SavedLocationListResponse?> getSavedLocationList(
  //     {String? search}) async {
  //   try {
  //     await APIHelper.preAPICallCheck();
  //     final Map<String, dynamic> queries = {};
  //     if (search != null && search.isNotEmpty) {
  //       queries['search'] = search;
  //     }
  //     final Response response = await APIClient.instance
  //         .requestGetMethodAsJSONEncoded(
  //             url: '/api/location/list',
  //             queries: queries,
  //             headers: APIHelper.getAuthHeaderMap());
  //     APIHelper.postAPICallCheck(response);
  //     final SavedLocationListResponse responseModel =
  //         SavedLocationListResponse.getAPIResponseObjectSafeValue(
  //             response.body);
  //     if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
  //       responseModel.error = true;
  //     }
  //     return responseModel;
  //   } catch (exception) {
  //     APIHelper.handleExceptions(exception);
  //     return null;
  //   }
  // }

  static Future<APIListResponse<SavedAddressItem>?> getSavedAddressList(
      {Map<String, String>? queries}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/saved-address/list',
      apiClient: APIClient.instance.apiClient,
      queries: queries,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIListResponse<SavedAddressItem>.getSafeObject(
        unsafeObject: response.body,
        dataFromJson: SavedAddressItem.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

/*<--------Login------->*/
  static Future<LoginResponse?> login(Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/user/login', requestBody: requestBody);

      APIHelper.postAPICallCheck(response);
      final LoginResponse responseModel =
          LoginResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<APIResponse<Login>?> loginUpdated(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/auth/login',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) => APIResponse<Login>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: Login.empty(),
        dataFromJson: Login.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

/*<--------Get user details from API------->*/
  static Future<UserDetailsResponse?> getUserDetails({String? token}) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/user/',
              headers: token != null
                  ? {'Authorization': 'Bearer $token'}
                  : APIHelper.getAuthHeaderMap());

      APIHelper.postAPICallCheck(response);
      final UserDetailsResponse responseModel =
          UserDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Topup wallet------->*/
  static Future<RawAPIResponse?> topUpWallet(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/wallet/add',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Submit reviews------->*/
  static Future<RawAPIResponse?> submitReviews(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/review',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Complete ride------->*/
  static Future<RawAPIResponse?> completeRide(String rideId) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> requestBody = {
        '_id': rideId,
        'status': 'completed'
      };
      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/pulling/offer',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.success = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*<--------Get pooling request details from API------->*/
  static Future<PoolingRequestDetailsResponse?> getPoolingRequestDetails(
      String requestId) async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'_id': requestId};
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/pulling/request',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final PoolingRequestDetailsResponse responseModel =
          PoolingRequestDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<APIListResponse<FaqResponseUpdated>?> getFaqs() async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/faq/list',
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      queries: {'for': 'user'},
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIListResponse<FaqResponseUpdated>.getSafeObject(
        unsafeObject: response.body,
        dataFromJson: FaqResponseUpdated.getAPIResponseObjectSafeValue,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    final rawResponse = apiResponse?.rawResponse;
    if (APIHelper.isResponseStatusCodeIn400(rawResponse?.statusCode)) {
      responseModel?.success = false;
    }
    return responseModel;
  }

  static Future<APIResponse<SiteSettings>?> getSiteSettings() async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.getMethod,
      url: '/settings/site',
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      parseResponseToModel: (response) =>
          APIResponse<SiteSettings>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: SiteSettings(),
        dataFromJson: SiteSettings.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<TopUpResponse>?> topUpWalletUpdated(
      {required Map<String, dynamic> requestBody}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/payment/request',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<TopUpResponse>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: TopUpResponse(),
        dataFromJson: TopUpResponse.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<ProfileDetails>?> updateProfileDetails(
      Map<String, dynamic> requestBody) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.patchMethod,
      url: '/user/profile',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<ProfileDetails>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: ProfileDetails.empty(),
        dataFromJson: ProfileDetails.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<SingleImageUploadData>?> uploadSingleImage(
      FormData requestBody,
      {String? token}) async {
    final apiResponse = await APIHelper.callPostOrPatchAPIMethodFormDataEncoded(
      method: APIRESTMethod.getMethod,
      url: '/file/single-file-upload',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      headers: APIHelper.getAuthHeaderMap(token: token),
      parseResponseToModel: (response) =>
          APIResponse<SingleImageUploadData>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: SingleImageUploadData(),
        dataFromJson: SingleImageUploadData.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<MultipleImageUploadData>?> uploadMultipleImage(
      FormData requestBody,
      {String? token}) async {
    final apiResponse = await APIHelper.callPostOrPatchAPIMethodFormDataEncoded(
      method: APIRESTMethod.getMethod,
      url: '/file/multiple-file-upload',
      apiClient: APIClient.instance.apiClient,
      body: requestBody,
      headers: APIHelper.getAuthHeaderMap(token: token),
      parseResponseToModel: (response) =>
          APIResponse<MultipleImageUploadData>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: MultipleImageUploadData(),
        dataFromJson: MultipleImageUploadData.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<SendUserProfileUpdateOtpResponse>?>
      sendUserProfileOTP({Map<String, dynamic>? requestBody}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/otp/send/user-profile-update',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<SendUserProfileUpdateOtpResponse>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: SendUserProfileUpdateOtpResponse(),
        dataFromJson: SendUserProfileUpdateOtpResponse.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }

  static Future<APIResponse<ProfileDetails>?> veryUserProfileOTP(
      {Map<String, dynamic>? requestBody}) async {
    final apiResponse = await APIHelper.callAPIMethodJSONOrURLEncoded(
      method: APIRESTMethod.postMethod,
      url: '/otp/verify/profile-update',
      body: requestBody,
      apiClient: APIClient.instance.apiClient,
      contentType: APIRequestContentType.json,
      headers: APIHelper.getAuthHeaderMap(),
      parseResponseToModel: (response) =>
          APIResponse<ProfileDetails>.getSafeObject(
        unsafeObject: response.body,
        emptyObject: ProfileDetails.empty(),
        dataFromJson: ProfileDetails.getSafeObject,
      ),
    );
    final responseModel = apiResponse?.responseModel;
    return responseModel;
  }
}
