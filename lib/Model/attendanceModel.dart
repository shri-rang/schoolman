// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) =>
    AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) =>
    json.encode(data.toJson());

class AttendanceModel {
  AttendanceModel({
    this.status,
    this.error,
    this.messages,
    this.data,
    this.totalP,
    this.totalA,
    this.totalH,
  });

  int? status;
  bool? error;
  String? messages;
  List<Datum>? data;
  int? totalP;
  int? totalA;
  int? totalH;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        status: json["status"],
        error: json["error"],
        messages: json["messages"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        totalP: json["totalP"],
        totalA: json["totalA"],
        totalH: json["totalH"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "messages": messages,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalP": totalP,
        "totalA": totalA,
        "totalH": totalH,
      };
}

class Datum {
  Datum({
    this.sattendanceId,
    this.loginId,
    this.studentId,
    this.classesId,
    this.sectionId,
    this.date,
    this.attendance,
    this.remarks,
  });

  String? sattendanceId;
  String? loginId;
  String? studentId;
  String? classesId;
  String? sectionId;
  DateTime? date;
  String? attendance;
  String? remarks;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        sattendanceId: json["sattendanceID"],
        loginId: json["loginID"],
        studentId: json["studentID"],
        classesId: json["classesID"],
        sectionId: json["sectionID"],
        date: DateTime.parse(json["date"]),
        attendance: json["attendance"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "sattendanceID": sattendanceId,
        "loginID": loginId,
        "studentID": studentId,
        "classesID": classesId,
        "sectionID": sectionId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "attendance": attendance,
        "remarks": remarks,
      };
}
