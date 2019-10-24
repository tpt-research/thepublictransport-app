import 'dart:convert';

class City {
  String idCity;
  String rideablePolygon;
  double latitudeCityCenter;
  double longitudeCityCenter;
  int redPolygonSizeKm;
  String cityOverlayRedColor;
  String cityOverlayRedBorderColor;
  String cityOverlayGreenColor;
  String cityOverlayGreenBorderColor;
  List<dynamic> specialAreas;

  City({
    this.idCity,
    this.rideablePolygon,
    this.latitudeCityCenter,
    this.longitudeCityCenter,
    this.redPolygonSizeKm,
    this.cityOverlayRedColor,
    this.cityOverlayRedBorderColor,
    this.cityOverlayGreenColor,
    this.cityOverlayGreenBorderColor,
    this.specialAreas,
  });

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
    idCity: json["idCity"] == null ? null : json["idCity"],
    rideablePolygon: json["RideablePolygon"] == null ? null : json["RideablePolygon"],
    latitudeCityCenter: json["LatitudeCityCenter"] == null ? null : json["LatitudeCityCenter"].toDouble(),
    longitudeCityCenter: json["LongitudeCityCenter"] == null ? null : json["LongitudeCityCenter"].toDouble(),
    redPolygonSizeKm: json["RedPolygonSizeKm"] == null ? null : json["RedPolygonSizeKm"],
    cityOverlayRedColor: json["cityOverlayRedColor"] == null ? null : json["cityOverlayRedColor"],
    cityOverlayRedBorderColor: json["cityOverlayRedBorderColor"] == null ? null : json["cityOverlayRedBorderColor"],
    cityOverlayGreenColor: json["cityOverlayGreenColor"] == null ? null : json["cityOverlayGreenColor"],
    cityOverlayGreenBorderColor: json["cityOverlayGreenBorderColor"] == null ? null : json["cityOverlayGreenBorderColor"],
    specialAreas: json["SpecialAreas"] == null ? null : List<dynamic>.from(json["SpecialAreas"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "idCity": idCity == null ? null : idCity,
    "RideablePolygon": rideablePolygon == null ? null : rideablePolygon,
    "LatitudeCityCenter": latitudeCityCenter == null ? null : latitudeCityCenter,
    "LongitudeCityCenter": longitudeCityCenter == null ? null : longitudeCityCenter,
    "RedPolygonSizeKm": redPolygonSizeKm == null ? null : redPolygonSizeKm,
    "cityOverlayRedColor": cityOverlayRedColor == null ? null : cityOverlayRedColor,
    "cityOverlayRedBorderColor": cityOverlayRedBorderColor == null ? null : cityOverlayRedBorderColor,
    "cityOverlayGreenColor": cityOverlayGreenColor == null ? null : cityOverlayGreenColor,
    "cityOverlayGreenBorderColor": cityOverlayGreenBorderColor == null ? null : cityOverlayGreenBorderColor,
    "SpecialAreas": specialAreas == null ? null : List<dynamic>.from(specialAreas.map((x) => x)),
  };
}