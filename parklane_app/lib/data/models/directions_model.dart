// To parse this JSON data, do
//
//     final directionRouteModel = directionRouteModelFromJson(jsonString);

import 'dart:convert';

DirectionRouteModel directionRouteModelFromJson(String str) =>
    DirectionRouteModel.fromMap(json.decode(str));

String directionRouteModelToJson(DirectionRouteModel data) =>
    json.encode(data.toJson());

class DirectionRouteModel {
  DirectionRouteModel({
    required this.routes,
    required this.waypoints,
    required this.code,
    required this.uuid,
  });

  final List<MapRoute> routes;
  final List<Waypoint> waypoints;
  final String code;
  final String uuid;

  factory DirectionRouteModel.fromMap(Map<String, dynamic> json) =>
      DirectionRouteModel(
        routes: List<MapRoute>.from(
            json["routes"].map((x) => MapRoute.fromJson(x))),
        waypoints: List<Waypoint>.from(
            json["waypoints"].map((x) => Waypoint.fromJson(x))),
        code: json["code"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
        "waypoints": List<dynamic>.from(waypoints.map((x) => x.toJson())),
        "code": code,
        "uuid": uuid,
      };
}

class MapRoute {
  MapRoute({
    required this.weightTypical,
    required this.durationTypical,
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
    required this.legs,
    required this.geometry,
  });

  final double weightTypical;
  final double durationTypical;
  final String weightName;
  final double weight;
  final double duration;
  final double distance;
  final List<Leg> legs;
  final Geometry geometry;

  factory MapRoute.fromJson(Map<String, dynamic> json) => MapRoute(
        weightTypical: json["weight_typical"].toDouble(),
        durationTypical: json["duration_typical"].toDouble(),
        weightName: json["weight_name"],
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        geometry: Geometry.fromJson(json["geometry"]),
      );

  Map<String, dynamic> toJson() => {
        "weight_typical": weightTypical,
        "duration_typical": durationTypical,
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
        "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
        "geometry": geometry.toJson(),
      };
}

class Geometry {
  Geometry({
    required this.coordinates,
    required this.type,
  });

  final List<List<double>> coordinates;
  final String type;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<List<double>>.from(json["coordinates"]
            .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(
            coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "type": type,
      };
}

class Leg {
  Leg({
    required this.viaWaypoints,
    required this.admins,
    required this.weightTypical,
    required this.durationTypical,
    required this.weight,
    required this.duration,
    required this.steps,
    required this.distance,
    required this.summary,
  });

  final List<dynamic> viaWaypoints;
  final List<Admin> admins;
  final double weightTypical;
  final double durationTypical;
  final double weight;
  final double duration;
  final List<dynamic> steps;
  final double distance;
  final String summary;

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        viaWaypoints: List<dynamic>.from(json["via_waypoints"].map((x) => x)),
        admins: List<Admin>.from(json["admins"].map((x) => Admin.fromJson(x))),
        weightTypical: json["weight_typical"].toDouble(),
        durationTypical: json["duration_typical"].toDouble(),
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        steps: List<dynamic>.from(json["steps"].map((x) => x)),
        distance: json["distance"].toDouble(),
        summary: json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "via_waypoints": List<dynamic>.from(viaWaypoints.map((x) => x)),
        "admins": List<dynamic>.from(admins.map((x) => x.toJson())),
        "weight_typical": weightTypical,
        "duration_typical": durationTypical,
        "weight": weight,
        "duration": duration,
        "steps": List<dynamic>.from(steps.map((x) => x)),
        "distance": distance,
        "summary": summary,
      };
}

class Admin {
  Admin({
    required this.iso31661Alpha3,
    required this.iso31661,
  });

  final String iso31661Alpha3;
  final String iso31661;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        iso31661Alpha3: json["iso_3166_1_alpha3"],
        iso31661: json["iso_3166_1"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1_alpha3": iso31661Alpha3,
        "iso_3166_1": iso31661,
      };
}

class Waypoint {
  Waypoint({
    required this.distance,
    required this.name,
    required this.location,
  });

  final double distance;
  final String name;
  final List<double> location;

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"].toDouble(),
        name: json["name"],
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "name": name,
        "location": List<dynamic>.from(location.map((x) => x)),
      };
}
