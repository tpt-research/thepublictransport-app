import 'dart:convert';

import 'City.dart';
import 'Scooter.dart';
import 'Stripe.dart';
import 'TermsConditions.dart';

class Data {
  TermsConditions termsConditions;
  List<Scooter> scooters;
  City city;
  Stripe stripe;
  int opsFilternScooters;
  String preRideUrl;
  bool topUpRequired;

  Data({
    this.termsConditions,
    this.scooters,
    this.city,
    this.stripe,
    this.opsFilternScooters,
    this.preRideUrl,
    this.topUpRequired,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    termsConditions: json["TermsConditions"] == null ? null : TermsConditions.fromJson(json["TermsConditions"]),
    scooters: json["Scooters"] == null ? null : List<Scooter>.from(json["Scooters"].map((x) => Scooter.fromJson(x))),
    city: json["City"] == null ? null : City.fromJson(json["City"]),
    stripe: json["Stripe"] == null ? null : Stripe.fromJson(json["Stripe"]),
    opsFilternScooters: json["OpsFilternScooters"] == null ? null : json["OpsFilternScooters"],
    preRideUrl: json["PreRideURL"] == null ? null : json["PreRideURL"],
    topUpRequired: json["TopUpRequired"] == null ? null : json["TopUpRequired"],
  );

  Map<String, dynamic> toJson() => {
    "TermsConditions": termsConditions == null ? null : termsConditions.toJson(),
    "Scooters": scooters == null ? null : List<dynamic>.from(scooters.map((x) => x.toJson())),
    "City": city == null ? null : city.toJson(),
    "Stripe": stripe == null ? null : stripe.toJson(),
    "OpsFilternScooters": opsFilternScooters == null ? null : opsFilternScooters,
    "PreRideURL": preRideUrl == null ? null : preRideUrl,
    "TopUpRequired": topUpRequired == null ? null : topUpRequired,
  };
}