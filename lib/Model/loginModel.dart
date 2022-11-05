// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.error,
    this.messages,
    this.student,
    this.data,
  });

  int? status;
  bool? error;
  String? messages;
  Student? student;
  Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        error: json["error"],
        messages: json["messages"],
        student: Student.fromJson(json["student"]),
        //  Map.from(json["student"])
        //     .map((k, v) => MapEntry<String, String>(k, v == null ? null : v)),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "messages": messages,
        "student": student!.toJson(),
        //  Map.from(student!)
        //     .map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)),
        "data": data!.toJson(),
      };
}

class Student {
  Student({this.studentId, this.name, this.classname, this.sectionName});

  String? studentId;
  String? name;
  String? classname;
  String? sectionName;
  factory Student.fromJson(Map<String, dynamic> json) => Student(
        studentId: json["studentID"],
        name: json["name"],
        classname: json["classname"],
        sectionName: json["section_name"],
      );

  Map<String, dynamic> toJson() => {
        "student_ID": studentId,
        "name": name,
        "classname": classname,
        "section_name": sectionName
      };
}

class Data {
  Data({
    this.token,
  });

  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
