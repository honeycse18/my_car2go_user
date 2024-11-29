import 'package:car2gouser/models/api_responses/carpolling/pulling_offer_details_response.dart';

class OfferOverViewScreenParameters {
  String id;
  String type;
  int seat;
  OfferOverViewScreenParameters(
      {required this.id, this.type = 'passenger', required this.seat});
}

class OfferOverViewBottomsheetScreenParameters {
  PullingOfferDetailsData requestDetails;
  String type;
  int seat;
  OfferOverViewBottomsheetScreenParameters(
      {required this.requestDetails,
      this.type = 'passenger',
      required this.seat});
}
