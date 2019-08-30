import 'dart:convert';

class Track {
  String scheduled;
  String actual;

  Track({
    this.scheduled,
    this.actual,
  });

  factory Track.fromRawJson(String str) => Track.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Track.fromJson(Map<String, dynamic> json) => new Track(
    scheduled: json["scheduled"] == null ? null : json["scheduled"],
    actual: json["actual"] == null ? null : json["actual"],
  );

  Map<String, dynamic> toJson() => {
    "scheduled": scheduled == null ? null : scheduled,
    "actual": actual == null ? null : actual,
  };
}