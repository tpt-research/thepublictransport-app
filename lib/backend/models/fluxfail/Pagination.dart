import 'dart:convert';

class Pagination {
  int limit;
  int offset;
  int total;

  Pagination({
    this.limit,
    this.offset,
    this.total,
  });

  factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => new Pagination(
    limit: json["limit"] == null ? null : json["limit"],
    offset: json["offset"] == null ? null : json["offset"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "limit": limit == null ? null : limit,
    "offset": offset == null ? null : offset,
    "total": total == null ? null : total,
  };
}