import 'dart:convert';

import 'Line.dart';
import 'Position.dart';
import 'Location.dart';

class Departure {
  String plannedTime;
  dynamic predictedTime;
  Line line;
  Position position;
  Location destination;
  dynamic capacity;
  dynamic message;
  String time;

  Departure({
    this.plannedTime,
    this.predictedTime,
    this.line,
    this.position,
    this.destination,
    this.capacity,
    this.message,
    this.time,
  });

  factory Departure.fromRawJson(String str) => Departure.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Departure.fromJson(Map<String, dynamic> json) => new Departure(
    plannedTime: json["plannedTime"] == null ? null : json["plannedTime"],
    predictedTime: json["predictedTime"],
    line: json["line"] == null ? null : Line.fromJson(json["line"]),
    position: json["position"] == null ? null : Position.fromJson(json["position"]),
    destination: json["destination"] == null ? null : Location.fromJson(json["destination"]),
    capacity: json["capacity"],
    message: json["message"],
    time: json["time"] == null ? null : json["time"],
  );

  Map<String, dynamic> toJson() => {
    "plannedTime": plannedTime == null ? null : plannedTime,
    "predictedTime": predictedTime,
    "line": line == null ? null : line.toJson(),
    "position": position == null ? null : position.toJson(),
    "destination": destination == null ? null : destination.toJson(),
    "capacity": capacity,
    "message": message,
    "time": time == null ? null : time,
  };
}