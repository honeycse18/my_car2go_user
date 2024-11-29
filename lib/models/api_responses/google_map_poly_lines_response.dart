import 'package:car2gouser/utils/helpers/api_helper.dart';

class GoogleMapPolyLinesResponse {
  bool error;
  List<PolyLinesGeocodedWaypoint> geocodedWaypoints;
  List<PolyLinesRoute> routes;
  String status;

  GoogleMapPolyLinesResponse({
    this.error = false,
    this.geocodedWaypoints = const [],
    this.routes = const [],
    this.status = '',
  });

  factory GoogleMapPolyLinesResponse.fromJson(Map<String, dynamic> json) {
    return GoogleMapPolyLinesResponse(
      error: APIHelper.getSafeBool(json['error']),
      geocodedWaypoints: APIHelper.getSafeList(json['geocoded_waypoints'])
          .map(
              (e) => PolyLinesGeocodedWaypoint.getAPIResponseObjectSafeValue(e))
          .toList(),
      routes: APIHelper.getSafeList(json['routes'])
          .map((e) => PolyLinesRoute.getAPIResponseObjectSafeValue(e))
          .toList(),
      status: APIHelper.getSafeString(json['status']),
    );
  }

  Map<String, dynamic> toJson() => {
        'geocoded_waypoints': geocodedWaypoints.map((e) => e.toJson()).toList(),
        'routes': routes.map((e) => e.toJson()).toList(),
        'status': status,
      };

  static GoogleMapPolyLinesResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? GoogleMapPolyLinesResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : GoogleMapPolyLinesResponse();
}

class PolyLinesRoute {
  Bounds bounds;
  String copyrights;
  List<PolyLinesLeg> legs;
  PolyLinesOverviewPolyline overviewPolyline;
  String summary;
  List<dynamic> warnings;
  List<dynamic> waypointOrder;

  PolyLinesRoute({
    required this.bounds,
    this.copyrights = '',
    this.legs = const [],
    required this.overviewPolyline,
    this.summary = '',
    this.warnings = const [],
    this.waypointOrder = const [],
  });

  factory PolyLinesRoute.fromJson(Map<String, dynamic> json) => PolyLinesRoute(
        bounds: Bounds.getAPIResponseObjectSafeValue(json['bounds']),
        copyrights: APIHelper.getSafeString(json['copyrights']),
        legs: APIHelper.getSafeList(json['legs'])
            .map((e) => PolyLinesLeg.getAPIResponseObjectSafeValue(e))
            .toList(),
        overviewPolyline:
            PolyLinesOverviewPolyline.getAPIResponseObjectSafeValue(
                json['overview_polyline']),
        summary: APIHelper.getSafeString(json['summary']),
        warnings: json['warnings'],
        waypointOrder: json['waypoint_order'],
      );

  Map<String, dynamic> toJson() => {
        'bounds': bounds.toJson(),
        'copyrights': copyrights,
        'legs': legs.map((e) => e.toJson()).toList(),
        'overview_polyline': overviewPolyline.toJson(),
        'summary': summary,
        'warnings': warnings,
        'waypoint_order': waypointOrder,
      };

  factory PolyLinesRoute.empty() => PolyLinesRoute(
      bounds: Bounds.empty(), overviewPolyline: PolyLinesOverviewPolyline());
  static PolyLinesRoute getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PolyLinesRoute.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : PolyLinesRoute.empty();
}

class Bounds {
  PolyLinesNortheast northeast;
  PolyLinesSouthwest southwest;

  Bounds({required this.northeast, required this.southwest});

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
        northeast:
            PolyLinesNortheast.getAPIResponseObjectSafeValue(json['northeast']),
        southwest:
            PolyLinesSouthwest.getAPIResponseObjectSafeValue(json['southwest']),
      );

  Map<String, dynamic> toJson() => {
        'northeast': northeast.toJson(),
        'southwest': southwest.toJson(),
      };

  factory Bounds.empty() =>
      Bounds(northeast: PolyLinesNortheast(), southwest: PolyLinesSouthwest());
  static Bounds getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Bounds.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Bounds.empty();
}

class PolyLinesNortheast {
  double lat;
  double lng;

  PolyLinesNortheast({this.lat = 0, this.lng = 0});

