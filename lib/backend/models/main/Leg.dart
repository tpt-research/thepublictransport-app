import 'dart:convert';

import 'From.dart';
import 'Line.dart';
import 'Position.dart';
import 'Stop.dart';

class Leg {
  From departure;
  From arrival;
  Line line;
  From destination;
  Stop departureStop;
  Stop arrivalStop;
  List<Stop> intermediateStops;
  dynamic message;
  bool departureTimePredicted;
  Position arrivalPosition;
  dynamic departureDelay;
  bool departurePositionPredicted;
  Position departurePosition;
  bool arrivalTimePredicted;
  int departureTime;
  int arrivalTime;
  bool arrivalPositionPredicted;
  dynamic arrivalDelay;
  int maxTime;
  int minTime;
  String type;
  int min;
  int distance;

  Leg({
    this.departure,
    this.arrival,
    this.line,
    this.destination,
    this.departureStop,
    this.arrivalStop,
    this.intermediateStops,
    this.message,
    this.departureTimePredicted,
    this.arrivalPosition,
    this.departureDelay,
    this.departurePositionPredicted,
    this.departurePosition,
    this.arrivalTimePredicted,
    this.departureTime,
    this.arrivalTime,
    this.arrivalPositionPredicted,
    this.arrivalDelay,
    this.maxTime,
    this.minTime,
    this.type,
    this.min,
    this.distance,
  });

  factory Leg.fromRawJson(String str) => Leg.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Leg.fromJson(Map<String, dynamic> json) => new Leg(
    departure: json["departure"] == null ? null : From.fromJson(json["departure"]),
    arrival: json["arrival"] == null ? null : From.fromJson(json["arrival"]),
    line: json["line"] == null ? null : Line.fromJson(json["line"]),
    destination: json["destination"] == null ? null : From.fromJson(json["destination"]),
    departureStop: json["departureStop"] == null ? null : Stop.fromJson(json["departureStop"]),
    arrivalStop: json["arrivalStop"] == null ? null : Stop.fromJson(json["arrivalStop"]),
    intermediateStops: json["intermediateStops"] == null ? null : new List<Stop>.from(json["intermediateStops"].map((x) => Stop.fromJson(x))),
    message: json["message"],
    departureTimePredicted: json["departureTimePredicted"] == null ? null : json["departureTimePredicted"],
    arrivalPosition: json["arrivalPosition"] == null ? null : Position.fromJson(json["arrivalPosition"]),
    departureDelay: json["departureDelay"],
    departurePositionPredicted: json["departurePositionPredicted"] == null ? null : json["departurePositionPredicted"],
    departurePosition: json["departurePosition"] == null ? null : Position.fromJson(json["departurePosition"]),
    arrivalTimePredicted: json["arrivalTimePredicted"] == null ? null : json["arrivalTimePredicted"],
    departureTime: json["departureTime"] == null ? null : json["departureTime"],
    arrivalTime: json["arrivalTime"] == null ? null : json["arrivalTime"],
    arrivalPositionPredicted: json["arrivalPositionPredicted"] == null ? null : json["arrivalPositionPredicted"],
    arrivalDelay: json["arrivalDelay"],
    maxTime: json["maxTime"] == null ? null : json["maxTime"],
    minTime: json["minTime"] == null ? null : json["minTime"],
    type: json["type"] == null ? null : json["type"],
    min: json["min"] == null ? null : json["min"],
    distance: json["distance"] == null ? null : json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "departure": departure == null ? null : departure.toJson(),
    "arrival": arrival == null ? null : arrival.toJson(),
    "line": line == null ? null : line.toJson(),
    "destination": destination == null ? null : destination.toJson(),
    "departureStop": departureStop == null ? null : departureStop.toJson(),
    "arrivalStop": arrivalStop == null ? null : arrivalStop.toJson(),
    "intermediateStops": intermediateStops == null ? null : new List<dynamic>.from(intermediateStops.map((x) => x.toJson())),
    "message": message,
    "departureTimePredicted": departureTimePredicted == null ? null : departureTimePredicted,
    "arrivalPosition": arrivalPosition == null ? null : arrivalPosition.toJson(),
    "departureDelay": departureDelay,
    "departurePositionPredicted": departurePositionPredicted == null ? null : departurePositionPredicted,
    "departurePosition": departurePosition == null ? null : departurePosition.toJson(),
    "arrivalTimePredicted": arrivalTimePredicted == null ? null : arrivalTimePredicted,
    "departureTime": departureTime == null ? null : departureTime,
    "arrivalTime": arrivalTime == null ? null : arrivalTime,
    "arrivalPositionPredicted": arrivalPositionPredicted == null ? null : arrivalPositionPredicted,
    "arrivalDelay": arrivalDelay,
    "maxTime": maxTime == null ? null : maxTime,
    "minTime": minTime == null ? null : minTime,
    "type": type == null ? null : type,
    "min": min == null ? null : min,
    "distance": distance == null ? null : distance,
  };
}