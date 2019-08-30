import 'dart:convert';

class Timetable {
  int scheduledArrivalTime;
  int actualArrivalTime;
  bool showActualArrivalTime;
  String arrivalDelay;
  int scheduledDepartureTime;
  int actualDepartureTime;
  bool showActualDepartureTime;
  String departureDelay;

  Timetable({
    this.scheduledArrivalTime,
    this.actualArrivalTime,
    this.showActualArrivalTime,
    this.arrivalDelay,
    this.scheduledDepartureTime,
    this.actualDepartureTime,
    this.showActualDepartureTime,
    this.departureDelay,
  });

  factory Timetable.fromRawJson(String str) => Timetable.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Timetable.fromJson(Map<String, dynamic> json) => new Timetable(
    scheduledArrivalTime: json["scheduledArrivalTime"] == null ? null : json["scheduledArrivalTime"],
    actualArrivalTime: json["actualArrivalTime"] == null ? null : json["actualArrivalTime"],
    showActualArrivalTime: json["showActualArrivalTime"] == null ? null : json["showActualArrivalTime"],
    arrivalDelay: json["arrivalDelay"] == null ? null : json["arrivalDelay"],
    scheduledDepartureTime: json["scheduledDepartureTime"] == null ? null : json["scheduledDepartureTime"],
    actualDepartureTime: json["actualDepartureTime"] == null ? null : json["actualDepartureTime"],
    showActualDepartureTime: json["showActualDepartureTime"] == null ? null : json["showActualDepartureTime"],
    departureDelay: json["departureDelay"] == null ? null : json["departureDelay"],
  );

  Map<String, dynamic> toJson() => {
    "scheduledArrivalTime": scheduledArrivalTime == null ? null : scheduledArrivalTime,
    "actualArrivalTime": actualArrivalTime == null ? null : actualArrivalTime,
    "showActualArrivalTime": showActualArrivalTime == null ? null : showActualArrivalTime,
    "arrivalDelay": arrivalDelay == null ? null : arrivalDelay,
    "scheduledDepartureTime": scheduledDepartureTime == null ? null : scheduledDepartureTime,
    "actualDepartureTime": actualDepartureTime == null ? null : actualDepartureTime,
    "showActualDepartureTime": showActualDepartureTime == null ? null : showActualDepartureTime,
    "departureDelay": departureDelay == null ? null : departureDelay,
  };
}