import 'dart:convert';

class Line {
  dynamic id;
  String network;
  String product;
  String label;
  String name;
  dynamic attrs;
  dynamic message;

  Line({
    this.id,
    this.network,
    this.product,
    this.label,
    this.name,
    this.attrs,
    this.message,
  });

  factory Line.fromRawJson(String str) => Line.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Line.fromJson(Map<String, dynamic> json) => new Line(
    id: json["id"],
    network: json["network"] == null ? null : json["network"],
    product: json["product"] == null ? null : json["product"],
    label: json["label"] == null ? null : json["label"],
    name: json["name"] == null ? null : json["name"],
    attrs: json["attrs"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "network": network == null ? null : network,
    "product": product == null ? null : product,
    "label": label == null ? null : label,
    "name": name == null ? null : name,
    "attrs": attrs,
    "message": message,
  };
}
