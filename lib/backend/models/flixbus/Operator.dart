import 'dart:convert';

class Operator {
  String type;
  String id;
  String name;
  String url;
  String address;

  Operator({
    this.type,
    this.id,
    this.name,
    this.url,
    this.address,
  });

  factory Operator.fromRawJson(String str) => Operator.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Operator.fromJson(Map<String, dynamic> json) => new Operator(
    type: json["type"] == null ? null : json["type"],
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    url: json["url"] == null ? null : json["url"],
    address: json["address"] == null ? null : json["address"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "url": url == null ? null : url,
    "address": address == null ? null : address,
  };
}