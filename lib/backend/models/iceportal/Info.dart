import 'dart:convert';

class Info {
  int status;
  bool passed;
  String positionStatus;
  int distance;
  int distanceFromStart;

  Info({
    this.status,
    this.passed,
    this.positionStatus,
    this.distance,
    this.distanceFromStart,
  });

  factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Info.fromJson(Map<String, dynamic> json) => new Info(
    status: json["status"] == null ? null : json["status"],
    passed: json["passed"] == null ? null : json["passed"],
    positionStatus: json["positionStatus"] == null ? null : json["positionStatus"],
    distance: json["distance"] == null ? null : json["distance"],
    distanceFromStart: json["distanceFromStart"] == null ? null : json["distanceFromStart"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "passed": passed == null ? null : passed,
    "positionStatus": positionStatus == null ? null : positionStatus,
    "distance": distance == null ? null : distance,
    "distanceFromStart": distanceFromStart == null ? null : distanceFromStart,
  };
}