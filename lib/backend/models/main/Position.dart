import 'dart:convert';

class Position {
  String name;
  dynamic section;

  Position({
    this.name,
    this.section,
  });

  factory Position.fromRawJson(String str) => Position.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Position.fromJson(Map<String, dynamic> json) => new Position(
    name: json["name"] == null ? null : json["name"],
    section: json["section"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "section": section,
  };
}