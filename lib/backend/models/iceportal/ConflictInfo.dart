import 'dart:convert';

class ConflictInfo {
  String status;
  dynamic text;

  ConflictInfo({
    this.status,
    this.text,
  });

  factory ConflictInfo.fromRawJson(String str) => ConflictInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConflictInfo.fromJson(Map<String, dynamic> json) => new ConflictInfo(
    status: json["status"] == null ? null : json["status"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "text": text,
  };
}