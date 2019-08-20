import 'dart:convert';

import 'From.dart';
import 'Line.dart';
import 'Stop.dart';

class FirstPublicLeg {
  From departure;
  From arrival;
  Line line;
  From destination;
  Stop departureStop;
  Stop arrivalStop;
  List<Stop> intermediateStops;
  dynamic message;
  bool departureTimePredicted;
  dynamic arrivalPosition;
  dynamic departureDelay;
  bool departurePositionPredicted;
  dynamic departurePosition;
  bool arrivalTimePredicted;
  int departureTime;
  int arrivalTime;
  bool arrivalPositionPredicted;
  dynamic arrivalDelay;
  int maxTime;
  int minTime;

  FirstPublicLeg({
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
  });

  factory FirstPublicLeg.fromRawJson(String str) => FirstPublicLeg.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FirstPublicLeg.fromJson(Map<String, dynamic> json) => new FirstPublicLeg(
    departure: json["departure"] == null ? null : From.fromJson(json["departure"]),
    arrival: json["arrival"] == null ? null : From.fromJson(json["arrival"]),
    line: json["line"] == null ? null : Line.fromJson(json["line"]),
    destination: json["destination"] == null ? null : From.fromJson(json["destination"]),
    departureStop: json["departureStop"] == null ? null : Stop.fromJson(json["departureStop"]),
    arrivalStop: json["arrivalStop"] == null ? null : Stop.fromJson(json["arrivalStop"]),
    intermediateStops: json["intermediateStops"] == null ? null : new List<Stop>.from(json["intermediateStops"].map((x) => Stop.fromJson(x))),
    message: json["message"],
    departureTimePredicted: json["departureTimePredicted"] == null ? null : json["departureTimePredicted"],
    arrivalPosition: json["arrivalPosition"],
    departureDelay: json["departureDelay"],
    departurePositionPredicted: json["departurePositionPredicted"] == null ? null : json["departurePositionPredicted"],
    departurePosition: json["departurePosition"],
    arrivalTimePredicted: json["arrivalTimePredicted"] == null ? null : json["arrivalTimePredicted"],
    departureTime: json["departureTime"] == null ? null : json["departureTime"],
    arrivalTime: json["arrivalTime"] == null ? null : json["arrivalTime"],
    arrivalPositionPredicted: json["arrivalPositionPredicted"] == null ? null : json["arrivalPositionPredicted"],
    arrivalDelay: json["arrivalDelay"],
    maxTime: json["maxTime"] == null ? null : json["maxTime"],
    minTime: json["minTime"] == null ? null : json["minTime"],
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
    "arrivalPosition": arrivalPosition,
    "departureDelay": departureDelay,
    "departurePositionPredicted": departurePositionPredicted == null ? null : departurePositionPredicted,
    "departurePosition": departurePosition,
    "arrivalTimePredicted": arrivalTimePredicted == null ? null : arrivalTimePredicted,
    "departureTime": departureTime == null ? null : departureTime,
    "arrivalTime": arrivalTime == null ? null : arrivalTime,
    "arrivalPositionPredicted": arrivalPositionPredicted == null ? null : arrivalPositionPredicted,
    "arrivalDelay": arrivalDelay,
    "maxTime": maxTime == null ? null : maxTime,
    "minTime": minTime == null ? null : minTime,
  };
}