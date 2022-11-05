import 'package:http/http.dart' as http;
import '../constant.dart';

class CircularServices {
  Future<dynamic> circular(String auth) async {
    try {
      print('loginUser');

      // var basicAuth = await authHeader();
      var url = Uri.parse('${Constants.url}${Constants.circular}');
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

  Future<dynamic> circularDetails(String auth, String id) async {
    try {
      print('loginUser');

      // var basicAuth = await authHeader();
      var url = Uri.parse('${Constants.url}${Constants.circularDetails}/$id');
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
