import 'dart:convert';

class Location {
  double latitude;
  double longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
  };
}