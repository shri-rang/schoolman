// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  StudentModel({
    this.status,
    this.error,
    this.messages,
    this.data,
    this.photo,
  });

  int? status;
  bool? error;
  String? messages;
  Student? data;
  String? photo;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        status: json["status"],
        error: json["error"],
        messages: json["messages"],
        data: Student.fromJson(json["data"]),
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "messages": messages,
        "data": data!.toJson(),
        "photo": photo,
      };
}

class Student {
  Student({
    this.dataStudentId,
    this.loginId,
    this.name,
    this.dob,
    this.gender,
    this.parentId,
    this.nationality,
    this.regId,
    this.aadharNo,
    this.admNo,
    this.stsNo,
    this.montherTongue,
    this.bloodGroup,
    this.admDate,
    this.regDate,
    this.bpl,
    this.email,
    this.phoneNo,
    this.sphoto,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.fatherName,
    this.motherName,
    this.fatherProfession,
    this.motherProfession,
    this.phone,
    this.address,
    this.photo,
    this.fAnnualIncome,
    this.fatherDesignation,
    this.motherDesignation,
    this.motherPhone,
    this.religion,
    this.caste,
    this.subcaste,
    this.category,
    this.id,
    this.userId,
    this.userName,
    this.password,
    this.userType,
    this.role,
    this.session,
    this.activeuser,
    this.createdOn,
    this.lastLogin,
    this.token,
    this.studentYearwisedataId,
    this.studentId,
    this.admissionstudentId,
    this.classesId,
    this.sectionId,
    this.rollNo,
    this.transportStatus,
    this.transportId,
    this.hostelStatus,
    this.startMonth,
    this.routeIn,
    this.routeOut,
    this.concession,
    this.concessiontype,
    this.regNo,
    this.houseId,
    this.year,
    this.classname,
    this.classnumeric,
    this.isactive,
    this.sectionName,
    this.dataClassesId,
    this.staffId,
  });

  String? dataStudentId;
  String? loginId;
  String? name;
  DateTime? dob;
  String? gender;
  String? parentId;
  String? nationality;
  String? regId;
  String? aadharNo;
  String? admNo;
  String? stsNo;
  String? montherTongue;
  String? bloodGroup;
  String? admDate;
  DateTime? regDate;
  dynamic bpl;
  String? email;
  String? phoneNo;
  String? sphoto;
  String? isActive;
  DateTime? createdAt;
  dynamic updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  String? fatherName;
  String? motherName;
  String? fatherProfession;
  dynamic motherProfession;
  String? phone;
  String? address;
  dynamic photo;
  dynamic fAnnualIncome;
  dynamic fatherDesignation;
  dynamic motherDesignation;
  String? motherPhone;
  String? religion;
  String? caste;
  dynamic subcaste;
  String? category;
  String? id;
  String? userId;
  String? userName;
  String? password;
  String? userType;
  dynamic role;
  String? session;
  String? activeuser;
  DateTime? createdOn;
  dynamic lastLogin;
  String? token;
  String? studentYearwisedataId;
  String? studentId;
  String? admissionstudentId;
  String? classesId;
  String? sectionId;
  String? rollNo;
  String? transportStatus;
  String? transportId;
  dynamic hostelStatus;
  String? startMonth;
  dynamic routeIn;
  dynamic routeOut;
  String? concession;
  String? concessiontype;
  String? regNo;
  dynamic houseId;
  String? year;
  String? classname;
  String? classnumeric;
  String? isactive;
  String? sectionName;
  String? dataClassesId;
  String? staffId;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        dataStudentId: json["student_ID"],
        loginId: json["loginID"],
        name: json["name"],
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
        parentId: json["parentID"],
        nationality: json["nationality"],
        regId: json["regID"],
        aadharNo: json["aadhar_no"],
        admNo: json["adm_no"],
        stsNo: json["sts_no"],
        montherTongue: json["monther_tongue"],
        bloodGroup: json["blood_group"],
        admDate: json["adm_date"],
        regDate: DateTime.parse(json["reg_date"]),
        bpl: json["bpl"],
        email: json["email"],
        phoneNo: json["phone_no"],
        sphoto: json["sphoto"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        fatherProfession: json["father_profession"],
        motherProfession: json["mother_profession"],
        phone: json["phone"],
        address: json["address"],
        photo: json["photo"],
        fAnnualIncome: json["f_annual_income"],
        fatherDesignation: json["father_designation"],
        motherDesignation: json["mother_designation"],
        motherPhone: json["mother_phone"],
        religion: json["religion"],
        caste: json["caste"],
        subcaste: json["subcaste"],
        category: json["category"],
        id: json["id"],
        userId: json["user_id"],
        userName: json["user_name"],
        password: json["password"],
        userType: json["user_type"],
        role: json["role"],
        session: json["session"],
        activeuser: json["activeuser"],
        createdOn: DateTime.parse(json["created_on"]),
        lastLogin: json["last_login"],
        token: json["token"],
        studentYearwisedataId: json["student_yearwisedataID"],
        studentId: json["studentID"],
        admissionstudentId: json["admissionstudentID"],
        classesId: json["classesID"],
        sectionId: json["sectionID"],
        rollNo: json["roll_no"],
        transportStatus: json["transport_status"],
        transportId: json["transport_ID"],
        hostelStatus: json["hostel_status"],
        startMonth: json["start_month"],
        routeIn: json["route_IN"],
        routeOut: json["route_OUT"],
        concession: json["concession"],
        concessiontype: json["concessiontype"],
        regNo: json["reg_no"],
        houseId: json["houseID"],
        year: json["year"],
        classname: json["classname"],
        classnumeric: json["classnumeric"],
        isactive: json["isactive"],
        sectionName: json["section_name"],
        dataClassesId: json["classes_id"],
        staffId: json["staffID"],
      );

