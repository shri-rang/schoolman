import 'package:http/http.dart' as http;

import 'package:schoolmanegment/constant.dart';

class ForgotPasswordServoces {
  Future<dynamic> forgotPassword(
    String emailId,
    // String password,
  ) async {
    try {
      print('loginUser');
      print(emailId);
      // var basicAuth = await authHeader();
      var url = Uri.parse('${Constants.url}${Constants.forgotpassword}');
      var response = await http.post(url,
          // headers: <String, String>{
          //   'authorization': basicAuth,
          //   'Accept-Language': Constants.acceptedLanguage,
          //   'platform': Platform.operatingSystem,
          //   'version': deviceVersion,
          //   'device-id': deviceId
          // },
          body: {
            'email': emailId,
          });
      // print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }

  Future<dynamic> verifyPassword(
    String password,
    String auth,
  ) async {
    try {
      print('loginUser');
      print(password);
      // var basicAuth = await authHeader();
      var url = Uri.parse('${Constants.url}${Constants.varifypassword}');
      var response = await http.post(url, headers: <String, String>{
        'Authorization': auth,
        //   'Accept-Language': Constants.acceptedLanguage,
        //   'platform': Platform.operatingSystem,
        //   'version': deviceVersion,
        //   'device-id': deviceId
      }, body: {
        'password': password,
      });
      // print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }
}
