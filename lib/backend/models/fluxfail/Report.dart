import 'dart:convert';

class Report {
  String id;
  String country;
  String city;
  String line;
  int vehicle;
  String direction;
  String location;
  DateTime scheduledAt;
  DateTime actuallyAt;
  bool cancelled;
  bool arrival;
  bool departure;

  Report({
    this.id,
    this.country,
    this.city,
    this.line,
    this.vehicle,
    this.direction,
    this.location,
    this.scheduledAt,
    this.actuallyAt,
    this.cancelled,
    this.arrival,
    this.departure,
  });

  factory Report.fromRawJson(String str) => Report.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Report.fromJson(Map<String, dynamic> json) => new Report(
    id: json["id"] == null ? null : json["id"],
    country: json["country"] == null ? null : json["country"],
    city: json["city"] == null ? null : json["city"],
    line: json["line"] == null ? null : json["line"],
    vehicle: json["vehicle"] == null ? null : json["vehicle"],
    direction: json["direction"] == null ? null : json["direction"],
    location: json["location"] == null ? null : json["location"],
    scheduledAt: json["scheduledAt"] == null ? null : DateTime.parse(json["scheduledAt"]),
    actuallyAt: json["actuallyAt"] == null ? null : DateTime.parse(json["actuallyAt"]),
    cancelled: json["cancelled"] == null ? null : json["cancelled"],
    arrival: json["arrival"] == null ? null : json["arrival"],
    departure: json["departure"] == null ? null : json["departure"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "country": country == null ? null : country,
    "city": city == null ? null : city,
    "line": line == null ? null : line,
    "vehicle": vehicle == null ? null : vehicle,
    "direction": direction == null ? null : direction,
    "location": location == null ? null : location,
    "scheduledAt": scheduledAt == null ? null : scheduledAt.toIso8601String(),
    "actuallyAt": actuallyAt == null ? null : actuallyAt.toIso8601String(),
    "cancelled": cancelled == null ? null : cancelled,
    "arrival": arrival == null ? null : arrival,
    "departure": departure == null ? null : departure,
  };
}