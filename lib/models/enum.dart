import 'package:car2gouser/utils/constants/app_constants.dart';

enum RideRequestStatus {
  accepted(AppConstants.rideRequestAccepted, 'Upcoming'),
  rejected(AppConstants.rideRequestRejected, 'Rejected'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const RideRequestStatus(this.stringValue, this.stringValueForView);

  static RideRequestStatus toEnumValue(String value) {
    final Map<String, RideRequestStatus> stringToEnumMap = {
      RideRequestStatus.accepted.stringValue: RideRequestStatus.accepted,
      RideRequestStatus.rejected.stringValue: RideRequestStatus.rejected,
      RideRequestStatus.unknown.stringValue: RideRequestStatus.unknown,
    };
    return stringToEnumMap[value] ?? RideRequestStatus.unknown;
  }
}

enum ShareRideHistoryStatus {
  offering(AppConstants.shareRideHistoryOffering, 'Offering'),
  findRide(AppConstants.shareRideHistoryOffering, 'Find Ride'),
  accepted(AppConstants.rideRequestAccepted, 'Upcoming'),
  started(AppConstants.ridePostAcceptanceStarted, 'Started'),
  completed(AppConstants.ridePostAcceptanceCompleted, 'Completed'),
  cancelled(AppConstants.ridePostAcceptanceCancelled, 'Cancelled'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const ShareRideHistoryStatus(this.stringValue, this.stringValueForView);

  static ShareRideHistoryStatus toEnumValue(String value) {
    final Map<String, ShareRideHistoryStatus> stringToEnumMap = {
      ShareRideHistoryStatus.offering.stringValue:
          ShareRideHistoryStatus.offering,
      ShareRideHistoryStatus.findRide.stringValue:
          ShareRideHistoryStatus.findRide,
      ShareRideHistoryStatus.unknown.stringValue:
          ShareRideHistoryStatus.unknown,
    };
    return stringToEnumMap[value] ?? ShareRideHistoryStatus.unknown;
  }
}

enum ShareRideActions {
  myRequest(AppConstants.shareRideActionMyRequest, 'Find Ride'),
  myOffer(AppConstants.shareRideActionMyOffer, 'Offer Ride'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const ShareRideActions(this.stringValue, this.stringValueForView);

  static ShareRideActions toEnumValue(String value) {
    final Map<String, ShareRideActions> stringToEnumMap = {
      ShareRideActions.myRequest.stringValue: ShareRideActions.myRequest,
      ShareRideActions.myOffer.stringValue: ShareRideActions.myOffer,
      ShareRideActions.unknown.stringValue: ShareRideActions.unknown
    };
    return stringToEnumMap[value] ?? ShareRideActions.unknown;
  }
}

enum RideHistoryStatus {
  pending(AppConstants.orderStatusPending, 'Pending'),
  accepted(AppConstants.rideRequestAccepted, 'Upcoming'),
  started(AppConstants.ridePostAcceptanceStarted, 'Started'),
  completed(AppConstants.ridePostAcceptanceCompleted, 'Completed'),
  cancelled(AppConstants.ridePostAcceptanceCancelled, 'Cancelled'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;
  const RideHistoryStatus(this.stringValue, this.stringValueForView);

  static RideHistoryStatus toEnumValue(String value) {
    final Map<String, RideHistoryStatus> stringToEnumMap = {
      RideHistoryStatus.pending.stringValue: RideHistoryStatus.pending,
      RideHistoryStatus.accepted.stringValue: RideHistoryStatus.accepted,
      RideHistoryStatus.started.stringValue: RideHistoryStatus.started,
      RideHistoryStatus.completed.stringValue: RideHistoryStatus.completed,
      RideHistoryStatus.cancelled.stringValue: RideHistoryStatus.cancelled,
      RideHistoryStatus.unknown.stringValue: RideHistoryStatus.unknown
    };
    return stringToEnumMap[value] ?? RideHistoryStatus.unknown;
  }
}

enum RentCarStatusStatus {
  hourly(AppConstants.rentCarStatusHourly, 'Hourly'),
  weekly(AppConstants.rentCarStatusWeekly, 'Weekly'),
  monthly(AppConstants.rentCarStatusMonthly, 'Monthly');

  final String stringValue;
  final String stringValueForView;
  const RentCarStatusStatus(this.stringValue, this.stringValueForView);

  static RentCarStatusStatus toEnumValue(String value) {
    final Map<String, RentCarStatusStatus> stringToEnumMap = {
      RentCarStatusStatus.hourly.stringValue: RentCarStatusStatus.hourly,
      RentCarStatusStatus.weekly.stringValue: RentCarStatusStatus.weekly,
      RentCarStatusStatus.monthly.stringValue: RentCarStatusStatus.monthly,
    };
    return stringToEnumMap[value] ?? RentCarStatusStatus.hourly;
  }
}

enum ShareRideAllStatus {
  active(AppConstants.shareRideAllStatusActive, 'Active'),
  accepted(AppConstants.shareRideAllStatusAccepted, 'Accepted'),
  reject(AppConstants.shareRideAllStatusRejected, 'Rejected'),
  pending(AppConstants.shareRideAllStatusPending, 'Pending'),
  started(AppConstants.shareRideAllStatusStarted, 'Started'),
  completed(AppConstants.shareRideAllStatusCompleted, 'Completed'),
  cancelled(AppConstants.shareRideAllStatusCancelled, 'Cancelled'),
  unknown(AppConstants.unknown, 'Unknown');

  final String stringValue;
  final String stringValueForView;

  const ShareRideAllStatus(this.stringValue, this.stringValueForView);

  static ShareRideAllStatus toEnumValue(String value) {
    final Map<String, ShareRideAllStatus> stringToEnumMap = {
      ShareRideAllStatus.active.stringValue: ShareRideAllStatus.active,
      ShareRideAllStatus.accepted.stringValue: ShareRideAllStatus.accepted,
      ShareRideAllStatus.reject.stringValue: ShareRideAllStatus.reject,
      ShareRideAllStatus.pending.stringValue: ShareRideAllStatus.pending,
      ShareRideAllStatus.started.stringValue: ShareRideAllStatus.started,
      ShareRideAllStatus.completed.stringValue: ShareRideAllStatus.completed,
      ShareRideAllStatus.cancelled.stringValue: ShareRideAllStatus.cancelled,
    };
    return stringToEnumMap[value] ?? ShareRideAllStatus.unknown;
  }
}
