import 'dart:convert';

import 'From.dart';

class Context {
  From from;
  dynamic via;
  From to;
  int date;
  bool dep;
  List<String> products;
  String walkSpeed;
  String laterContext;
  String earlierContext;

  Context({
    this.from,
    this.via,
    this.to,
    this.date,
    this.dep,
    this.products,
    this.walkSpeed,
    this.laterContext,
    this.earlierContext,
  });

  factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Context.fromJson(Map<String, dynamic> json) => new Context(
    from: json["from"] == null ? null : From.fromJson(json["from"]),
    via: json["via"],
    to: json["to"] == null ? null : From.fromJson(json["to"]),
    date: json["date"] == null ? null : json["date"],
    dep: json["dep"] == null ? null : json["dep"],
    products: json["products"] == null ? null : new List<String>.from(json["products"].map((x) => x)),
    walkSpeed: json["walkSpeed"] == null ? null : json["walkSpeed"],
    laterContext: json["laterContext"] == null ? null : json["laterContext"],
    earlierContext: json["earlierContext"] == null ? null : json["earlierContext"],
  );

  Map<String, dynamic> toJson() => {
    "from": from == null ? null : from.toJson(),
    "via": via,
    "to": to == null ? null : to.toJson(),
    "date": date == null ? null : date,
    "dep": dep == null ? null : dep,
    "products": products == null ? null : new List<dynamic>.from(products.map((x) => x)),
    "walkSpeed": walkSpeed == null ? null : walkSpeed,
    "laterContext": laterContext == null ? null : laterContext,
    "earlierContext": earlierContext == null ? null : earlierContext,
  };
}