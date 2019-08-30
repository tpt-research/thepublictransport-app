import 'dart:convert';

class DelayReason {
  String code;
  String text;

  DelayReason({
    this.code,
    this.text,
  });

  factory DelayReason.fromRawJson(String str) => DelayReason.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DelayReason.fromJson(Map<String, dynamic> json) => new DelayReason(
    code: json["code"] == null ? null : json["code"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "text": text == null ? null : text,
  };
}