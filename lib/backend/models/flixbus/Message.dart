import 'dart:convert';

import 'Info.dart';
import 'Leg.dart';
import 'Price.dart';

class Message {
  String type;
  String id;
  List<Leg> legs;
  String status;
  bool borders;
  Info info;
  Price price;

  Message({
    this.type,
    this.id,
    this.legs,
    this.status,
    this.borders,
    this.info,
    this.price,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => new Message(
    type: json["type"] == null ? null : json["type"],
    id: json["id"] == null ? null : json["id"],
    legs: json["legs"] == null ? null : new List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
    borders: json["borders"] == null ? null : json["borders"],
    info: json["info"] == null ? null : Info.fromJson(json["info"]),
    price: json["price"] == null ? null : Price.fromJson(json["price"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "id": id == null ? null : id,
    "legs": legs == null ? null : new List<dynamic>.from(legs.map((x) => x.toJson())),
    "status": status == null ? null : status,
    "borders": borders == null ? null : borders,
    "info": info == null ? null : info.toJson(),
    "price": price == null ? null : price.toJson(),
  };
}