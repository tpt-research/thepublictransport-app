import 'dart:convert';

class Info {
  dynamic title;
  dynamic hint;
  dynamic message;
  List<dynamic> warnings;

  Info({
    this.title,
    this.hint,
    this.message,
    this.warnings,
  });

  factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Info.fromJson(Map<String, dynamic> json) => new Info(
    title: json["title"],
    hint: json["hint"],
    message: json["message"],
    warnings: json["warnings"] == null ? null : new List<dynamic>.from(json["warnings"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "hint": hint,
    "message": message,
    "warnings": warnings == null ? null : new List<dynamic>.from(warnings.map((x) => x)),
  };
}