import 'dart:convert';

class Price {
  double amount;
  String currency;
  dynamic discounts;
  bool saleRestriction;
  bool available;
  String url;

  Price({
    this.amount,
    this.currency,
    this.discounts,
    this.saleRestriction,
    this.available,
    this.url,
  });

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => new Price(
    amount: json["amount"] == null ? null : json["amount"].toDouble(),
    currency: json["currency"] == null ? null : json["currency"],
    discounts: json["discounts"],
    saleRestriction: json["saleRestriction"] == null ? null : json["saleRestriction"],
    available: json["available"] == null ? null : json["available"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount == null ? null : amount,
    "currency": currency == null ? null : currency,
    "discounts": discounts,
    "saleRestriction": saleRestriction == null ? null : saleRestriction,
    "available": available == null ? null : available,
    "url": url == null ? null : url,
  };
}