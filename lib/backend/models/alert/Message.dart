import 'dart:convert';

import 'Translations.dart';

class Message {
  int messageId;
  Translations translations;

  Message({
    this.messageId,
    this.translations,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    messageId: json["messageId"] == null ? null : json["messageId"],
    translations: json["translations"] == null ? null : Translations.fromJson(json["translations"]),
  );

  Map<String, dynamic> toJson() => {
    "messageId": messageId == null ? null : messageId,
    "translations": translations == null ? null : translations.toJson(),
  };
}