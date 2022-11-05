// To parse this JSON data, do
//
//     final circularModel = circularModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final circularModel = circularModelFromJson(jsonString);

import 'dart:convert';

CircularModel circularModelFromJson(String str) =>
    CircularModel.fromJson(json.decode(str));

String circularModelToJson(CircularModel data) => json.encode(data.toJson());

class CircularModel {
  CircularModel({
    this.status,
    this.error,
    this.messages,
    this.data,
  });

  int? status;
  bool? error;
  String? messages;
  List<Datum>? data;

  factory CircularModel.fromJson(Map<String, dynamic> json) => CircularModel(
        status: json["status"],
        error: json["error"],
        messages: json["messages"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "messages": messages,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.composeId,
    this.title,
    this.message,
    this.timestamp,
    this.readtime,
  });

  String? composeId;
  String? title;
  String? message;
  String? timestamp;
  String? readtime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        composeId: json["composeID"],
        title: json["title"],
        message: json["message"],
        timestamp: json["timestamp"],
        readtime: json["readtime"],
      );

  Map<String, dynamic> toJson() => {
        "composeID": composeId,
        "title": title,
        "message": message,
        "timestamp": timestamp,
        "readtime": readtime,
      };
}
