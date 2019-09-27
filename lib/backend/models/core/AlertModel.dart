import 'dart:convert';

import 'package:thepublictransport_app/backend/models/alert/Message.dart';

class AlertModel {
  String success;
  Message message;

  AlertModel({
    this.success,
    this.message,
  });

  factory AlertModel.fromRawJson(String str) => AlertModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AlertModel.fromJson(Map<String, dynamic> json) => AlertModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message.toJson(),
  };
}