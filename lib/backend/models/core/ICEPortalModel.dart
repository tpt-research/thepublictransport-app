import 'dart:convert';

import 'package:thepublictransport_app/backend/models/iceportal/SelectedRoute.dart';
import 'package:thepublictransport_app/backend/models/iceportal/Trip.dart';

class IcePortalModel {
  Trip trip;
  dynamic connection;
  SelectedRoute selectedRoute;
  dynamic active;

  IcePortalModel({
    this.trip,
    this.connection,
    this.selectedRoute,
    this.active,
  });

  factory IcePortalModel.fromRawJson(String str) => IcePortalModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IcePortalModel.fromJson(Map<String, dynamic> json) => new IcePortalModel(
    trip: json["trip"] == null ? null : Trip.fromJson(json["trip"]),
    connection: json["connection"],
    selectedRoute: json["selectedRoute"] == null ? null : SelectedRoute.fromJson(json["selectedRoute"]),
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "trip": trip == null ? null : trip.toJson(),
    "connection": connection,
    "selectedRoute": selectedRoute == null ? null : selectedRoute.toJson(),
    "active": active,
  };
}