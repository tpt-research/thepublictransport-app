import 'dart:convert';

import 'package:thepublictransport_app/backend/models/main/Header.dart';
import 'package:thepublictransport_app/backend/models/main/Location.dart';
import 'package:thepublictransport_app/backend/models/main/SuggestedLocation.dart';

class LocationModel {
  Header header;
  String status;
  List<SuggestedLocation> suggestedLocations;
  List<Location> locations;

  LocationModel({
    this.header,
    this.status,
    this.suggestedLocations,
    this.locations,
  });

  factory LocationModel.fromRawJson(String str) => LocationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LocationModel.fromJson(Map<String, dynamic> json) => new LocationModel(
    header: json["header"] == null ? null : Header.fromJson(json["header"]),
    status: json["status"] == null ? null : json["status"],
    suggestedLocations: json["suggestedLocations"] == null ? null : new List<SuggestedLocation>.from(json["suggestedLocations"].map((x) => SuggestedLocation.fromJson(x))),
    locations: json["locations"] == null ? null : new List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "header": header == null ? null : header.toJson(),
    "status": status == null ? null : status,
    "suggestedLocations": suggestedLocations == null ? null : new List<dynamic>.from(suggestedLocations.map((x) => x.toJson())),
    "locations": locations == null ? null : new List<dynamic>.from(locations.map((x) => x.toJson())),
  };
}