import 'dart:convert';

import 'Location.dart';

class From {
  String type;
  String id;
  Map<String, double> coord;
  String place;
  String name;
  List<String> products;
  int lonAs1E6;
  int latAs1E6;
  double lonAsDouble;
  bool identified;
  double latAsDouble;

  From({
    this.type,
    this.id,
    this.coord,
    this.place,
    this.name,
    this.products,
    this.lonAs1E6,
    this.latAs1E6,
    this.lonAsDouble,
    this.identified,
    this.latAsDouble,
  });

  factory From.fromRawJson(String str) => From.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory From.fromJson(Map<String, dynamic> json) => new From(
    type: json["type"] == null ? null : json["type"],
    id: json["id"] == null ? null : json["id"],
    coord: json["coord"] == null ? null : new Map.from(json["coord"]).map((k, v) => new MapEntry<String, double>(k, v.toDouble())),
    place: json["place"] == null ? null : json["place"],
    name: json["name"] == null ? null : json["name"],
    products: json["products"] == null ? null : new List<String>.from(json["products"].map((x) => x)),
    lonAs1E6: json["lonAs1E6"] == null ? null : json["lonAs1E6"],
    latAs1E6: json["latAs1E6"] == null ? null : json["latAs1E6"],
    lonAsDouble: json["lonAsDouble"] == null ? null : json["lonAsDouble"].toDouble(),
    identified: json["identified"] == null ? null : json["identified"],
    latAsDouble: json["latAsDouble"] == null ? null : json["latAsDouble"].toDouble(),
  );

  static toLocation(From from) => new Location(
    type: from.type == null ? null : from.type,
    id: from.id == null ? null : from.id,
    coord: from.coord == null ? null : new Map.from(from.coord).map((k, v) => new MapEntry<String, double>(k, v.toDouble())),
    place: from.place,
    name: from.name == null ? null : from.name,
    products: from.products == null ? null : new List<String>.from(from.products.map((x) => x)),
    lonAs1E6: from.lonAs1E6 == null ? null : from.lonAs1E6,
    latAs1E6: from.latAs1E6 == null ? null : from.latAs1E6,
    latAsDouble: from.latAsDouble == null ? null : from.latAsDouble,
    lonAsDouble: from.lonAsDouble == null ? null : from.lonAsDouble,
    identified: from.identified == null ? null : from.identified,
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "id": id == null ? null : id,
    "coord": coord == null ? null : new Map.from(coord).map((k, v) => new MapEntry<String, dynamic>(k, v)),
    "place": place == null ? null : place,
    "name": name == null ? null : name,
    "products": products == null ? null : new List<dynamic>.from(products.map((x) => x)),
    "lonAs1E6": lonAs1E6 == null ? null : lonAs1E6,
    "latAs1E6": latAs1E6 == null ? null : latAs1E6,
    "lonAsDouble": lonAsDouble == null ? null : lonAsDouble,
    "identified": identified == null ? null : identified,
    "latAsDouble": latAsDouble == null ? null : latAsDouble,
  };
}