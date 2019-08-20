import 'dart:convert';

import 'package:thepublictransport_app/backend/models/main/Location.dart';


class SuggestedLocation {
  Location location;
  int priority;

  SuggestedLocation({
    this.location,
    this.priority,
  });

  factory SuggestedLocation.fromRawJson(String str) => SuggestedLocation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SuggestedLocation.fromJson(Map<String, dynamic> json) => new SuggestedLocation(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    priority: json["priority"] == null ? null : json["priority"],
  );

  Map<String, dynamic> toJson() => {
    "location": location == null ? null : location.toJson(),
    "priority": priority == null ? null : priority,
  };
}