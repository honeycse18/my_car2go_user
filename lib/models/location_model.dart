class LocationModel {
  String address;
  double latitude;
  double longitude;
  LocationModel(
      {this.address = '', required this.latitude, required this.longitude});

  factory LocationModel.empty() => LocationModel(latitude: 0, longitude: 0);
}
