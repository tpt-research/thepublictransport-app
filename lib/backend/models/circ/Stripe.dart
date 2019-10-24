import 'dart:convert';

class Stripe {
  bool userAddedPayment;
  dynamic stripeApiKey;
  dynamic androidPayMode;

  Stripe({
    this.userAddedPayment,
    this.stripeApiKey,
    this.androidPayMode,
  });

  factory Stripe.fromRawJson(String str) => Stripe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stripe.fromJson(Map<String, dynamic> json) => Stripe(
    userAddedPayment: json["UserAddedPayment"] == null ? null : json["UserAddedPayment"],
    stripeApiKey: json["StripeApiKey"],
    androidPayMode: json["AndroidPayMode"],
  );

  Map<String, dynamic> toJson() => {
    "UserAddedPayment": userAddedPayment == null ? null : userAddedPayment,
    "StripeApiKey": stripeApiKey,
    "AndroidPayMode": androidPayMode,
  };
}