import 'dart:convert';

class MFigure {
  int pointOffset;
  String figureAttribute;

  MFigure({
    this.pointOffset,
    this.figureAttribute,
  });

  factory MFigure.fromRawJson(String str) => MFigure.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MFigure.fromJson(Map<String, dynamic> json) => MFigure(
    pointOffset: json["pointOffset"] == null ? null : json["pointOffset"],
    figureAttribute: json["figureAttribute"] == null ? null : json["figureAttribute"],
  );

  Map<String, dynamic> toJson() => {
    "pointOffset": pointOffset == null ? null : pointOffset,
    "figureAttribute": figureAttribute == null ? null : figureAttribute,
  };
}