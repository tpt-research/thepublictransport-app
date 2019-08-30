import 'dart:convert';

import 'ConflictInfo.dart';

class SelectedRoute {
  ConflictInfo conflictInfo;
  dynamic mobility;

  SelectedRoute({
    this.conflictInfo,
    this.mobility,
  });

  factory SelectedRoute.fromRawJson(String str) => SelectedRoute.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SelectedRoute.fromJson(Map<String, dynamic> json) => new SelectedRoute(
    conflictInfo: json["conflictInfo"] == null ? null : ConflictInfo.fromJson(json["conflictInfo"]),
    mobility: json["mobility"],
  );

  Map<String, dynamic> toJson() => {
    "conflictInfo": conflictInfo == null ? null : conflictInfo.toJson(),
    "mobility": mobility,
  };
}