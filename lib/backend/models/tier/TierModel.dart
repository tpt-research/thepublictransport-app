import 'dart:convert';

import 'package:thepublictransport_app/backend/models/tier/Vehicle.dart';

import 'Meta.dart';

class TierModel {
  Meta meta;
  List<Vehicle> data;

  TierModel({
    this.meta,
    this.data,
  });

  factory TierModel.fromRawJson(String str) => TierModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TierModel.fromJson(Map<String, dynamic> json) => TierModel(
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null ? null : List<Vehicle>.from(json["data"].map((x) => Vehicle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta == null ? null : meta.toJson(),
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}