import 'dart:convert';

import 'Country.dart';

class Location {
  String type;
  double longitude;
  double latitude;
  String address;
  Country country;
  String zip;
  String street;

  Location({
    this.type,
    this.longitude,
    this.latitude,
    this.address,
    this.country,
    this.zip,
    this.street,
  });

  factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"] == null ? null : json["type"],
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    address: json["address"] == null ? null : json["address"],
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
    zip: json["zip"] == null ? null : json["zip"],
    street: json["street"] == null ? null : json["street"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "longitude": longitude == null ? null : longitude,
    "latitude": latitude == null ? null : latitude,
    "address": address == null ? null : address,
    "country": country == null ? null : country.toJson(),
    "zip": zip == null ? null : zip,
    "street": street == null ? null : street,
  };
}