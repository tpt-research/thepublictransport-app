import 'dart:convert';

import 'Location.dart';

class Message {
  String type;
  String id;
  String name;
  Location location;
  String slug;
  List<dynamic> aliases;
  List<String> regions;
  List<int> connections;
  int importance;

  Message({
    this.type,
    this.id,
    this.name,
    this.location,
    this.slug,
    this.aliases,
    this.regions,
    this.connections,
    this.importance,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    type: json["type"] == null ? null : json["type"],
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    slug: json["slug"] == null ? null : json["slug"],
    aliases: json["aliases"] == null ? null : List<dynamic>.from(json["aliases"].map((x) => x)),
    regions: json["regions"] == null ? null : List<String>.from(json["regions"].map((x) => x)),
    connections: json["connections"] == null ? null : List<int>.from(json["connections"].map((x) => x)),
    importance: json["importance"] == null ? null : json["importance"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "location": location == null ? null : location.toJson(),
    "slug": slug == null ? null : slug,
    "aliases": aliases == null ? null : List<dynamic>.from(aliases.map((x) => x)),
    "regions": regions == null ? null : List<dynamic>.from(regions.map((x) => x)),
    "connections": connections == null ? null : List<dynamic>.from(connections.map((x) => x)),
    "importance": importance == null ? null : importance,
  };
}
