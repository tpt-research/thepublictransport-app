import 'dart:convert';

class Meta {
  int rowCount;
  int pageCount;

  Meta({
    this.rowCount,
    this.pageCount,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    rowCount: json["rowCount"] == null ? null : json["rowCount"],
    pageCount: json["pageCount"] == null ? null : json["pageCount"],
  );

  Map<String, dynamic> toJson() => {
    "rowCount": rowCount == null ? null : rowCount,
    "pageCount": pageCount == null ? null : pageCount,
  };
}