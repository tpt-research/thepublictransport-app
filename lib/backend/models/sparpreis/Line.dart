import 'dart:convert';

class Line {
  String type;
  String id;
  String name;
  String mode;
  String product;

  Line({
    this.type,
    this.id,
    this.name,
    this.mode,
    this.product,
  });

  factory Line.fromRawJson(String str) => Line.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Line.fromJson(Map<String, dynamic> json) => new Line(
    type: json["type"] == null ? null : json["type"],
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    mode: json["mode"] == null ? null : json["mode"],
    product: json["product"] == null ? null : json["product"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "mode": mode == null ? null : mode,
    "product": product == null ? null : product,
  };
}