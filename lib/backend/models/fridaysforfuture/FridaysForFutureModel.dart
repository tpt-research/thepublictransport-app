import 'dart:convert';
import 'Message.dart';

class FridaysForFutureModel {
  String success;
  List<Message> message;

  FridaysForFutureModel({
    this.success,
    this.message,
  });

  factory FridaysForFutureModel.fromRawJson(String str) => FridaysForFutureModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FridaysForFutureModel.fromJson(Map<String, dynamic> json) => FridaysForFutureModel(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : List<dynamic>.from(message.map((x) => x.toJson())),
  };
}