import 'dart:convert';

import 'Destination.dart';
import 'Leg.dart';
import 'Price.dart';

class Message {
  String type;
  String id;
  Destination origin;
  Destination destination;
  List<Leg> legs;
  Price price;
  bool nightTrain;

  Message({
    this.type,
    this.id,
    this.origin,
    this.destination,
    this.legs,
    this.price,
    this.nightTrain,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => new Message(
    type: json["type"] == null ? null : json["type"],
    id: json["id"] == null ? null : json["id"],
    origin: json["origin"] == null ? null : Destination.fromJson(json["origin"]),
    destination: json["destination"] == null ? null : Destination.fromJson(json["destination"]),
    legs: json["legs"] == null ? null : new List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
    price: json["price"] == null ? null : Price.fromJson(json["price"]),
    nightTrain: json["nightTrain"] == null ? null : json["nightTrain"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "id": id == null ? null : id,
    "origin": origin == null ? null : origin.toJson(),
    "destination": destination == null ? null : destination.toJson(),
    "legs": legs == null ? null : new List<dynamic>.from(legs.map((x) => x.toJson())),
    "price": price == null ? null : price.toJson(),
    "nightTrain": nightTrain == null ? null : nightTrain,
  };
}