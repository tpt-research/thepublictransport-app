import 'dart:convert';

class MShape {
  int figureOffset;
  int parentOffset;
  String type;

  MShape({
    this.figureOffset,
    this.parentOffset,
    this.type,
  });

  factory MShape.fromRawJson(String str) => MShape.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MShape.fromJson(Map<String, dynamic> json) => MShape(
    figureOffset: json["figureOffset"] == null ? null : json["figureOffset"],
    parentOffset: json["parentOffset"] == null ? null : json["parentOffset"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "figureOffset": figureOffset == null ? null : figureOffset,
    "parentOffset": parentOffset == null ? null : parentOffset,
    "type": type == null ? null : type,
  };
}