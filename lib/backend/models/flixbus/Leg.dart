import 'dart:convert';

import 'Destination.dart';
import 'Operator.dart';

class Leg {
  Destination origin;
  Destination destination;
  DateTime departure;
  DateTime arrival;
  Operator legOperator;
  String mode;
  bool public;

  Leg({
    this.origin,
    this.destination,
    this.departure,
    this.arrival,
    this.legOperator,
    this.mode,
    this.public,
  });

  factory Leg.fromRawJson(String str) => Leg.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Leg.fromJson(Map<String, dynamic> json) => new Leg(
    origin: json["origin"] == null ? null : Destination.fromJson(json["origin"]),
    destination: json["destination"] == null ? null : Destination.fromJson(json["destination"]),
    departure: json["departure"] == null ? null : DateTime.parse(json["departure"]),
    arrival: json["arrival"] == null ? null : DateTime.parse(json["arrival"]),
    legOperator: json["operator"] == null ? null : Operator.fromJson(json["operator"]),
    mode: json["mode"] == null ? null : json["mode"],
    public: json["public"] == null ? null : json["public"],
  );

  Map<String, dynamic> toJson() => {
    "origin": origin == null ? null : origin.toJson(),
    "destination": destination == null ? null : destination.toJson(),
    "departure": departure == null ? null : departure.toIso8601String(),
    "arrival": arrival == null ? null : arrival.toIso8601String(),
    "operator": legOperator == null ? null : legOperator.toJson(),
    "mode": mode == null ? null : mode,
    "public": public == null ? null : public,
  };
}