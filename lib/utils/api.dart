import 'package:http/http.dart' as http;

import 'constants.dart';

var constUser = {};

class CallApi {
  static Future<http.Response> getData(apiUrl, {Map<String,dynamic>? body}) async {
    var fulUrl = serverUrl + apiUrl;

    if (body != null) {
      print(apiUrl);
      final uri = Uri.http(domain, apiUrl, body);
      print(uri);
      return http.get(uri, headers: setHeader());
    }
    return http.get(Uri.parse(fulUrl), headers: setHeader());
  }

  static setHeader([locationId]) {
    var map = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return map;
  }
}
