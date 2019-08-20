import 'dart:convert';

import 'package:thepublictransport_app/backend/models/main/Header.dart';
import 'package:thepublictransport_app/backend/models/main/StationDeparture.dart';


class DepartureModel {
  Header header;
  String status;
  List<StationDeparture> stationDepartures;

  DepartureModel({
    this.header,
    this.status,
    this.stationDepartures,
  });

  factory DepartureModel.fromRawJson(String str) => DepartureModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DepartureModel.fromJson(Map<String, dynamic> json) => new DepartureModel(
    header: json["header"] == null ? null : Header.fromJson(json["header"]),
    status: json["status"] == null ? null : json["status"],
    stationDepartures: json["stationDepartures"] == null ? null : new List<StationDeparture>.from(json["stationDepartures"].map((x) => StationDeparture.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "header": header == null ? null : header.toJson(),
    "status": status == null ? null : status,
    "stationDepartures": stationDepartures == null ? null : new List<dynamic>.from(stationDepartures.map((x) => x.toJson())),
  };
}