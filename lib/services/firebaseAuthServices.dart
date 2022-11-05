// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:schoolmanegment/screens/ForgortPassword/Controller/ForgetPasswordController.dart';

// class FirebaseAuthServices {
//   // final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final forgotController = Get.find<ForgetPasswordController>();
//   // final TextEditingController _phoneNumberController = TextEditingController();
//   // final TextEditingController _smsController = TextEditingController();
//   // String? _verificationId;
//   // final SmsAutoFill _autoFill = SmsAutoFill();

//   void verifyPhoneNumber(String mobileno) async {
//     PhoneVerificationCompleted verificationCompleted =
//         (PhoneAuthCredential phoneAuthCredential) async {
//       await _auth.signInWithCredential(phoneAuthCredential);
//       showSnackbar(
//           "Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}");
//     };
//     PhoneVerificationFailed verificationFailed =
//         (FirebaseAuthException authException) {
//       print("error $authException.message");
//       showSnackbar(
//           'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
//     };

//     PhoneCodeSent codeSent =
//         (String verificationId, [int? forceResendingToken]) async {
//       print("error $verificationId");
//       showSnackbar('Please check your phone for the verification code.');
//       forgotController.verificationId!.value = verificationId;
//     };

//     PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//         (String verificationId) {
//       print("error $verificationId");
//       showSnackbar("verification code: " + verificationId);
//       forgotController.verificationId!.value = verificationId;
//     };

//     try {
//       await _auth.verifyPhoneNumber(
//           phoneNumber: mobileno,
//           timeout: const Duration(seconds: 5),
//           verificationCompleted: verificationCompleted,
//           verificationFailed: verificationFailed,
//           codeSent: codeSent,
//           codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//     } catch (e) {
//       print("error $e");
//       showSnackbar("Failed to Verify Phone Number: ${e}");
//     }
//   }

//   void signInWithPhoneNumber(String smscode) async {
//     try {
//       final AuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: forgotController.verificationId!.value,
//         smsCode: smscode,
//       );

//       final User? user = (await _auth.signInWithCredential(credential)).user;

//       showSnackbar("Successfully signed in UID: ${user!.uid}");
//     } catch (e) {
//       showSnackbar("Failed to sign in: " + e.toString());
//     }
//   }

//   void showSnackbar(String message) {
//     _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
//   }
// }
