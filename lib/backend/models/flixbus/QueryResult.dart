import 'dart:convert';

class QueryResult {
  String id;
  double relevance;
  double score;
  int weight;
  String type;
  String name;

  QueryResult({
    this.id,
    this.relevance,
    this.score,
    this.weight,
    this.type,
    this.name,
  });

  factory QueryResult.fromRawJson(String str) => QueryResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QueryResult.fromJson(Map<String, dynamic> json) => new QueryResult(
    id: json["id"] == null ? null : json["id"],
    relevance: json["relevance"] == null ? null : json["relevance"].toDouble(),
    score: json["score"] == null ? null : json["score"].toDouble(),
    weight: json["weight"] == null ? null : json["weight"],
    type: json["type"] == null ? null : json["type"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "relevance": relevance == null ? null : relevance,
    "score": score == null ? null : score,
    "weight": weight == null ? null : weight,
    "type": type == null ? null : type,
    "name": name == null ? null : name,
  };
}