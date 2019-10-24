import 'dart:convert';

import 'Data.dart';

class CircModel {
  String result;
  dynamic responseText;
  Data data;

  CircModel({
    this.result,
    this.responseText,
    this.data,
  });

  factory CircModel.fromRawJson(String str) => CircModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CircModel.fromJson(Map<String, dynamic> json) => CircModel(
    result: json["Result"] == null ? null : json["Result"],
    responseText: json["ResponseText"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Result": result == null ? null : result,
    "ResponseText": responseText,
    "Data": data == null ? null : data.toJson(),
  };
}