import 'dart:convert';

class Price {
  String currency;
  double amount;
  bool discount;
  String name;
  String description;
  bool anyTrain;

  Price({
    this.currency,
    this.amount,
    this.discount,
    this.name,
    this.description,
    this.anyTrain,
  });

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => new Price(
    currency: json["currency"] == null ? null : json["currency"],
    amount: json["amount"] == null ? null : json["amount"].toDouble(),
    discount: json["discount"] == null ? null : json["discount"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    anyTrain: json["anyTrain"] == null ? null : json["anyTrain"],
  );

  Map<String, dynamic> toJson() => {
    "currency": currency == null ? null : currency,
    "amount": amount == null ? null : amount,
    "discount": discount == null ? null : discount,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "anyTrain": anyTrain == null ? null : anyTrain,
  };
}