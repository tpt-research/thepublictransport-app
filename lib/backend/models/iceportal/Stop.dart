import 'dart:convert';

import 'DelayReason.dart';
import 'Info.dart';
import 'Station.dart';
import 'Timetable.dart';
import 'Track.dart';

class Stop {
  Station station;
  Timetable timetable;
  Track track;
  Info info;
  List<DelayReason> delayReasons;

  Stop({
    this.station,
    this.timetable,
    this.track,
    this.info,
    this.delayReasons,
  });

  factory Stop.fromRawJson(String str) => Stop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stop.fromJson(Map<String, dynamic> json) => new Stop(
    station: json["station"] == null ? null : Station.fromJson(json["station"]),
    timetable: json["timetable"] == null ? null : Timetable.fromJson(json["timetable"]),
    track: json["track"] == null ? null : Track.fromJson(json["track"]),
    info: json["info"] == null ? null : Info.fromJson(json["info"]),
    delayReasons: json["delayReasons"] == null ? null : new List<DelayReason>.from(json["delayReasons"].map((x) => DelayReason.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "station": station == null ? null : station.toJson(),
    "timetable": timetable == null ? null : timetable.toJson(),
    "track": track == null ? null : track.toJson(),
    "info": info == null ? null : info.toJson(),
    "delayReasons": delayReasons == null ? null : new List<dynamic>.from(delayReasons.map((x) => x.toJson())),
  };
}