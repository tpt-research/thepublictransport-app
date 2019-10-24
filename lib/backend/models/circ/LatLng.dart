import 'dart:convert';

import 'Geometry.dart';

class LatLng {
  Geometry geometry;
  bool isNull;
  int srid;

  LatLng({
    this.geometry,
    this.isNull,
    this.srid,
  });

  factory LatLng.fromRawJson(String str) => LatLng.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LatLng.fromJson(Map<String, dynamic> json) => LatLng(
    geometry: json["_geometry"] == null ? null : Geometry.fromJson(json["_geometry"]),
    isNull: json["_isNull"] == null ? null : json["_isNull"],
    srid: json["_srid"] == null ? null : json["_srid"],
  );

  Map<String, dynamic> toJson() => {
    "_geometry": geometry == null ? null : geometry.toJson(),
    "_isNull": isNull == null ? null : isNull,
    "_srid": srid == null ? null : srid,
  };
}