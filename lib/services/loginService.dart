import 'package:http/http.dart' as http;
import '../constant.dart';

class AuthServices {
  Future<dynamic> loginUser(
    String emailId,
    String password,
    String fbtoken,
  ) async {
    try {
      print('loginUser $fbtoken');
      print(emailId);
      // var basicAuth = await authHeader();
      var url = Uri.parse('${Constants.url}${Constants.login}');
      var response = await http.post(url,
          // headers: <String, String>{
          //   'authorization': basicAuth,
          //   'Accept-Language': Constants.acceptedLanguage,
          //   'platform': Platform.operatingSystem,
          //   'version': deviceVersion,
          //   'device-id': deviceId
          // },
          body: {'email': emailId, 'password': password, 'token': fbtoken});
      // print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }

  // Future<dynamic> registerUser(name,phone,emailId, password, deviceId,deviceVersion) async {
  //   try {
  //     var basicAuth = await authHeader();
  //     var url = Uri.parse('${Constants.baseUrl}${Constants.register}');
  //     var response = await http.post(url, headers: <String, String>{
  //       'authorization': basicAuth,
  //       'Accept-Language': Constants.acceptedLanguage,
  //       'platform': Platform.operatingSystem,
  //       'version': deviceVersion,
  //       'device-id': deviceId
  //     }, body: {
  //       'name':name,
  //       'phone':phone,
  //       'email': emailId,
  //       'password': password,
  //       'country_id':Constants.countryId,
  //     });
  //     // print(response);
  //     return response;
  //   } catch (e) {
  //     print('=======This is exception=========');
  //     print(e);
  //     return ' ';
  //   }
  // }

  // Future<dynamic> forgotPassword(deviceId,deviceVersion) async {
  //   try {
  //     // var basicAuth = await authHeader();
  //     var url = Uri.parse(Constants.baseUrl+Constants.forgotPassword);
  //     var response = await http.post(url, headers: <String, String>{
  //       'authorization': basicAuth,
  //       'Accept-Language': Constants.acceptedLanguage,
  //       'platform': Platform.operatingSystem,
  //       'version': deviceVersion,
  //       'device-id': deviceId
  //     }, body: {
  //       'country_id':Constants.countryId,
  //     });
  //     print(response.body);
  //     return response;
  //   } catch (e) {
  //     print('=======This is exception=========');
  //     print(e);
  //     return ' ';
  //   }
  // }

}
