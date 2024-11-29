import 'package:car2gouser/utils/constants/app_secrets.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppConstants {
  static const String appLiveBaseURL =
      'https://backend.1b.car2go.appstick.com.bd'; // New Live API
  // static const String appLiveBaseURL = 'https://api.car2go.1b.sabbir.tech'; // Deleted Live API
  // static const String appLiveBaseURL = 'https://car2gopro1b.appstick.com.bd'; // Old Live API
  static const String appLocalhostBaseURL = 'http://192.168.0.185:7111';
  static const bool isTestOnLocalhost = false;
  static const String appBaseURL =
      isTestOnLocalhost ? appLocalhostBaseURL : appLiveBaseURL;
  static const String apiVersionCode = 'v1';
  static const String googleMapBaseURL = 'https://maps.googleapis.com';

  static const String apiContentTypeJSON = 'application/json';
  static const String apiContentTypeFormURLEncoded =
      'application/x-www-form-urlencoded';
  static const String apiContentTypeFormData = 'multipart/form-data';
  static const String googleAPIKey = AppSecrets.googleAPIKey;
  static const String jpgFileContentType = 'image/jpeg';

  static const String defaultCurrencySymbol = r'$';
  static const String defaultCountryShortCode = 'TG';
  static final CountryCode defaultCountryCode =
      CountryCode.fromCountryCode(defaultCountryShortCode);
  static const String userRoleUser = 'user';
  static const String rideRequestAccepted = 'accepted';
  static const String rideRequestRejected = 'rejected';
  static const String unknown = 'unknown';
  static const String shareRideHistoryOffering = 'offer_ride';
  static const String shareRideHistoryFindRide = 'find_ride';
  /*<-------All types of statuses-------->*/

  static const String shareRideAllStatusActive = 'active';
  static const String shareRideAllStatusAccepted = 'accepted';
  static const String shareRideAllStatusRejected = 'reject';
  static const String shareRideAllStatusStarted = 'started';
  static const String shareRideAllStatusPending = 'pending';
  static const String shareRideAllStatusCompleted = 'completed';
  static const String shareRideAllStatusCancelled = 'cancelled';
  static const String shareRideAllStatusOffer = 'offer';
  static const String shareRideAllStatusRequest = 'request';
  static const String shareRideAllStatusVehicle = 'vehicle';
  static const String shareRideAllStatusPassenger = 'passenger';
  static const String orderStatusPending = 'pending';
  static const String ridePostAcceptanceStarted = 'started';
  static const String ridePostAcceptanceCompleted = 'completed';
  static const String ridePostAcceptanceCancelled = 'cancelled';

  static const String shareRideActionMyRequest = 'request';
  static const String shareRideActionMyOffer = 'offer';

  /*<-------Push Notification configs-------->*/
  static const String notificationChannelID = 'car2go';
  static const String notificationChannelName = 'Car2Go';
  static const String notificationChannelDescription =
      'One Ride app notification channel';
  static const String notificationChannelTicker = 'car2goticker';
  static const String hiveDefaultLanguageKey = 'default_language';
  static const double borderRadiusValue = 28;

  static const int defaultUnsetDateTimeYear = 1800;
  static final DateTime defaultUnsetDateTime =
      DateTime(AppConstants.defaultUnsetDateTimeYear);
  static const String apiDateTimeFormatValue =
      'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';

  static const double dialogBorderRadiusValue = 20;
  static const String apiOnlyDateFormatValue = 'dd-MM-yyyy';
  static const String apiOnlyTimeFormatValue = 'HH:mm';
  static const String hireDriverStatusHourly = 'hourly';
  static const String hireDriverStatusFixed = 'fixed';
  static const String rentCarStatusHourly = 'hourly';
  static const String rentCarStatusWeekly = 'weekly';
  static const String rentCarStatusMonthly = 'monthly';
  /*<-------- Vehicle Info Type status------->*/
  static const String vehicleDetailsInfoTypeStatusSpecifications =
      'specifications';
  static const String vehicleDetailsInfoTypeStatusFeatures = 'features';
  static const String vehicleDetailsInfoTypeStatusReview = 'review';

  // Gender
  static const String genderMale = 'male';
  static const String genderFemale = 'female';
  static const String genderOther = 'other';

  // Identifier type
  static const String identifierTypeEmail = 'email';
  static const String identifierTypePhone = 'phone';

  // Dynamic field types
  static const String dynamicFieldTypeText = 'text';
  static const String dynamicFieldTypeNumber = 'number';
  static const String dynamicFieldTypeEmail = 'email';
  static const String dynamicFieldTypeTextArea = 'textarea';
  static const String dynamicFieldTypeImage = 'image';

  // Dynamic field image types
  static const String dynamicFieldImageTypeSingle = 'single';
  static const String dynamicFieldImageTypeMultiple = 'multiple';

  // Vehicle ride status
  static const String vehicleRideStatusInactive = 'inactive';
  static const String vehicleRideStatusActive = 'active';

  // Wallet transaction mode
  static const String walletTransactionModeExpense = 'expense';
  static const String walletTransactionModeDeposit = 'deposit';

  // Wallet transaction type
  static const String walletTransactionTypeSubscription = 'subscription';
  static const String walletTransactionTypeTrip = 'trip';
  static const String walletTransactionTypeCarpooling = 'carpooling';
  static const String walletTransactionTypeUserTopUp = 'user_topUp';
  static const String walletTransactionTypeDriverTopUp = 'driver_topUp';
  static const String walletTransactionTypeDriverWithdraw = 'withdraw';
  static const String walletTransactionTypeDriverTripCancellation =
      'trip_cancellation';
  static const String walletTransactionTypeDriverCarpoolingCancellation =
      'carpooling_cancellation';

  // Wallet transaction status
  static const String walletTransactionStatusPending = 'pending';
  static const String walletTransactionStatusAccepted = 'accepted';
  static const String walletTransactionStatusRejected = 'rejected';
  static const String walletTransactionStatusCompleted = 'completed';
  static const String walletTransactionStatusPaid = 'paid';
  static const String walletTransactionStatusCancelled = 'cancelled';
  static const String walletTransactionStatusFailed = 'failed';
  static const String walletTransactionStatusRefunded = 'refunded';
  static const String walletTransactionStatusProcessing = 'processing';

  // Wallet transaction by
  static const String walletTransactionByUser = 'user';
  static const String walletTransactionByDriver = 'driver';
  static const String walletTransactionByEmployee = 'employee';

  // Wallet transaction from
  static const String walletTransactionFromTrip = 'trip';
  static const String walletTransactionFromCarpooling = 'carpooling';
  static const String walletTransactionFromTopUp = 'topUp';
  static const String walletTransactionFromTripCancellation =
      'trip_cancellation';
  static const String walletTransactionFromCarpoolingCancellation =
      'carpooling_cancellation';

  // Wallet transaction payment status
  static const String walletTransactionPaymentStatusPending = 'pending';
  static const String walletTransactionPaymentStatusPaid = 'paid';
  static const String walletTransactionPaymentStatusCancelled = 'cancelled';
  static const String walletTransactionPaymentStatusFailed = 'failed';

  // Ride type
  static const String rideTypeRideNow = 'ride_now';
  static const String rideTypeShareRide = 'share_ride';
  static const String rideTypeCarpooling = 'carpooling';

  static const int maximumMultipleImageCount = 20;
  static const int minimumVehicleModelYearDecrementCounter = 50;

  /*<--------Dialog padding values------->*/
  static const double dialogVerticalSpaceValue = 16;
  static const double dialogHalfVerticalSpaceValue = 8;
  static const double dialogHorizontalSpaceValue = 18;
  static const double imageBorderRadiusValue = 14;
  static const double smallBorderRadiusValue = 5;
  static const double auctionGridItemBorderRadiusValue = 20;
  static const double uploadImageButtonBorderRadiusValue = 12;
  static const double defaultBorderRadiusValue = 8;
  static const LatLng defaultMapLatLng = LatLng(8.662471152081386,
      1.0180393971192057); // Coordinate of Togo country center

/*<--------Screen horizontal padding value------->*/
  static const double screenPaddingValue = 24;

  static BorderRadius borderRadius(double radiusValue) =>
      BorderRadius.all(Radius.circular(radiusValue));

  static const String hiveBoxName = 'car2go';

  static const double defaultMapZoomLevel = 12.4746;

  static const double unknownLatLongValue = -999;
  static const CameraPosition defaultMapCameraPosition = CameraPosition(
    target: defaultMapLatLng,
    zoom: defaultMapZoomLevel,
  );
}