  factory PolyLinesNortheast.fromJson(Map<String, dynamic> json) =>
      PolyLinesNortheast(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static PolyLinesNortheast getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PolyLinesNortheast.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PolyLinesNortheast();
}

class PolyLinesSouthwest {
  double lat;
  double lng;

  PolyLinesSouthwest({this.lat = 0, this.lng = 0});

  factory PolyLinesSouthwest.fromJson(Map<String, dynamic> json) =>
      PolyLinesSouthwest(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static PolyLinesSouthwest getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PolyLinesSouthwest.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PolyLinesSouthwest();
}

class PolyLinesLeg {
  PolyLinesDistance distance;
  PolyLinesDuration duration;
  String endAddress;
  PolyLinesEndLocation endLocation;
  String startAddress;
  PolyLinesStartLocation startLocation;
  List<PolyLinesStep> steps;
  List<dynamic> trafficSpeedEntry;
  List<dynamic> viaWaypoint;

  PolyLinesLeg({
    required this.distance,
    required this.duration,
    this.endAddress = '',
    required this.endLocation,
    this.startAddress = '',
    required this.startLocation,
    this.steps = const [],
    this.trafficSpeedEntry = const [],
    this.viaWaypoint = const [],
  });

  factory PolyLinesLeg.fromJson(Map<String, dynamic> json) => PolyLinesLeg(
        distance:
            PolyLinesDistance.getAPIResponseObjectSafeValue(json['distance']),
        duration:
            PolyLinesDuration.getAPIResponseObjectSafeValue(json['duration']),
        endAddress: APIHelper.getSafeString(json['end_address']),
        endLocation: PolyLinesEndLocation.getAPIResponseObjectSafeValue(
            json['end_location']),
        startAddress: APIHelper.getSafeString(json['start_address']),
        startLocation: PolyLinesStartLocation.getAPIResponseObjectSafeValue(
            json['start_location']),
        steps: APIHelper.getSafeList(json['steps'])
            .map((e) => PolyLinesStep.getAPIResponseObjectSafeValue(e))
            .toList(),
        trafficSpeedEntry: json['traffic_speed_entry'],
        viaWaypoint: json['via_waypoint'],
      );

  Map<String, dynamic> toJson() => {
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        'end_address': endAddress,
        'end_location': endLocation.toJson(),
        'start_address': startAddress,
        'start_location': startLocation.toJson(),
        'steps': steps.map((e) => e.toJson()).toList(),
        'traffic_speed_entry': trafficSpeedEntry,
        'via_waypoint': viaWaypoint,
      };

  factory PolyLinesLeg.empty() => PolyLinesLeg(
        distance: PolyLinesDistance(),
        duration: PolyLinesDuration(),
        endLocation: PolyLinesEndLocation(),
        startLocation: PolyLinesStartLocation(),
      );
  static PolyLinesLeg getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PolyLinesLeg.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : PolyLinesLeg.empty();
}

class PolyLinesDistance {
  String text;
  int value;

  PolyLinesDistance({this.text = '', this.value = 0});

