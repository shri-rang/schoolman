import 'dart:convert';

import 'package:get/get.dart';
import 'package:schoolmanegment/Model/attendanceModel.dart';
import 'package:schoolmanegment/constant.dart';
import 'package:schoolmanegment/services/attendanceServices.dart';
import 'package:schoolmanegment/utility.dart';
import 'package:http/http.dart' as http;

class AttendanceController extends GetxController {
  final attendanceService = AttendnaceServices();

  Rx<AttendanceModel> attendanceModel = AttendanceModel().obs;

  String? token;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // var id = await getStudent();
    // await home();
    token = await getToken();
    // circular(token!);
    await getattendance(token!);
  }

  Future<void> getattendance(
    String auth,
  ) async {
    // checkStudent.value = false;

    final response = await attendanceService.attendace(auth);
    if (response == " ") {
      Get.back();
      customSnackBar(
          Constants.connectionFailed, 'Please check your Internet Connection');
    } else if (response is http.Response) {
      print("fasd ${response.statusCode}");
      if (response.statusCode == 404) {
        Map mapdata = jsonDecode(response.body.toString());
        Get.back();
        customSnackBar(Constants.failed, mapdata['message'][0]);
      } else if (response.statusCode == 500) {
        Map mapdata = jsonDecode(response.body.toString());
        Get.back();
        customSnackBar(Constants.connectionFailed,
            'Some Error occurred in connecting to server, please try again later');
      } else if (response.statusCode == 201) {
        var mapdata = jsonDecode(response.body.toString());
        print(" hey ${response.body}");
        // final bannerModel = bannerModelFromJson(response.body);

        // bannerList.addAll(bannerModel.data!.result!);
        if (mapdata['error'] == true) {
          Get.back();
          customSnackBar(Constants.connectionFailed, mapdata['message']);
        } else {
          attendanceModel.value = attendanceModelFromJson(response.body);

          // studentModel.value = studentModelFromJson(response.body);
          // checkStudent.value = true;
          // data.value = schoolModel.data!;
          // checkData.value = true;
          // Get.back();
          // Get.offAllNamed(bottomNavBarRoute);
        }
        // print("result $bannerList");
      }
    }
  }
}
