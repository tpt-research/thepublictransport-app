import 'dart:convert';

import 'package:thepublictransport_app/backend/models/flixbus/Message.dart';


class FlixbusJourneyModel {
  String success;
  List<Message> message;

  FlixbusJourneyModel({
    this.success,
    this.message,
  });

  factory FlixbusJourneyModel.fromRawJson(String str) => FlixbusJourneyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FlixbusJourneyModel.fromJson(Map<String, dynamic> json) => new FlixbusJourneyModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : new List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : new List<dynamic>.from(message.map((x) => x.toJson())),
  };
}