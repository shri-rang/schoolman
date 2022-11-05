import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schoolmanegment/screens/ForgortPassword/Controller/ForgetPasswordController.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../utility.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userUid = "";
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _verificationId = "";
  final SmsAutoFill _autoFill = SmsAutoFill();
  final forgotController = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 15,
              ),
              _verificationId!.isNotEmpty
                  ? TextFormField(
                      controller: _smsController,
                      onSaved: (value) {
                        // authController.emailId = value!.trim();
                      },
                      validator: (value) {
                        // return authController.validateName(value!);
                      },
                      decoration: InputDecoration(
                          hintText: "Verify otp",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          )),
                    )
                  : Container(),
              SizedBox(
                height: 15,
              ),
              _verificationId!.isNotEmpty
                  ? Container(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent,
                          ),
                          onPressed: () {
                            // signInWithPhoneNumber();
                          },
                          child: Text("Verify Otp")),
                    )
                  : Container(),
              SizedBox(
                height: 15,
              ),
              userUid.isEmpty
                  ? Container()
                  : TextFormField(
                      controller: _passwordController,
                      onSaved: (value) {
                        // authController.emailId = value!.trim();
                      },
                      validator: (value) {
                        // return authController.validateName(value!);
                      },
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          )),
                    ),
              SizedBox(
                height: 15,
              ),
              userUid.isEmpty
                  ? Container()
                  : Container(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent,
                          ),
                          onPressed: () async {
                            EasyLoading.show(
                                // indicator: ,
                                status: 'loading...');
                            forgotController.token = await getToken();
                            await forgotController
                                .verifyPassword(_passwordController.text);
                            EasyLoading.dismiss();
                            // Navigator.of(context).pop();
                          },
                          child: Text("Change Password")),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
