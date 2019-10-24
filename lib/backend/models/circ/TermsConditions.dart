import 'dart:convert';

class TermsConditions {
  bool acceptedTermsConditions;
  String urlPrivacy;
  String urlTerms;

  TermsConditions({
    this.acceptedTermsConditions,
    this.urlPrivacy,
    this.urlTerms,
  });

  factory TermsConditions.fromRawJson(String str) => TermsConditions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsConditions.fromJson(Map<String, dynamic> json) => TermsConditions(
    acceptedTermsConditions: json["AcceptedTermsConditions"] == null ? null : json["AcceptedTermsConditions"],
    urlPrivacy: json["UrlPrivacy"] == null ? null : json["UrlPrivacy"],
    urlTerms: json["UrlTerms"] == null ? null : json["UrlTerms"],
  );

  Map<String, dynamic> toJson() => {
    "AcceptedTermsConditions": acceptedTermsConditions == null ? null : acceptedTermsConditions,
    "UrlPrivacy": urlPrivacy == null ? null : urlPrivacy,
    "UrlTerms": urlTerms == null ? null : urlTerms,
  };
}