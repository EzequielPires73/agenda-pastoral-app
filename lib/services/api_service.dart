import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final dio = Dio(BaseOptions(baseUrl: 'http://192.168.0.10:8080/'));
  //final dio = Dio(BaseOptions(baseUrl: 'https://adcatalao-96c2f1e56512.herokuapp.com/'));

  Future<Map<String, dynamic>> get(String path, Map<String, String>? headers) async {
    var response = await dio.get(path, options: Options(headers: headers));

    return response.data;
  }

  Future<Map<String, dynamic>> post(String path, Object? data, Map<String, dynamic>? headers) async {
    var response = await dio.post(path, data: data, options: Options(headers: headers));

    return response.data;
  }

  Future<Map<String, dynamic>> patch(String path, Object? data, Map<String, dynamic>? headers) async {
    var response = await dio.patch(path, data: data, options: Options(headers: headers));

    return response.data;
  }
  
  Future<Map<String, dynamic>> delete(String path, Object? data, Map<String, dynamic>? headers) async {
    var response = await dio.delete(path, data: data, options: Options(headers: headers));

    return response.data;
  }
}
