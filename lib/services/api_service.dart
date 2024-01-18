import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final baseUrl = 'http://192.168.0.101:8080/';

  Future<Map<String, dynamic>> get(String path) async {
    var response = await http.get(Uri.parse(baseUrl + path));

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> post(String path, Object? data, Map<String, String>? headers) async {
    print(data);
    var response = await http.post(Uri.parse(baseUrl + path), body: data, headers: headers);

    return json.decode(response.body);
  }
}