  Map<String, dynamic> toJson() => {
        "student_ID": dataStudentId,
        "loginID": loginId,
        "name": name,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "parentID": parentId,
        "nationality": nationality,
        "regID": regId,
        "aadhar_no": aadharNo,
        "adm_no": admNo,
        "sts_no": stsNo,
        "monther_tongue": montherTongue,
        "blood_group": bloodGroup,
        "adm_date": admDate,
        "reg_date":
            "${regDate!.year.toString().padLeft(4, '0')}-${regDate!.month.toString().padLeft(2, '0')}-${regDate!.day.toString().padLeft(2, '0')}",
        "bpl": bpl,
        "email": email,
        "phone_no": phoneNo,
        "sphoto": sphoto,
        "is_active": isActive,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "father_name": fatherName,
        "mother_name": motherName,
        "father_profession": fatherProfession,
        "mother_profession": motherProfession,
        "phone": phone,
        "address": address,
        "photo": photo,
        "f_annual_income": fAnnualIncome,
        "father_designation": fatherDesignation,
        "mother_designation": motherDesignation,
        "mother_phone": motherPhone,
        "religion": religion,
        "caste": caste,
        "subcaste": subcaste,
        "category": category,
        "id": id,
        "user_id": userId,
        "user_name": userName,
        "password": password,
        "user_type": userType,
        "role": role,
        "session": session,
        "activeuser": activeuser,
        "created_on": createdOn!.toIso8601String(),
        "last_login": lastLogin,
        "token": token,
        "student_yearwisedataID": studentYearwisedataId,
        "studentID": studentId,
        "admissionstudentID": admissionstudentId,
        "classesID": classesId,
        "sectionID": sectionId,
        "roll_no": rollNo,
        "transport_status": transportStatus,
        "transport_ID": transportId,
        "hostel_status": hostelStatus,
        "start_month": startMonth,
        "route_IN": routeIn,
        "route_OUT": routeOut,
        "concession": concession,
        "concessiontype": concessiontype,
        "reg_no": regNo,
        "houseID": houseId,
        "year": year,
        "classname": classname,
        "classnumeric": classnumeric,
        "isactive": isactive,
        "section_name": sectionName,
        "classes_id": dataClassesId,
        "staffID": staffId,
      };
}
