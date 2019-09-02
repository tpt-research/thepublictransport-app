import 'dart:convert';

import 'Destination.dart';
import 'Line.dart';

class Leg {
  Destination origin;
  DateTime departure;
  String departurePlatform;
  Destination destination;
  DateTime arrival;
  String arrivalPlatform;
  Line line;

  Leg({
    this.origin,
    this.departure,
    this.departurePlatform,
    this.destination,
    this.arrival,
    this.arrivalPlatform,
    this.line,
  });

  factory Leg.fromRawJson(String str) => Leg.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Leg.fromJson(Map<String, dynamic> json) => new Leg(
    origin: json["origin"] == null ? null : Destination.fromJson(json["origin"]),
    departure: json["departure"] == null ? null : DateTime.parse(json["departure"]),
    departurePlatform: json["departurePlatform"] == null ? null : json["departurePlatform"],
    destination: json["destination"] == null ? null : Destination.fromJson(json["destination"]),
    arrival: json["arrival"] == null ? null : DateTime.parse(json["arrival"]),
    arrivalPlatform: json["arrivalPlatform"] == null ? null : json["arrivalPlatform"],
    line: json["line"] == null ? null : Line.fromJson(json["line"]),
  );

  Map<String, dynamic> toJson() => {
    "origin": origin == null ? null : origin.toJson(),
    "departure": departure == null ? null : departure.toIso8601String(),
    "departurePlatform": departurePlatform == null ? null : departurePlatform,
    "destination": destination == null ? null : destination.toJson(),
    "arrival": arrival == null ? null : arrival.toIso8601String(),
    "arrivalPlatform": arrivalPlatform == null ? null : arrivalPlatform,
    "line": line == null ? null : line.toJson(),
  };
}