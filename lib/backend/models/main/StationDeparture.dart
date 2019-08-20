import 'dart:convert';

import 'package:thepublictransport_app/backend/models/main/Departure.dart';
import 'package:thepublictransport_app/backend/models/main/Location.dart';


class StationDeparture {
  Location location;
  List<Departure> departures;
  dynamic lines;

  StationDeparture({
    this.location,
    this.departures,
    this.lines,
  });

  factory StationDeparture.fromRawJson(String str) => StationDeparture.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StationDeparture.fromJson(Map<String, dynamic> json) => new StationDeparture(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    departures: json["departures"] == null ? null : new List<Departure>.from(json["departures"].map((x) => Departure.fromJson(x))),
    lines: json["lines"],
  );

  Map<String, dynamic> toJson() => {
    "location": location == null ? null : location.toJson(),
    "departures": departures == null ? null : new List<dynamic>.from(departures.map((x) => x.toJson())),
    "lines": lines,
  };


  Departure getFirstLine() {
    return departures.first;
  }

  Departure getSpecificLine(int index) {
    return departures[index];
  }
}