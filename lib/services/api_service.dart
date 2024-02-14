import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //final baseUrl = 'https://adcatalao-96c2f1e56512.herokuapp.com/';
  final String baseUrl = 'http://192.168.0.102:8080/';
  final dio = Dio(BaseOptions(baseUrl: 'http://192.168.0.102:8080/'));

  Future<Map<String, dynamic>> get(String path, Map<String, String>? headers) async {
    var response = await http.get(Uri.parse(baseUrl + path), headers: headers);

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> post(String path, Object? data, Map<String, dynamic>? headers) async {
    var response = await dio.post(path, data: data, options: Options(headers: headers));

    return response.data;
  }
  
  Future<Map<String, dynamic>> delete(String path, Object? data, Map<String, dynamic>? headers) async {
    var response = await dio.delete(path, data: data, options: Options(headers: headers));

    return response.data;
  }
}
