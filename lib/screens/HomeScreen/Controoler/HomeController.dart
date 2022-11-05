import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:schoolmanegment/Model/schoolModel.dart';
import 'package:schoolmanegment/Model/studentModel.dart';

import 'package:schoolmanegment/services/HomeServices.dart';
import '../../../constant.dart';
import '../../../utility.dart';

class HomeController extends GetxService {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // var id = await getStudent();
    await home();
    // await studentDetails(id);
  }

  final homeServices = HomeServices();

  Rx<SchoolModel> schoolmodel = SchoolModel().obs;
  RxBool checkData = false.obs;
  RxBool checkStudent = false.obs;
  Rx<Data> data = Data().obs;
  Rx<StudentModel> studentModel = StudentModel().obs;

  Future<void> home() async {
    final response = await homeServices.schoolInfo();
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
          final schoolModel = schoolModelFromJson(response.body);

          data.value = schoolModel.data!;
          checkData.value = true;
          // Get.back();
          // Get.offAllNamed(bottomNavBarRoute);
        }
        // print("result $bannerList");
      }
    }
  }

  Future<void> studentDetails(String studentId) async {
    checkStudent.value = false;
    final response = await homeServices.studentInfo(studentId);
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
          studentModel.value = studentModelFromJson(response.body);
          checkStudent.value = true;
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
