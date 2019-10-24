import 'dart:convert';

class Bike {
  String bikeId;
  double lat;
  double lon;
  int isReserved;
  int isDisabled;

  Bike({
    this.bikeId,
    this.lat,
    this.lon,
    this.isReserved,
    this.isDisabled,
  });

  factory Bike.fromRawJson(String str) => Bike.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bike.fromJson(Map<String, dynamic> json) => Bike(
    bikeId: json["bike_id"] == null ? null : json["bike_id"],
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lon: json["lon"] == null ? null : json["lon"].toDouble(),
    isReserved: json["is_reserved"] == null ? null : json["is_reserved"],
    isDisabled: json["is_disabled"] == null ? null : json["is_disabled"],
  );

  Map<String, dynamic> toJson() => {
    "bike_id": bikeId == null ? null : bikeId,
    "lat": lat == null ? null : lat,
    "lon": lon == null ? null : lon,
    "is_reserved": isReserved == null ? null : isReserved,
    "is_disabled": isDisabled == null ? null : isDisabled,
  };
}