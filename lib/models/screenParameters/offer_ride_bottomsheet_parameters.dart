import 'package:car2gouser/models/location_model.dart';

class OfferRideBottomSheetParameters {
  LocationModel pickUpLocation;
  LocationModel dropLocation;
  bool isCreateOffer;
  OfferRideBottomSheetParameters(
      {required this.pickUpLocation,
      required this.dropLocation,
      this.isCreateOffer = true});

  factory OfferRideBottomSheetParameters.empty() =>
      OfferRideBottomSheetParameters(
          pickUpLocation: LocationModel.empty(),
          dropLocation: LocationModel.empty());
}
