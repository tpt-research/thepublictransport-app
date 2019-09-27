import 'dart:convert';

import 'package:thepublictransport_app/backend/models/alert/Translated.dart';

class Translations {
  Translated en;
  Translated de;

  Translations({
    this.en,
    this.de,
  });

  factory Translations.fromRawJson(String str) => Translations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Translations.fromJson(Map<String, dynamic> json) => Translations(
    en: json["en"] == null ? null : Translated.fromJson(json["en"]),
    de: json["de"] == null ? null : Translated.fromJson(json["de"]),
  );

  Map<String, dynamic> toJson() => {
    "en": en == null ? null : en.toJson(),
    "de": de == null ? null : de.toJson(),
  };
}