import 'dart:convert';

class Vehicle {
  String id;
  String state;
  DateTime lastLocationUpdate;
  DateTime lastStateChange;
  int batteryLevel;
  double lat;
  double lng;
  int maxSpeed;
  String zoneId;
  String licencePlate;
  String vin;
  int code;
  bool isRentable;
  String iotVendor;

  Vehicle({
    this.id,
    this.state,
    this.lastLocationUpdate,
    this.lastStateChange,
    this.batteryLevel,
    this.lat,
    this.lng,
    this.maxSpeed,
    this.zoneId,
    this.licencePlate,
    this.vin,
    this.code,
    this.isRentable,
    this.iotVendor,
  });

  factory Vehicle.fromRawJson(String str) => Vehicle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json["id"] == null ? null : json["id"],
    state: json["state"] == null ? null : json["state"],
    lastLocationUpdate: json["lastLocationUpdate"] == null ? null : DateTime.parse(json["lastLocationUpdate"]),
    lastStateChange: json["lastStateChange"] == null ? null : DateTime.parse(json["lastStateChange"]),
    batteryLevel: json["batteryLevel"] == null ? null : json["batteryLevel"],
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lng: json["lng"] == null ? null : json["lng"].toDouble(),
    maxSpeed: json["maxSpeed"] == null ? null : json["maxSpeed"],
    zoneId: json["zoneId"] == null ? null : json["zoneId"],
    licencePlate: json["licencePlate"] == null ? null : json["licencePlate"],
    vin: json["vin"] == null ? null : json["vin"],
    code: json["code"] == null ? null : json["code"],
    isRentable: json["isRentable"] == null ? null : json["isRentable"],
    iotVendor: json["iotVendor"] == null ? null : json["iotVendor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "state": state == null ? null : state,
    "lastLocationUpdate": lastLocationUpdate == null ? null : lastLocationUpdate.toIso8601String(),
    "lastStateChange": lastStateChange == null ? null : lastStateChange.toIso8601String(),
    "batteryLevel": batteryLevel == null ? null : batteryLevel,
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
    "maxSpeed": maxSpeed == null ? null : maxSpeed,
    "zoneId": zoneId == null ? null : zoneId,
    "licencePlate": licencePlate == null ? null : licencePlate,
    "vin": vin == null ? null : vin,
    "code": code == null ? null : code,
    "isRentable": isRentable == null ? null : isRentable,
    "iotVendor": iotVendor == null ? null : iotVendor,
  };
}