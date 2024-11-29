import 'dart:developer';
import 'dart:io';
import 'package:car2gouser/models/enums/api/api_request_content_type.dart';
import 'package:car2gouser/models/enums/api/api_rest_method.dart';
import 'package:car2gouser/models/exceptions/internet_connection.dart';
import 'package:car2gouser/models/exceptions/response_status_code.dart';
import 'package:car2gouser/utils/constants/app_colors.dart';
import 'package:car2gouser/utils/constants/app_components.dart';
import 'package:car2gouser/utils/helpers/helpers.dart';
import 'package:car2gouser/widgets/dialogs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class APIHelper {
  static Future<void> preAPICallCheck() async {
    /*<--------Check internet connection------->*/
    final bool isConnectedToInternet = await isConnectedInternet();
    if (!isConnectedToInternet) {
      throw InternetConnectionException(message: 'Not connected to internet');
    }
  }

  static bool isResponseStatusCodeIn200(int? statusCode) {
    try {
      return (statusCode! >= 200 && statusCode < 300);
    } catch (e) {
      return false;
    }
  }

  static bool isResponseStatusCodeIn400(int? statusCode) {
    try {
      return (statusCode! >= 400 && statusCode < 500);
    } catch (e) {
      return false;
    }
  }

  static void postAPICallCheck(Response<dynamic> response) {
    /*<-------Handling wrong response handling-------->*/
    if (response.statusCode == null) {
      throw ResponseStatusCodeException(
          statusCode: response.statusCode,
          message: 'Response code is not valid');
    }
    if (!isResponseStatusCodeIn200(response.statusCode) &&
        !isResponseStatusCodeIn400(response.statusCode)) {
      throw (
        statusCode: response.statusCode,
        message: 'Response code is not valid'
      );
    }
    final dynamic responseBody = response.body;
    if (responseBody == null) {
      throw Exception('responseBody is null');
    }
    if (responseBody is! Map<String, dynamic>) {
      throw const FormatException('Response type is not Map<String, dynamic>');
    }
  }

  static Map<String, String> getAuthHeaderMap({String? token}) {
    String loggedInUserBearerToken = Helper.getUserBearerToken(token: token);
    return {'Authorization': loggedInUserBearerToken};
  }

  static void handleExceptions(dynamic exception) {
    if (exception is InternetConnectionException) {
      log(exception.message);
    } else if (exception is SocketException) {
      log(exception.message);
    } else if (exception is FormatException) {
      log(exception.message);
    } else {
      log(exception.toString());
    }
  }

  static String getSafeString(dynamic unsafeResponseStringValue) {
    const String defaultStringValue = '';
    if (unsafeResponseStringValue == null) {
      return defaultStringValue;
    } else if (unsafeResponseStringValue is String) {
      // Now it is safe
      return unsafeResponseStringValue;
    }
    return defaultStringValue;
  }

  static List<T> getSafeList<T>(dynamic unsafeResponseListValue) {
    const List<T> defaultListValue = [];
    if (unsafeResponseListValue == null) {
      return defaultListValue;
    } else if (unsafeResponseListValue is List<T>) {
      // Now it is safe
      return unsafeResponseListValue;
    }
    return defaultListValue;
  }

  static DateTime getSafeDateTime(
    dynamic unsafeResponseDateTimeStringValue, {
    DateFormat? dateTimeFormat,
    bool isUTCTime = true,
  }) {
    final DateTime defaultDateTime = AppComponents.defaultUnsetDateTime;
    final String safeDateTimeStringValue =
        getSafeString(unsafeResponseDateTimeStringValue);
    return getDateTimeFromServerDateTimeString(safeDateTimeStringValue,
            dateTimeFormat: dateTimeFormat, isUTCTime: isUTCTime) ??
        defaultDateTime;
  }

  static int getSafeInt(dynamic unsafeResponseIntValue,
      [int defaultIntValue = -1]) {
    if (unsafeResponseIntValue == null) {
      return defaultIntValue;
    } else if (unsafeResponseIntValue is String) {
      return (num.tryParse(unsafeResponseIntValue) ?? defaultIntValue).toInt();
    } else if (unsafeResponseIntValue is num) {
      return unsafeResponseIntValue.toInt();
    }
    return defaultIntValue;
  }

  static double getSafeDouble(dynamic unsafeResponseDoubleValue,
      [double defaultDoubleValue = -1]) {
    if (unsafeResponseDoubleValue == null) {
      return defaultDoubleValue;
    } else if (unsafeResponseDoubleValue is String) {
      return (num.tryParse(unsafeResponseDoubleValue) ?? defaultDoubleValue)
          .toDouble();
    } else if (unsafeResponseDoubleValue is num) {
      return unsafeResponseDoubleValue.toDouble();
    }
    return defaultDoubleValue;
  }

  static bool? getBoolFromString(String boolAsString) {
    if (boolAsString == 'true') {
      return true;
    } else if (boolAsString == 'false') {
      return false;
    }
    return null;
  }

  static bool getSafeBool(dynamic unsafeResponseBoolValue,
      [bool defaultBoolValue = false]) {
    if (unsafeResponseBoolValue == null) {
      return defaultBoolValue;
    } else if (unsafeResponseBoolValue is String) {
      if (GetUtils.isBool(unsafeResponseBoolValue)) {
        return getBoolFromString(unsafeResponseBoolValue) ?? defaultBoolValue;
      }
      return defaultBoolValue;
    } else if (unsafeResponseBoolValue is bool) {
      return unsafeResponseBoolValue;
    }
    return defaultBoolValue;
  }

  static DateTime? getDateTimeFromServerDateTimeString(
    String dateTimeString, {
    DateFormat? dateTimeFormat,
    bool isUTCTime = true,
  }) {
    try {
      return (dateTimeFormat ?? AppComponents.apiDateTimeFormat)
          .parse(dateTimeString, isUTCTime)
          .toLocal();
    } catch (e) {
      return null;
    }
  }

  static String toServerDateTimeFormattedStringFromDateTime(DateTime dateTime) {
    return AppComponents.apiDateTimeFormat.format(dateTime.toUtc());
  }

  static bool isAPIResponseObjectSafe<T>(Object? unsafeValue) {
    if (unsafeValue is Map<String, dynamic>) {
      return true;
    }
    return false;
  }

  static Future<bool> isConnectedInternet() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile);
  }

  static void onError(String? message) {
    if (message == null) {
      return;
    }
    onNewFailure(message, 'Found Empty Response');
  }

  /*  static void onFailure(String message, [String? title]) {
    AppDialogs.showErrorDialog(
        messageText: message.isEmpty ? 'Something Went Wrong' : message,
        titleText: title);
  } */
  static bool _isLogoutInitiated = false;
  static void onFailure(String message, [String? title]) {
    if (message != 'Unauthorized' && message != 'User not found') {
      AppDialogs.showErrorDialog(
          messageText: message.isEmpty
              ? 'No Data Found, Please try again later.'
              : message,
          titleText: title);
    } else {
      if (!_isLogoutInitiated) {
        _isLogoutInitiated = true;
        Get.snackbar('Please Login Again', 'Session Expired',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.errorColor.withOpacity(0.1));
        Helper.logout();
      }
    }
  }

  static void onNewFailure(String message, String title) {
    if (message != 'Unauthorized') {
      Get.snackbar(title, message, snackPosition: SnackPosition.TOP);
    } else {
      if (!_isLogoutInitiated) {
        _isLogoutInitiated = true;
        Get.snackbar('Please Login Again', 'Session Expired',
            snackPosition: SnackPosition.TOP);
        Helper.logout();
      }
    }
  }

  static Future<Response<dynamic>> requestGetMethodAsURLEncoded({
    required String url,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
    required GetHttpClient apiClient,
  }) async =>
      await apiClient.get(url,
          query: queries,
          // contentType: AppConstants.apiContentTypeFormURLEncoded,
          contentType: APIRequestContentType.urlEncoded.stringValue,
          headers: headers);

  static Future<Response<dynamic>> requestPostMethodAsURLEncoded({
    required String url,
    Map<String, dynamic>? queries,
    required dynamic requestBody,
    Map<String, String>? headers,
    required GetHttpClient apiClient,
  }) async =>
      await apiClient.post(url,
          query: queries,
          body: requestBody,
          // contentType: contentType ?? AppConstants.apiContentTypeFormURLEncoded,
          contentType: APIRequestContentType.urlEncoded.stringValue,
          headers: headers);
  static Future<Response<dynamic>> requestPatchMethodAsURLEncoded({
    required String url,
    Map<String, dynamic>? queries,
    required dynamic requestBody,
    Map<String, String>? headers,
    required GetHttpClient apiClient,
  }) async =>
      await apiClient.patch(url,
          query: queries,
          body: requestBody,
          // contentType: contentType ?? AppConstants.apiContentTypeFormURLEncoded,
          contentType: APIRequestContentType.urlEncoded.stringValue,
          headers: headers);
  static Future<Response<dynamic>> requestDeleteMethodAsURLEncoded({
    required String url,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
    required GetHttpClient apiClient,
  }) async =>
      await apiClient.delete(url,
          query: queries,
          // contentType: contentType ?? AppConstants.apiContentTypeFormURLEncoded,
          contentType: APIRequestContentType.urlEncoded.stringValue,
          headers: headers);

  static Future<Response<dynamic>> requestGetMethodAsJSONEncoded({
    required String url,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
    required GetHttpClient apiClient,
  }) async =>
      await apiClient.get(url,
          query: queries,
          // contentType: AppConstants.apiContentTypeJSON,
          contentType: APIRequestContentType.json.stringValue,
          headers: headers);

  static Future<Response<dynamic>> requestPostMethodAsJSONEncoded({
    required String url,
    Map<String, dynamic>? queries,
    required dynamic requestBody,
    Map<String, String>? headers,
    required GetHttpClient apiClient,
  }) async =>
      await apiClient.post(url,
          query: queries,
          body: requestBody,
          // contentType: contentType ?? AppConstants.apiContentTypeJSON,
          contentType: APIRequestContentType.json.stringValue,
          headers: headers);

  static Future<Response<dynamic>> requestPatchMethodAsJSONEncoded({
    required String url,
    Map<String, dynamic>? queries,
    required dynamic requestBody,
    Map<String, String>? headers,
    required GetHttpClient apiClient,
  }) async =>
      await apiClient.patch(url,
          query: queries,
          body: requestBody,
          // contentType: contentType ?? AppConstants.apiContentTypeJSON,
          contentType: APIRequestContentType.json.stringValue,
          headers: headers);
  static Future<Response<dynamic>> requestDeleteMethodAsJSONEncoded({
    required String url,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
    required GetHttpClient apiClient,
  }) async =>
      await apiClient.delete(url,
          query: queries,
          // contentType: contentType ?? AppConstants.apiContentTypeJSON,
          contentType: APIRequestContentType.json.stringValue,
          headers: headers);

  static Future<Response<dynamic>> requestPostMethodAsFormData({
    required String url,
    Map<String, dynamic>? queries,
    required FormData requestBody,
    Map<String, String>? headers,
    required GetHttpClient apiClient,
  }) async =>
      await apiClient.post(url,
          query: queries,
          body: requestBody,
          contentType: APIRequestContentType.formData.stringValue,
          headers: headers);

  static Future<Response<dynamic>> requestPatchMethodAsFormData({
    required String url,
    Map<String, dynamic>? queries,
    required FormData requestBody,
    Map<String, String>? headers,
    required GetHttpClient apiClient,
  }) async =>
      await apiClient.patch(url,
          query: queries,
          body: requestBody,
          contentType: APIRequestContentType.formData.stringValue,
          headers: headers);

  static Future<({T responseModel, Response<dynamic> rawResponse})?>
      _callBaseAPIMethod<T>({
    required Future<Response<dynamic>> Function() callAPIMethod,
    required T Function(Response<dynamic> response) parseResponseToModel,
  }) async {
    try {
      await preAPICallCheck();
      final response = await callAPIMethod();
      postAPICallCheck(response);
      return (
        responseModel: parseResponseToModel(response),
        rawResponse: response
      );
    } catch (exception) {
      handleExceptions(exception);
      return null;
    }
  }

  static Future<({T responseModel, Response<dynamic> rawResponse})?>
      callAPIMethodJSONOrURLEncoded<T>({
    required APIRESTMethod method,
    required String url,
    required GetHttpClient apiClient,
    required T Function(Response<dynamic> response) parseResponseToModel,
    Map<String, dynamic>? body,
    Map<String, String>? queries,
    Map<String, String>? headers,
    APIRequestContentType contentType = APIRequestContentType.json,
  }) async =>
          _callBaseAPIMethod(
              callAPIMethod: () async => switch (method) {
                    APIRESTMethod.getMethod => switch (contentType) {
                        APIRequestContentType.json =>
                          await requestGetMethodAsJSONEncoded(
                            url: url,
                            queries: queries,
                            headers: headers,
                            apiClient: apiClient,
                          ),
                        APIRequestContentType.urlEncoded =>
                          await requestGetMethodAsURLEncoded(
                            url: url,
                            queries: queries,
                            headers: headers,
                            apiClient: apiClient,
                          ),
                        _ => await requestGetMethodAsJSONEncoded(
                            url: url,
                            queries: queries,
                            headers: headers,
                            apiClient: apiClient,
                          ),
                      },
                    APIRESTMethod.postMethod => switch (contentType) {
                        APIRequestContentType.json =>
                          await requestPostMethodAsJSONEncoded(
                            url: url,
                            requestBody: body,
                            queries: queries,
                            headers: headers,
                            apiClient: apiClient,
                          ),
                        APIRequestContentType.urlEncoded =>
                          await requestPostMethodAsURLEncoded(
                            url: url,
                            requestBody: body,
                            queries: queries,
                            headers: headers,
                            apiClient: apiClient,
                          ),
                        _ => await requestPostMethodAsJSONEncoded(
                            url: url,
                            requestBody: body,
                            queries: queries,
                            headers: headers,
                            apiClient: apiClient,
                          ),
                      },
                    APIRESTMethod.patchMethod => switch (contentType) {
                        APIRequestContentType.json =>
                          await requestPatchMethodAsJSONEncoded(
                            url: url,
                            requestBody: body,
                            queries: queries,
                            headers: headers,
                            apiClient: apiClient,
                          ),
                        APIRequestContentType.urlEncoded =>
                          await requestPatchMethodAsURLEncoded(
                            url: url,
                            requestBody: body,
                            queries: queries,
                            headers: headers,
                            apiClient: apiClient,
                          ),
                        _ => await requestPatchMethodAsJSONEncoded(
                            url: url,
                            requestBody: body,
                            queries: queries,
                            headers: headers,
                            apiClient: apiClient,
                          ),
                      },
                    APIRESTMethod.deleteMethod => switch (contentType) {
                        APIRequestContentType.json =>
                          await requestDeleteMethodAsJSONEncoded(
                            url: url,
                            queries: queries,
                            headers: headers,
                            apiClient: apiClient,
                          ),
                        APIRequestContentType.urlEncoded =>
                          await requestDeleteMethodAsURLEncoded(
                            url: url,
                            queries: queries,
                            headers: headers,
                            apiClient: apiClient,
                          ),
                        _ => await requestDeleteMethodAsJSONEncoded(
                            url: url,
                            queries: queries,
                            headers: headers,
                            apiClient: apiClient,
                          ),
                      },
                  },
              parseResponseToModel: parseResponseToModel);

  static Future<({T responseModel, Response<dynamic> rawResponse})?>
      callPostOrPatchAPIMethodFormDataEncoded<T>({
    required APIRESTMethod method,
    required String url,
    required GetHttpClient apiClient,
    required T Function(Response<dynamic> response) parseResponseToModel,
    required FormData body,
    Map<String, String>? queries,
    Map<String, String>? headers,
  }) async =>
          _callBaseAPIMethod(
              callAPIMethod: () async => switch (method) {
                    APIRESTMethod.postMethod =>
                      await requestPostMethodAsFormData(
                        url: url,
                        requestBody: body,
                        queries: queries,
                        headers: headers,
                        apiClient: apiClient,
                      ),
                    APIRESTMethod.patchMethod =>
                      await requestPatchMethodAsFormData(
                        url: url,
                        requestBody: body,
                        queries: queries,
                        headers: headers,
                        apiClient: apiClient,
                      ),
                    _ => await requestPostMethodAsFormData(
                        url: url,
                        requestBody: body,
                        queries: queries,
                        headers: headers,
                        apiClient: apiClient,
                      )
                  },
              parseResponseToModel: parseResponseToModel);
}
