import 'dart:convert';

class Geocoordinates {
  double latitude;
  double longitude;

  Geocoordinates({
    this.latitude,
    this.longitude,
  });

  factory Geocoordinates.fromRawJson(String str) => Geocoordinates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geocoordinates.fromJson(Map<String, dynamic> json) => new Geocoordinates(
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
  };
}