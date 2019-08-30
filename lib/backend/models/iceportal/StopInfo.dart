import 'dart:convert';

class StopInfo {
  String scheduledNext;
  String actualNext;
  String actualLast;
  String actualLastStarted;
  String finalStationName;
  String finalStationEvaNr;

  StopInfo({
    this.scheduledNext,
    this.actualNext,
    this.actualLast,
    this.actualLastStarted,
    this.finalStationName,
    this.finalStationEvaNr,
  });

  factory StopInfo.fromRawJson(String str) => StopInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StopInfo.fromJson(Map<String, dynamic> json) => new StopInfo(
    scheduledNext: json["scheduledNext"] == null ? null : json["scheduledNext"],
    actualNext: json["actualNext"] == null ? null : json["actualNext"],
    actualLast: json["actualLast"] == null ? null : json["actualLast"],
    actualLastStarted: json["actualLastStarted"] == null ? null : json["actualLastStarted"],
    finalStationName: json["finalStationName"] == null ? null : json["finalStationName"],
    finalStationEvaNr: json["finalStationEvaNr"] == null ? null : json["finalStationEvaNr"],
  );

  Map<String, dynamic> toJson() => {
    "scheduledNext": scheduledNext == null ? null : scheduledNext,
    "actualNext": actualNext == null ? null : actualNext,
    "actualLast": actualLast == null ? null : actualLast,
    "actualLastStarted": actualLastStarted == null ? null : actualLastStarted,
    "finalStationName": finalStationName == null ? null : finalStationName,
    "finalStationEvaNr": finalStationEvaNr == null ? null : finalStationEvaNr,
  };
}