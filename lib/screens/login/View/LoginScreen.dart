import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schoolmanegment/screens/ForgortPassword/Controller/ForgetPasswordController.dart';
import 'package:schoolmanegment/screens/ForgortPassword/view/Forgotpassword.dart';
import 'package:schoolmanegment/screens/HomeScreen/Controoler/HomeController.dart';
import 'package:schoolmanegment/screens/login/Controller/LoginController.dart';
import 'package:schoolmanegment/utility.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = Get.put(LoginController());
  final homeController = Get.put(HomeController());
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _verificationId = "";
  final SmsAutoFill _autoFill = SmsAutoFill();
  String userUid = "";
  final forgotController = Get.put(ForgetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/study.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Container(
              width: 312,
              height: 500,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: authController.loginFormKey,
                    child: Obx(
                      () => SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            homeController.checkData.value
                                ? Image.network(
                                    "https://development.erpsofts.com/writable/uploads/logo/${homeController.data.value.logo!}",
                                    height: 50,
                                    width: 50,
                                  )
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            homeController.checkData.value
                                ? Text(
                                    homeController.data.value.name!,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Container(),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: authController.emailIdController,
                              onSaved: (value) {
                                authController.emailId = value!.trim();
                              },
                              validator: (value) {
                                return authController.validateName(value!);
                              },
                              decoration: InputDecoration(
                                  hintText: "Username",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF01579b),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color(0xFF01579b),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: authController.passwordController,
                              onSaved: (value) {
                                authController.password = value!.trim();
                              },
                              validator: (value) {
                                return authController.validatePassword(value!);
                              },
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color(0xFF01579b),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF01579b),
                                  ),
                                  onPressed: () async {
                                    if (authController
                                        .loginFormKey.currentState!
                                        .validate()) {
                                      EasyLoading.show(status: 'loading...');
                                      var token = await FirebaseMessaging
                                          .instance
                                          .getToken();
                                      print(" hey $token");
                                      await authController.loginUser(token!);
                                      EasyLoading.dismiss();
                                    }
                                  },
                                  child: Text(
                                    "Submit",
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                // Get.to(ForgetPassword());
                                forgotPassword();
                              },
                              child: Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            TextButton(
                                onPressed: () {
                                  _launchWhatsapp(
                                      homeController.data.value.whatsappNo!);
                                },
                                child: Text(
                                  "Need Help ?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                )),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchWhatsapp(String whatsapp) async {
    // var whatsapps = "+918097267015";
    // var  countryCode
    launchUrl(Uri.parse('https://wa.me/$whatsapp?text=Hi'),
        mode: LaunchMode.externalApplication);

    //
    // var whatsappAndroid =
    //     Uri.parse("whatsapp://send?phone=$whatsapps&text=hello");

    // if (await canLaunchUrl(whatsappAndroid)) {
    //   await launchUrl(whatsappAndroid, mode: LaunchMode.externalApplication);
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text("WhatsApp is not installed on the device"),
    //     ),
    //   );
    // }
  }

  forgotPassword() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          // contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.only(top: 10, right: 6, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Forgot Password'),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close))
              ],
            ),
          ),
          content: Obx(
            () => Container(
              height: 200,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),

                  forgotController.phoneNo.value.isEmpty
                      ? TextFormField(
                          controller: _phoneNumberController,
                          onSaved: (value) {
                            // authController.emailId = value!.trim();
                          },
                          validator: (value) {
                            // return authController.validateName(value!);
                          },
                          decoration: InputDecoration(
                              hintText: "Username",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xFF01579b),
                                ),
                              )),
                        )
                      :
                      //  Obx(() =>
                      Text(
                          forgotController.phoneNo.value,
                          style: TextStyle(fontSize: 20),
                        ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  forgotController.phoneNo.value.isEmpty
                      ? Container(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                              // style: ElevatedButton.styleFrom(
                              //   primary: Colors.blueAccent,
                              // ),
                              onPressed: () async {
                                if (_phoneNumberController.text.isNotEmpty) {
                                  EasyLoading.show(
                                      // indicator: ,
                                      status: 'loading...');
                                  await forgotController.forgortpassword(
                                      _phoneNumberController.text);
                                  EasyLoading.dismiss();
                                }

                                // if (authController.loginFormKey.currentState!
                                //     .validate()) {
                                //   EasyLoading.show(status: 'loading...');
                                //   await authController.loginUser();
                                //   // EasyLoading.dismiss();
                                // }
                              },
                              child: Text(
                                "Submit",
                              )),
                        )
                      : Container(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                verifyPhoneNumber();
                                Navigator.of(context).pop();
                                verifyOtp();
                              },
                              child: Text("Get Otp")),
                        )
                ],
              ),
            ),
          )

          // actions: <Widget>[
          //   TextButton(
          //     onPressed: () => Navigator.pop(context, 'Cancel'),
          //     child: const Text('Cancel'),
          //   ),
          //   TextButton(
          //     onPressed: () => Navigator.pop(context, 'OK'),
          //     child: const Text('OK'),
          //   ),
          // ],
          ),
    );
  }

  // getOtp() {
  //   return showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: const Text('AlertDialog Title'),
  //       content: Obx(
  //         () {
  //           return Column(
  //             children: [
  //               forgotController.phoneNo.value.isEmpty
  //                   ? Container()
  //                   :
  //                   //  Obx(() =>
  //                   Text(
  //                       forgotController.phoneNo.value,
  //                       style: TextStyle(fontSize: 20),
  //                     ),
  //               // ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               forgotController.phoneNo.value.isEmpty
  //                   ? Container()
  //                   : Container(
  //                       width: 110,
  //                       height: 40,
  //                       child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                             primary: Colors.blueAccent,
  //                           ),
  //                           onPressed: () {
  //                             verifyPhoneNumber();
  //                           },
  //                           child: Text("Get Otp")),
  //                     )
  //             ],
  //           );
  //         },
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, 'Cancel'),
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, 'OK'),
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  verifyOtp() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.only(top: 10, right: 6, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Forgot Password'),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close))
              ],
            ),
          ),
          content: Obx(
            () {
              return Container(
                height: 200,
                child: Column(
                  children: [
                    // _verificationId!.isNotEmpty
                    //     ?

                    // : Container(),

                    // _verificationId!.isNotEmpty
                    //     ?

                    // : Container(),

                    forgotController.userUid.isEmpty
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
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color(0xFF01579b),
                                  ),
                                )),
                          )
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
                    forgotController.userUid.isEmpty
                        ? Container(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () async {
                                  await signInWithPhoneNumber().then((value) {
                                    setState;
                                  });
                                },
                                child: Text("Verify Otp")),
                          )
                        : Container(
                            width: 200,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () async {
                                  // EasyLoading.show(
                                  //     // indicator: ,
                                  //     status: 'loading...');
                                  forgotController.token = await getToken();
                                  await forgotController
                                      .verifyPassword(_passwordController.text);
                                  // EasyLoading.dismiss();
                                  Navigator.of(context).pop();
                                },
                                child: Text("Change Password")),
                          )
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  changgePassword() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: Column(
          children: [],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void verifyPhoneNumber() async {
    EasyLoading.show(
        // indicator: ,
        status: 'loading...');
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
          
      // await _auth.signInWithCredential(phoneAuthCredential);
      // showSnackbar(
      //     "Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print("error $authException.message");
      // showSnackbar(
      //     'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      print("error $verificationId");
      // showSnackbar('Please check your p
      //hone for the verification code.');
      setState(() {});
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print("error $verificationId");
      // showSnackbar("verification code: " + verificationId);
      _verificationId = verificationId;
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: forgotController.phoneNo.value,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      EasyLoading.dismiss();
    } catch (e) {
      print("error $e");
      showSnackbar("Failed to Verify Phone Number: ${e}");
    }
  }

  Future signInWithPhoneNumber() async {
    // EasyLoading.show(
    //     // indicator: ,
    //     status: 'loading...');
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _smsController.text,
      );

      User? user = (await _auth.signInWithCredential(credential)).user;

      forgotController.userUid.value = user!.uid;
      setState(() {});
      // EasyLoading.dismiss();
      // showSnackbar("Successfully signed in UID: ${user!.uid}");
    } catch (e) {
      showSnackbar("Failed to sign in: " + e.toString());
    }
  }

  void showSnackbar(String message) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
  }
}
