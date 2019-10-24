import 'dart:convert';

class VoiModel {
  String id;
  String short;
  String name;
  int zone;
  String type;
  String registrationPlate;
  DateTime added;
  String serial;
  dynamic modelSpecification;
  String status;
  int bounty;
  List<double> location;
  int battery;
  bool locked;
  DateTime updated;
  int mileage;

  VoiModel({
    this.id,
    this.short,
    this.name,
    this.zone,
    this.type,
    this.registrationPlate,
    this.added,
    this.serial,
    this.modelSpecification,
    this.status,
    this.bounty,
    this.location,
    this.battery,
    this.locked,
    this.updated,
    this.mileage,
  });

  factory VoiModel.fromRawJson(String str) => VoiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VoiModel.fromJson(Map<String, dynamic> json) => VoiModel(
    id: json["id"] == null ? null : json["id"],
    short: json["short"] == null ? null : json["short"],
    name: json["name"] == null ? null : json["name"],
    zone: json["zone"] == null ? null : json["zone"],
    type: json["type"] == null ? null : json["type"],
    registrationPlate: json["registration_plate"] == null ? null : json["registration_plate"],
    added: json["added"] == null ? null : DateTime.parse(json["added"]),
    serial: json["serial"] == null ? null : json["serial"],
    modelSpecification: json["model_specification"],
    status: json["status"] == null ? null : json["status"],
    bounty: json["bounty"] == null ? null : json["bounty"],
    location: json["location"] == null ? null : List<double>.from(json["location"].map((x) => x.toDouble())),
    battery: json["battery"] == null ? null : json["battery"],
    locked: json["locked"] == null ? null : json["locked"],
    updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    mileage: json["mileage"] == null ? null : json["mileage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "short": short == null ? null : short,
    "name": name == null ? null : name,
    "zone": zone == null ? null : zone,
    "type": type == null ? null : type,
    "registration_plate": registrationPlate == null ? null : registrationPlate,
    "added": added == null ? null : added.toIso8601String(),
    "serial": serial == null ? null : serial,
    "model_specification": modelSpecification,
    "status": status == null ? null : status,
    "bounty": bounty == null ? null : bounty,
    "location": location == null ? null : List<dynamic>.from(location.map((x) => x)),
    "battery": battery == null ? null : battery,
    "locked": locked == null ? null : locked,
    "updated": updated == null ? null : updated.toIso8601String(),
    "mileage": mileage == null ? null : mileage,
  };
}
