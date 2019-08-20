import 'dart:convert';

class Location {
  String type;
  String id;
  Map<String, double> coord;
  dynamic place;
  String name;
  List<String> products;
  int lonAs1E6;
  int latAs1E6;
  double latAsDouble;
  double lonAsDouble;
  bool identified;

  Location({
    this.type,
    this.id,
    this.coord,
    this.place,
    this.name,
    this.products,
    this.lonAs1E6,
    this.latAs1E6,
    this.latAsDouble,
    this.lonAsDouble,
    this.identified,
  });

  factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => new Location(
    type: json["type"] == null ? null : json["type"],
    id: json["id"] == null ? null : json["id"],
    coord: json["coord"] == null ? null : new Map.from(json["coord"]).map((k, v) => new MapEntry<String, double>(k, v.toDouble())),
    place: json["place"],
    name: json["name"] == null ? null : json["name"],
    products: json["products"] == null ? null : new List<String>.from(json["products"].map((x) => x)),
    lonAs1E6: json["lonAs1E6"] == null ? null : json["lonAs1E6"],
    latAs1E6: json["latAs1E6"] == null ? null : json["latAs1E6"],
    latAsDouble: json["latAsDouble"] == null ? null : json["latAsDouble"].toDouble(),
    lonAsDouble: json["lonAsDouble"] == null ? null : json["lonAsDouble"].toDouble(),
    identified: json["identified"] == null ? null : json["identified"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "id": id == null ? null : id,
    "coord": coord == null ? null : new Map.from(coord).map((k, v) => new MapEntry<String, dynamic>(k, v)),
    "place": place,
    "name": name == null ? null : name,
    "products": products == null ? null : new List<dynamic>.from(products.map((x) => x)),
    "lonAs1E6": lonAs1E6 == null ? null : lonAs1E6,
    "latAs1E6": latAs1E6 == null ? null : latAs1E6,
    "latAsDouble": latAsDouble == null ? null : latAsDouble,
    "lonAsDouble": lonAsDouble == null ? null : lonAsDouble,
    "identified": identified == null ? null : identified,
  };
}