import 'dart:convert';

class Header {
  String network;
  String serverProduct;
  String serverVersion;
  dynamic serverName;
  int serverTime;
  dynamic context;

  Header({
    this.network,
    this.serverProduct,
    this.serverVersion,
    this.serverName,
    this.serverTime,
    this.context,
  });

  factory Header.fromRawJson(String str) => Header.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Header.fromJson(Map<String, dynamic> json) => new Header(
    network: json["network"] == null ? null : json["network"],
    serverProduct: json["serverProduct"] == null ? null : json["serverProduct"],
    serverVersion: json["serverVersion"] == null ? null : json["serverVersion"],
    serverName: json["serverName"],
    serverTime: json["serverTime"] == null ? null : json["serverTime"],
    context: json["context"],
  );

  Map<String, dynamic> toJson() => {
    "network": network == null ? null : network,
    "serverProduct": serverProduct == null ? null : serverProduct,
    "serverVersion": serverVersion == null ? null : serverVersion,
    "serverName": serverName,
    "serverTime": serverTime == null ? null : serverTime,
    "context": context,
  };
}