  factory PolyLinesDistance.fromJson(Map<String, dynamic> json) =>
      PolyLinesDistance(
        text: APIHelper.getSafeString(json['text']),
        value: APIHelper.getSafeInt(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static PolyLinesDistance getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PolyLinesDistance.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PolyLinesDistance();
}

class PolyLinesDuration {
  String text;
  int value;

  PolyLinesDuration({this.text = '', this.value = 0});

  factory PolyLinesDuration.fromJson(Map<String, dynamic> json) =>
      PolyLinesDuration(
        text: APIHelper.getSafeString(json['text']),
        value: APIHelper.getSafeInt(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static PolyLinesDuration getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PolyLinesDuration.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PolyLinesDuration();
}

class PolyLinesEndLocation {
  double lat;
  double lng;

  PolyLinesEndLocation({this.lat = 0, this.lng = 0});

  factory PolyLinesEndLocation.fromJson(Map<String, dynamic> json) =>
      PolyLinesEndLocation(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static PolyLinesEndLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PolyLinesEndLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PolyLinesEndLocation();
}

class PolyLinesStartLocation {
  double lat;
  double lng;

  PolyLinesStartLocation({this.lat = 0, this.lng = 0});

  factory PolyLinesStartLocation.fromJson(Map<String, dynamic> json) =>
      PolyLinesStartLocation(
        lat: APIHelper.getSafeDouble(json['lat']),
        lng: APIHelper.getSafeDouble(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static PolyLinesStartLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PolyLinesStartLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PolyLinesStartLocation();
}

class PolyLinesStep {
  PolyLinesDistance distance;
  PolyLinesDuration duration;
  PolyLinesEndLocation endLocation;
  String htmlInstructions;
  PolyLinesPolyline polyline;
  PolyLinesStartLocation startLocation;
  String travelMode;
  String maneuver;

  PolyLinesStep({
    required this.distance,
    required this.duration,
    required this.endLocation,
    this.htmlInstructions = '',
    required this.polyline,
    required this.startLocation,
    this.travelMode = '',
    this.maneuver = '',
  });

  factory PolyLinesStep.fromJson(Map<String, dynamic> json) => PolyLinesStep(
        distance:
            PolyLinesDistance.getAPIResponseObjectSafeValue(json['distance']),
        duration:
            PolyLinesDuration.getAPIResponseObjectSafeValue(json['duration']),
        endLocation: PolyLinesEndLocation.getAPIResponseObjectSafeValue(
            json['end_location']),
        htmlInstructions: APIHelper.getSafeString(json['html_instructions']),
        polyline:
            PolyLinesPolyline.getAPIResponseObjectSafeValue(json['polyline']),
        startLocation: PolyLinesStartLocation.getAPIResponseObjectSafeValue(
            json['start_location']),
        travelMode: APIHelper.getSafeString(json['travel_mode']),
        maneuver: APIHelper.getSafeString(json['maneuver']),
      );

  Map<String, dynamic> toJson() => {
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        'end_location': endLocation.toJson(),
        'html_instructions': htmlInstructions,
        'polyline': polyline.toJson(),
        'start_location': startLocation.toJson(),
        'travel_mode': travelMode,
        'maneuver': maneuver,
      };

  factory PolyLinesStep.empty() => PolyLinesStep(
        distance: PolyLinesDistance(),
        duration: PolyLinesDuration(),
        endLocation: PolyLinesEndLocation(),
        polyline: PolyLinesPolyline(),
        startLocation: PolyLinesStartLocation(),
      );
  static PolyLinesStep getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PolyLinesStep.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : PolyLinesStep.empty();
}

class PolyLinesPolyline {
  String points;

  PolyLinesPolyline({this.points = ''});

  factory PolyLinesPolyline.fromJson(Map<String, dynamic> json) =>
      PolyLinesPolyline(
        points: APIHelper.getSafeString(json['points']),
      );

  Map<String, dynamic> toJson() => {
        'points': points,
      };

  static PolyLinesPolyline getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PolyLinesPolyline.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PolyLinesPolyline();
}

class PolyLinesOverviewPolyline {
  String points;

  PolyLinesOverviewPolyline({this.points = ''});

  factory PolyLinesOverviewPolyline.fromJson(Map<String, dynamic> json) {
    return PolyLinesOverviewPolyline(
      points: APIHelper.getSafeString(json['points']),
    );
  }

  Map<String, dynamic> toJson() => {
        'points': points,
      };

  static PolyLinesOverviewPolyline getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PolyLinesOverviewPolyline.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PolyLinesOverviewPolyline();
}

class PolyLinesGeocodedWaypoint {
  String geocoderStatus;
  String placeId;
  List<String> types;

  PolyLinesGeocodedWaypoint(
      {this.geocoderStatus = '', this.placeId = '', this.types = const []});

  factory PolyLinesGeocodedWaypoint.fromJson(Map<String, dynamic> json) {
    return PolyLinesGeocodedWaypoint(
      geocoderStatus: APIHelper.getSafeString(json['geocoder_status']),
      placeId: APIHelper.getSafeString(json['place_id']),
      types: APIHelper.getSafeList(json['types'])
          .map((e) => APIHelper.getSafeString(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'geocoder_status': geocoderStatus,
        'place_id': placeId,
        'types': types,
      };

  static PolyLinesGeocodedWaypoint getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PolyLinesGeocodedWaypoint.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PolyLinesGeocodedWaypoint();
}
