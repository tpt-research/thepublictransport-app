import 'dart:convert';

import 'package:thepublictransport_app/backend/models/main/Context.dart';
import 'package:thepublictransport_app/backend/models/main/From.dart';
import 'package:thepublictransport_app/backend/models/main/Header.dart';
import 'package:thepublictransport_app/backend/models/main/Trip.dart';

class TripModel {
  Header header;
  String status;
  From from;
  From to;
  Context context;
  List<Trip> trips;

  TripModel({
    this.header,
    this.status,
    this.from,
    this.to,
    this.context,
    this.trips,
  });

  factory TripModel.fromRawJson(String str) => TripModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TripModel.fromJson(Map<String, dynamic> json) => new TripModel(
    header: json["header"] == null ? null : Header.fromJson(json["header"]),
    status: json["status"] == null ? null : json["status"],
    from: json["from"] == null ? null : From.fromJson(json["from"]),
    to: json["to"] == null ? null : From.fromJson(json["to"]),
    context: json["context"] == null ? null : Context.fromJson(json["context"]),
    trips: json["trips"] == null ? null : new List<Trip>.from(json["trips"].map((x) => Trip.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "header": header == null ? null : header.toJson(),
    "status": status == null ? null : status,
    "from": from == null ? null : from.toJson(),
    "to": to == null ? null : to.toJson(),
    "context": context == null ? null : context.toJson(),
    "trips": trips == null ? null : new List<dynamic>.from(trips.map((x) => x.toJson())),
  };
}