import 'dart:convert';

import 'From.dart';
import 'Position.dart';

class Stop {
  From location;
  int plannedArrivalTime;
  dynamic predictedArrivalTime;
  Position plannedArrivalPosition;
  dynamic predictedArrivalPosition;
  bool arrivalCancelled;
  int plannedDepartureTime;
  dynamic predictedDepartureTime;
  Position plannedDeparturePosition;
  dynamic predictedDeparturePosition;
  bool departureCancelled;
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

  Stop({
    this.location,
    this.plannedArrivalTime,
    this.predictedArrivalTime,
    this.plannedArrivalPosition,
    this.predictedArrivalPosition,
    this.arrivalCancelled,
    this.plannedDepartureTime,
    this.predictedDepartureTime,
    this.plannedDeparturePosition,
    this.predictedDeparturePosition,
    this.departureCancelled,
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

  factory Stop.fromRawJson(String str) => Stop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stop.fromJson(Map<String, dynamic> json) => new Stop(
    location: json["location"] == null ? null : From.fromJson(json["location"]),
    plannedArrivalTime: json["plannedArrivalTime"] == null ? null : json["plannedArrivalTime"],
    predictedArrivalTime: json["predictedArrivalTime"],
    plannedArrivalPosition: json["plannedArrivalPosition"] == null ? null : Position.fromJson(json["plannedArrivalPosition"]),
    predictedArrivalPosition: json["predictedArrivalPosition"],
    arrivalCancelled: json["arrivalCancelled"] == null ? null : json["arrivalCancelled"],
    plannedDepartureTime: json["plannedDepartureTime"] == null ? null : json["plannedDepartureTime"],
    predictedDepartureTime: json["predictedDepartureTime"],
    plannedDeparturePosition: json["plannedDeparturePosition"] == null ? null : Position.fromJson(json["plannedDeparturePosition"]),
    predictedDeparturePosition: json["predictedDeparturePosition"],
    departureCancelled: json["departureCancelled"] == null ? null : json["departureCancelled"],
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
  );

  Map<String, dynamic> toJson() => {
    "location": location == null ? null : location.toJson(),
    "plannedArrivalTime": plannedArrivalTime == null ? null : plannedArrivalTime,
    "predictedArrivalTime": predictedArrivalTime,
    "plannedArrivalPosition": plannedArrivalPosition == null ? null : plannedArrivalPosition.toJson(),
    "predictedArrivalPosition": predictedArrivalPosition,
    "arrivalCancelled": arrivalCancelled == null ? null : arrivalCancelled,
    "plannedDepartureTime": plannedDepartureTime == null ? null : plannedDepartureTime,
    "predictedDepartureTime": predictedDepartureTime,
    "plannedDeparturePosition": plannedDeparturePosition == null ? null : plannedDeparturePosition.toJson(),
    "predictedDeparturePosition": predictedDeparturePosition,
    "departureCancelled": departureCancelled == null ? null : departureCancelled,
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
  };
}