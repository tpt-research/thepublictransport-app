import 'dart:convert';

import 'package:thepublictransport_app/backend/models/sparpreis/Message.dart';

class SparpreisFinderModel {
  String success;
  List<Message> message;

  SparpreisFinderModel({
    this.success,
    this.message,
  });

  factory SparpreisFinderModel.fromRawJson(String str) => SparpreisFinderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SparpreisFinderModel.fromJson(Map<String, dynamic> json) => new SparpreisFinderModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : new List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : new List<dynamic>.from(message.map((x) => x.toJson())),
  };
}