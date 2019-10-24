import 'dart:convert';

import 'Bike.dart';

class Data {
  List<Bike> bikes;

  Data({
    this.bikes,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bikes: json["bikes"] == null ? null : List<Bike>.from(json["bikes"].map((x) => Bike.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bikes": bikes == null ? null : List<dynamic>.from(bikes.map((x) => x.toJson())),
  };
}