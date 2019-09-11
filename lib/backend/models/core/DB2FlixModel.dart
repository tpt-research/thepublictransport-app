import 'dart:convert';

import 'package:thepublictransport_app/backend/models/convert/db2flix/Message.dart';

class DB2FlixModel {
  String success;
  List<Message> message;

  DB2FlixModel({
    this.success,
    this.message,
  });

  factory DB2FlixModel.fromRawJson(String str) => DB2FlixModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DB2FlixModel.fromJson(Map<String, dynamic> json) => DB2FlixModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : List<dynamic>.from(message.map((x) => x.toJson())),
  };
}