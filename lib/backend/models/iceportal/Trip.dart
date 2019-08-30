import 'dart:convert';

import 'Stop.dart';
import 'StopInfo.dart';

class Trip {
  DateTime tripDate;
  String trainType;
  String vzn;
  int actualPosition;
  int distanceFromLastStop;
  int totalDistance;
  StopInfo stopInfo;
  List<Stop> stops;

  Trip({
    this.tripDate,
    this.trainType,
    this.vzn,
    this.actualPosition,
    this.distanceFromLastStop,
    this.totalDistance,
    this.stopInfo,
    this.stops,
  });

  factory Trip.fromRawJson(String str) => Trip.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Trip.fromJson(Map<String, dynamic> json) => new Trip(
    tripDate: json["tripDate"] == null ? null : DateTime.parse(json["tripDate"]),
    trainType: json["trainType"] == null ? null : json["trainType"],
    vzn: json["vzn"] == null ? null : json["vzn"],
    actualPosition: json["actualPosition"] == null ? null : json["actualPosition"],
    distanceFromLastStop: json["distanceFromLastStop"] == null ? null : json["distanceFromLastStop"],
    totalDistance: json["totalDistance"] == null ? null : json["totalDistance"],
    stopInfo: json["stopInfo"] == null ? null : StopInfo.fromJson(json["stopInfo"]),
    stops: json["stops"] == null ? null : new List<Stop>.from(json["stops"].map((x) => Stop.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tripDate": tripDate == null ? null : "${tripDate.year.toString().padLeft(4, '0')}-${tripDate.month.toString().padLeft(2, '0')}-${tripDate.day.toString().padLeft(2, '0')}",
    "trainType": trainType == null ? null : trainType,
    "vzn": vzn == null ? null : vzn,
    "actualPosition": actualPosition == null ? null : actualPosition,
    "distanceFromLastStop": distanceFromLastStop == null ? null : distanceFromLastStop,
    "totalDistance": totalDistance == null ? null : totalDistance,
    "stopInfo": stopInfo == null ? null : stopInfo.toJson(),
    "stops": stops == null ? null : new List<dynamic>.from(stops.map((x) => x.toJson())),
  };
}