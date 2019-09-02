import 'dart:convert';

class Destination {
  String type;
  String id;
  String name;

  Destination({
    this.type,
    this.id,
    this.name,
  });

  factory Destination.fromRawJson(String str) => Destination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Destination.fromJson(Map<String, dynamic> json) => new Destination(
    type: json["type"] == null ? null : json["type"],
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}