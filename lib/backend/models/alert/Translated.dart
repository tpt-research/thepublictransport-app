import 'dart:convert';

class Translated {
  String title;
  String message;
  String link;

  Translated({
    this.title,
    this.message,
    this.link,
  });

  factory Translated.fromRawJson(String str) => Translated.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Translated.fromJson(Map<String, dynamic> json) => Translated(
    title: json["title"] == null ? null : json["title"],
    message: json["message"] == null ? null : json["message"],
    link: json["link"] == null ? null : json["link"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "message": message == null ? null : message,
    "link": link == null ? null : link,
  };
}