class Location {
  String? name;
  double? lat;
  double? lng;
  String? city;
  String? country;
  String? countryLong;

  Location({
    this.name,
    this.lat,
    this.lng,
    this.city,
    this.country,
    this.countryLong,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json['name'] as String?,
        lat: (json['lat'] as num?)?.toDouble(),
        lng: (json['lng'] as num?)?.toDouble(),
        city: json['city'] as String?,
        country: json['country'] as String?,
        countryLong: json['country_long'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'lat': lat,
        'lng': lng,
        'city': city,
        'country': country,
        'country_long': countryLong,
      };
}
