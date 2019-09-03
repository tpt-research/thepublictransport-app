import 'dart:convert';

import 'package:thepublictransport_app/backend/models/flixbus/QueryResult.dart';

class FlixbusQueryModel {
  String success;
  List<QueryResult> queryResult;

  FlixbusQueryModel({
    this.success,
    this.queryResult,
  });

  factory FlixbusQueryModel.fromRawJson(String str) => FlixbusQueryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FlixbusQueryModel.fromJson(Map<String, dynamic> json) => new FlixbusQueryModel(
    success: json["success"] == null ? null : json["success"],
    queryResult: json["message"] == null ? null : new List<QueryResult>.from(json["message"].map((x) => QueryResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": queryResult == null ? null : new List<dynamic>.from(queryResult.map((x) => x.toJson())),
  };
}