import 'dart:convert';

import 'FirstPublicLeg.dart';
import 'From.dart';
import 'LastPublicLeg.dart';
import 'Leg.dart';

class Trip {
  String id;
  From from;
  From to;
  List<Leg> legs;
  dynamic fares;
  dynamic capacity;
  int numChanges;
  LastPublicLeg lastPublicLeg;
  bool travelable;
  FirstPublicLeg firstPublicLeg;
  int firstPublicLegDepartureTime;
  int lastArrivalTime;
  int lastPublicLegArrivalTime;
  int publicDuration;
  int firstDepartureTime;
  int duration;
  int maxTime;
  int minTime;

  Trip({
    this.id,
    this.from,
    this.to,
    this.legs,
    this.fares,
    this.capacity,
    this.numChanges,
    this.lastPublicLeg,
    this.travelable,
    this.firstPublicLeg,
    this.firstPublicLegDepartureTime,
    this.lastArrivalTime,
    this.lastPublicLegArrivalTime,
    this.publicDuration,
    this.firstDepartureTime,
    this.duration,
    this.maxTime,
    this.minTime,
  });

  factory Trip.fromRawJson(String str) => Trip.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Trip.fromJson(Map<String, dynamic> json) => new Trip(
    id: json["id"] == null ? null : json["id"],
    from: json["from"] == null ? null : From.fromJson(json["from"]),
    to: json["to"] == null ? null : From.fromJson(json["to"]),
    legs: json["legs"] == null ? null : new List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
    fares: json["fares"],
    capacity: json["capacity"],
    numChanges: json["numChanges"] == null ? null : json["numChanges"],
    lastPublicLeg: json["lastPublicLeg"] == null ? null : LastPublicLeg.fromJson(json["lastPublicLeg"]),
    travelable: json["travelable"] == null ? null : json["travelable"],
    firstPublicLeg: json["firstPublicLeg"] == null ? null : FirstPublicLeg.fromJson(json["firstPublicLeg"]),
    firstPublicLegDepartureTime: json["firstPublicLegDepartureTime"] == null ? null : json["firstPublicLegDepartureTime"],
    lastArrivalTime: json["lastArrivalTime"] == null ? null : json["lastArrivalTime"],
    lastPublicLegArrivalTime: json["lastPublicLegArrivalTime"] == null ? null : json["lastPublicLegArrivalTime"],
    publicDuration: json["publicDuration"] == null ? null : json["publicDuration"],
    firstDepartureTime: json["firstDepartureTime"] == null ? null : json["firstDepartureTime"],
    duration: json["duration"] == null ? null : json["duration"],
    maxTime: json["maxTime"] == null ? null : json["maxTime"],
    minTime: json["minTime"] == null ? null : json["minTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "from": from == null ? null : from.toJson(),
    "to": to == null ? null : to.toJson(),
    "legs": legs == null ? null : new List<dynamic>.from(legs.map((x) => x.toJson())),
    "fares": fares,
    "capacity": capacity,
    "numChanges": numChanges == null ? null : numChanges,
    "lastPublicLeg": lastPublicLeg == null ? null : lastPublicLeg.toJson(),
    "travelable": travelable == null ? null : travelable,
    "firstPublicLeg": firstPublicLeg == null ? null : firstPublicLeg.toJson(),
    "firstPublicLegDepartureTime": firstPublicLegDepartureTime == null ? null : firstPublicLegDepartureTime,
    "lastArrivalTime": lastArrivalTime == null ? null : lastArrivalTime,
    "lastPublicLegArrivalTime": lastPublicLegArrivalTime == null ? null : lastPublicLegArrivalTime,
    "publicDuration": publicDuration == null ? null : publicDuration,
    "firstDepartureTime": firstDepartureTime == null ? null : firstDepartureTime,
    "duration": duration == null ? null : duration,
    "maxTime": maxTime == null ? null : maxTime,
    "minTime": minTime == null ? null : minTime,
  };
}