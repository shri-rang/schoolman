import 'dart:convert';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolmanegment/constant.dart';
import 'package:schoolmanegment/screens/ForgortPassword/view/Forgotpassword.dart';
import 'package:schoolmanegment/services/forgotpasswprdService.dart';
import 'package:schoolmanegment/utility.dart';

class ForgetPasswordController extends GetxController {
  RxString? verificationId = "".obs;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final forgotPasword = ForgotPasswordServoces();

  RxString phoneNo = "".obs;
  String? token;
  RxString userUid = "".obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    // await home();
  }

  Future<void> forgortpassword(String emailId) async {
    final response = await forgotPasword.forgotPassword(emailId);
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
          await saveToken(mapdata['token']);
          // final schoolModel = schoolModelFromJson(response.body);
          phoneNo.value = mapdata['data'];
          // data.value = schoolModel.data!;
          // Get.back();
          // Get.offAllNamed(bottomNavBarRoute);
        }
        // print("result $bannerList");
      }
    }
  }

  Future<void> verifyPassword(
    String password,
  ) async {
    final response = await forgotPasword.verifyPassword(password, token!);
    if (response == " ") {
      Get.back();
      customSnackBar(
          Constants.connectionFailed, 'Please check your Internet Connection');
    } else if (response is http.Response) {
      print("fasd ${response.body}");
      if (response.statusCode == 404) {
        Map mapdata = jsonDecode(response.body.toString());
        // Get.back();
        customSnackBar(Constants.failed, mapdata['message']);
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
          // Get.back();
          customSnackBar(Constants.connectionFailed, mapdata['messages']);
        } else {
          // final schoolModel = schoolModelFromJson(response.body);
          // phoneNo.value = mapdata['data'];
          // data.value = schoolModel.data!;
          // Get.back();
          // Get.offAllNamed(bottomNavBarRoute);
          customSnackBar("", mapdata['messages']);
          // Future.delayed(Duration(seconds: 1), () {
          //   Get.back();
          // });
        }
        // print("result $bannerList");
      }
    }
  }
}
