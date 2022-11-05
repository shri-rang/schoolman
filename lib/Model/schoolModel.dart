// To parse this JSON data, do
//
//     final schoolModel = schoolModelFromJson(jsonString);

import 'dart:convert';

SchoolModel schoolModelFromJson(String str) =>
    SchoolModel.fromJson(json.decode(str));

String schoolModelToJson(SchoolModel data) => json.encode(data.toJson());

class SchoolModel {
  SchoolModel({
    this.status,
    this.error,
    this.messages,
    this.data,
    this.helpNumber,
    this.logo,
  });

  int? status;
  bool? error;
  String? messages;
  Data? data;
  String? helpNumber;
  String? logo;

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
        status: json["status"],
        error: json["error"],
        messages: json["messages"],
        data: Data.fromJson(json["data"]),
        helpNumber: json["help_number"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "messages": messages,
        "data": data!.toJson(),
        "help_number": helpNumber,
        "logo": logo,
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.address,
    this.email,
    this.affiliationNo,
    this.board,
    this.code,
    this.whatsappNo,
    this.institutionContact,
    this.studentPrefix,
    this.parentPrefix,
    this.masterPassword,
    this.logo,
    this.regYear,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  String? id;
  String? name;
  String? address;
  String? email;
  String? affiliationNo;
  String? board;
  String? code;
  String? whatsappNo;
  String? institutionContact;
  String? studentPrefix;
  String? parentPrefix;
  String? masterPassword;
  String? logo;
  String? regYear;
  DateTime? createdAt;
  dynamic updatedAt;
  dynamic createdBy;
  dynamic updatedBy;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        email: json["email"],
        affiliationNo: json["affiliation_no"],
        board: json["board"],
        code: json["code"],
        whatsappNo: json["whatsapp_no"],
        institutionContact: json["InstitutionContact"],
        studentPrefix: json["StudentPrefix"],
        parentPrefix: json["ParentPrefix"],
        masterPassword: json["master_password"],
        logo: json["logo"],
        regYear: json["reg_year"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "email": email,
        "affiliation_no": affiliationNo,
        "board": board,
        "code": code,
        "whatsapp_no": whatsappNo,
        "InstitutionContact": institutionContact,
        "StudentPrefix": studentPrefix,
        "ParentPrefix": parentPrefix,
        "master_password": masterPassword,
        "logo": logo,
        "reg_year": regYear,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt,
        "created_by": createdBy,
        "updated_by": updatedBy,
      };
}
