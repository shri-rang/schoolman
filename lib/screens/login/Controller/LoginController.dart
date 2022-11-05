import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:schoolmanegment/Model/loginModel.dart';
import 'package:schoolmanegment/constant.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:schoolmanegment/screens/HomeScreen/view/HomeScreen.dart';
import 'package:schoolmanegment/services/loginService.dart';

import '../../../utility.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final authServices = AuthServices();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var emailId = '';
  var password = '';
  LoginModel? loginModel;
  RxString uid = "".obs;
  String? validatePassword(String value) {
    if (value.length < 3) {
      return "Password Should Be Minimum 3 Characters";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Provide First Name";
    }
    return null;
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide Valid Email";
    }
    return null;
  }

  Future<void> loginUser(String token) async {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      print('not valid form');
      Get.back();
      return;
    } else {
      loginFormKey.currentState!.save();
      final response = await authServices.loginUser(emailId, password, token);
      print(response is http.Response);
      print(response);
      if (response == " ") {
        Get.back();
        customSnackBar(
            Constants.connectionFailed, Constants.checkInternetConnection);
      } else if (response is http.Response) {
        print(response.statusCode);
        if (response.statusCode == 404) {
          print(response.body.toString());

          Map mapdata = jsonDecode(response.body.toString());
          Get.back();
          customSnackBar(Constants.failed, mapdata['messages']);
        } else if (response.statusCode == 500) {
          Map mapdata = jsonDecode(response.body.toString());
          Get.back();
          customSnackBar(
              Constants.connectionFailed, Constants.checkServerConnection);
        } else if (response.statusCode == 201) {
          print(response.body);
          Map mapdata = jsonDecode(response.body.toString());
          if (mapdata['error'] == true) {
            // Get.back(closeOverlays: true);
            customSnackBar(Constants.pleaseTryAgain, mapdata['messages']);
          } else {
            // Get.back();

            // final loginModel = loginModelFromJson(response.body);
            loginModel = loginModelFromJson(response.body);
            //  loginModel.student.studentId
            // var details =
            //     "${loginModel!.student!.name}/ ${loginModel!.student!.classname} ${loginModel!.student!.sectionName}";

            await student(loginModel!.student!.studentId!);
            await saveToken(mapdata['data']['token']);

            Get.offAll(HomeSreen());
          }
          print(mapdata);
        }
      }
    }
  }
}
