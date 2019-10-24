import 'dart:convert';

class MPoint {
  double x;
  double y;

  MPoint({
    this.x,
    this.y,
  });

  factory MPoint.fromRawJson(String str) => MPoint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MPoint.fromJson(Map<String, dynamic> json) => MPoint(
    x: json["x"] == null ? null : json["x"].toDouble(),
    y: json["y"] == null ? null : json["y"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "x": x == null ? null : x,
    "y": y == null ? null : y,
  };
}