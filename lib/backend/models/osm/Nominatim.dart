import 'dart:convert';

class Nominatim {
  int placeId;
  String licence;
  String osmType;
  int osmId;
  String lat;
  String lon;
  String displayName;
  Address address;
  List<String> boundingbox;

  Nominatim({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.displayName,
    this.address,
    this.boundingbox,
  });

  factory Nominatim.fromRawJson(String str) => Nominatim.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Nominatim.fromJson(Map<String, dynamic> json) => new Nominatim(
    placeId: json["place_id"] == null ? null : json["place_id"],
    licence: json["licence"] == null ? null : json["licence"],
    osmType: json["osm_type"] == null ? null : json["osm_type"],
    osmId: json["osm_id"] == null ? null : json["osm_id"],
    lat: json["lat"] == null ? null : json["lat"],
    lon: json["lon"] == null ? null : json["lon"],
    displayName: json["display_name"] == null ? null : json["display_name"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    boundingbox: json["boundingbox"] == null ? null : new List<String>.from(json["boundingbox"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "place_id": placeId == null ? null : placeId,
    "licence": licence == null ? null : licence,
    "osm_type": osmType == null ? null : osmType,
    "osm_id": osmId == null ? null : osmId,
    "lat": lat == null ? null : lat,
    "lon": lon == null ? null : lon,
    "display_name": displayName == null ? null : displayName,
    "address": address == null ? null : address.toJson(),
    "boundingbox": boundingbox == null ? null : new List<dynamic>.from(boundingbox.map((x) => x)),
  };
}

class Address {
  String houseNumber;
  String road;
  String suburb;
  String cityDistrict;
  String city;
  String county;
  String stateDistrict;
  String state;
  String postcode;
  String country;
  String countryCode;

  Address({
    this.houseNumber,
    this.road,
    this.suburb,
    this.cityDistrict,
    this.city,
    this.county,
    this.stateDistrict,
    this.state,
    this.postcode,
    this.country,
    this.countryCode,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => new Address(
    houseNumber: json["house_number"] == null ? null : json["house_number"],
    road: json["road"] == null ? null : json["road"],
    suburb: json["suburb"] == null ? null : json["suburb"],
    cityDistrict: json["city_district"] == null ? null : json["city_district"],
    city: json["city"] == null ? null : json["city"],
    county: json["county"] == null ? null : json["county"],
    stateDistrict: json["state_district"] == null ? null : json["state_district"],
    state: json["state"] == null ? null : json["state"],
    postcode: json["postcode"] == null ? null : json["postcode"],
    country: json["country"] == null ? null : json["country"],
    countryCode: json["country_code"] == null ? null : json["country_code"],
  );

  Map<String, dynamic> toJson() => {
    "house_number": houseNumber == null ? null : houseNumber,
    "road": road == null ? null : road,
    "suburb": suburb == null ? null : suburb,
    "city_district": cityDistrict == null ? null : cityDistrict,
    "city": city == null ? null : city,
    "county": county == null ? null : county,
    "state_district": stateDistrict == null ? null : stateDistrict,
    "state": state == null ? null : state,
    "postcode": postcode == null ? null : postcode,
    "country": country == null ? null : country,
    "country_code": countryCode == null ? null : countryCode,
  };
}