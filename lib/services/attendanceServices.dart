import 'package:http/http.dart' as http;

import 'package:schoolmanegment/constant.dart';

class AttendnaceServices {
  Future<dynamic> attendace(String auth) async {
    try {
      print('loginUser');

      // var basicAuth = await authHeader();
      var url = Uri.parse('${Constants.url}${Constants.attendance}');
      var response = await http.get(
        url,
        headers: <String, String>{
          'authorization': auth,
          //   'Accept-Language': Constants.acceptedLanguage,
          //   'platform': Platform.operatingSystem,
          //   'version': deviceVersion,
          //   'device-id': deviceId
        },
      );
      // print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }
}
