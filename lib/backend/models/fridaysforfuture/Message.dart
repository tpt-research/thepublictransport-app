import 'dart:convert';

class Message {
  String stadt;
  String bundesland;
  String name;
  String lang;
  String lat;
  String uhrzeit;
  String startpunkt;
  String facebookEvent;
  String zusatzinfo;
  String facebook;
  String instagram;
  String twitter;
  String website;
  String field14;

  Message({
    this.stadt,
    this.bundesland,
    this.name,
    this.lang,
    this.lat,
    this.uhrzeit,
    this.startpunkt,
    this.facebookEvent,
    this.zusatzinfo,
    this.facebook,
    this.instagram,
    this.twitter,
    this.website,
    this.field14,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    stadt: json["Stadt"] == null ? null : json["Stadt"],
    bundesland: json["Bundesland"] == null ? null : json["Bundesland"],
    name: json["Name"] == null ? null : json["Name"],
    lang: json["lang"] == null ? null : json["lang"],
    lat: json["lat"] == null ? null : json["lat"],
    uhrzeit: json["Uhrzeit"] == null ? null : json["Uhrzeit"],
    startpunkt: json["Startpunkt"] == null ? null : json["Startpunkt"],
    facebookEvent: json["Facebook event"] == null ? null : json["Facebook event"],
    zusatzinfo: json["zusatzinfo"] == null ? null : json["zusatzinfo"],
    facebook: json["Facebook"] == null ? null : json["Facebook"],
    instagram: json["Instagram"] == null ? null : json["Instagram"],
    twitter: json["Twitter"] == null ? null : json["Twitter"],
    website: json["website"] == null ? null : json["website"],
    field14: json["field14"] == null ? null : json["field14"],
  );

  Map<String, dynamic> toJson() => {
    "Stadt": stadt == null ? null : stadt,
    "Bundesland": bundesland == null ? null : bundesland,
    "Name": name == null ? null : name,
    "lang": lang == null ? null : lang,
    "lat": lat == null ? null : lat,
    "Uhrzeit": uhrzeit == null ? null : uhrzeit,
    "Startpunkt": startpunkt == null ? null : startpunkt,
    "Facebook event": facebookEvent == null ? null : facebookEvent,
    "zusatzinfo": zusatzinfo == null ? null : zusatzinfo,
    "Facebook": facebook == null ? null : facebook,
    "Instagram": instagram == null ? null : instagram,
    "Twitter": twitter == null ? null : twitter,
    "website": website == null ? null : website,
    "field14": field14 == null ? null : field14,
  };
}