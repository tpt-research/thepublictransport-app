import 'dart:convert';

import 'Geocoordinates.dart';

class Station {
  String evaNr;
  String name;
  Geocoordinates geocoordinates;

  Station({
    this.evaNr,
    this.name,
    this.geocoordinates,
  });

  factory Station.fromRawJson(String str) => Station.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Station.fromJson(Map<String, dynamic> json) => new Station(
    evaNr: json["evaNr"] == null ? null : json["evaNr"],
    name: json["name"] == null ? null : json["name"],
    geocoordinates: json["geocoordinates"] == null ? null : Geocoordinates.fromJson(json["geocoordinates"]),
  );

  Map<String, dynamic> toJson() => {
    "evaNr": evaNr == null ? null : evaNr,
    "name": name == null ? null : name,
    "geocoordinates": geocoordinates == null ? null : geocoordinates.toJson(),
  };
}