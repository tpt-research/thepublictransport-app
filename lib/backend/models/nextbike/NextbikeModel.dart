import 'dart:convert';

import 'Data.dart';

class NextbikeModel {
  int lastUpdated;
  int ttl;
  Data data;

  NextbikeModel({
    this.lastUpdated,
    this.ttl,
    this.data,
  });

  factory NextbikeModel.fromRawJson(String str) => NextbikeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NextbikeModel.fromJson(Map<String, dynamic> json) => NextbikeModel(
    lastUpdated: json["last_updated"] == null ? null : json["last_updated"],
    ttl: json["ttl"] == null ? null : json["ttl"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "last_updated": lastUpdated == null ? null : lastUpdated,
    "ttl": ttl == null ? null : ttl,
    "data": data == null ? null : data.toJson(),
  };
}