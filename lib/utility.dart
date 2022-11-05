import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';

Future<void> saveToken(String accessToken) async {
  final box = GetStorage();
  box.write('access_token', accessToken);
}

Future<void> student(String studentDetails) async {
  final box = GetStorage();
  box.write('studentDetails', studentDetails);
}

Future<String> getStudent() async {
  final box = GetStorage();
  return box.read('studentDetails');
}

Future<void> deleteStudent() async {
  final box = GetStorage();
  return box.remove('studentDetails');
}

Future<String?> getToken() async {
  final box = GetStorage();
  return box.read('access_token');
}

customSnackBar(title, message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
  );
}

Future<void> deleteToken() async {
  final box = GetStorage();
  return box.remove('access_token');
}


//used to provide deviceId
// Future<String?> getDeviceId() async {
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   String? deviceId;
//   if (Platform.isAndroid) {
//     // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     deviceId = await PlatformDeviceId.getDeviceId;
//   } else if (Platform.isIOS) {

//     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//     deviceId = iosInfo.identifierForVendor.toString();
//   }
//   return deviceId;
// }