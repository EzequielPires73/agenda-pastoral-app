import 'package:agenda_pastora_app/services/api_service.dart';
import 'package:flutter/material.dart';

class ChartData {
  ChartData({required this.x, required this.y, this.color});
  final String x;
  final int y;
  final Color? color;

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(x: json['name'], y: json['count']);
  }
}

class ReportResponse {
  List<ChartData>? members;
  List<ChartData>? months;
  List<ChartData>? status;
  List<ChartData>? categories;
}

class ReportRepository {
  final ApiService _apiService = ApiService();

  Future<ReportResponse> findMembers() async {
    ReportResponse response = ReportResponse();
    try {
      var res = await _apiService.get('/members/report', null);
      if (res['success']) {
        var results = res['results'] as List;
        print(results);

        List<ChartData> members =
            results.map((e) => ChartData.fromJson(e)).toList();
        response.members = members;

        return response;
      } else {
        return response;
      }
    } catch (error) {
      print(error);
      return response;
    }
  }

  Future<ReportResponse> findData() async {
    ReportResponse response = ReportResponse();
    try {
      var res = await _apiService.get('/appointments/report', null);
      print(res);
      if (res['success']) {
        var results = res['month'] as List;
        List<ChartData> months =
            results.map((e) => ChartData.fromJson(e)).toList();
        response.months = months;

        results = res['category'] as List;
        List<ChartData> categories =
            results.map((e) => ChartData.fromJson(e)).toList();
        response.categories = categories;

        results = res['status'] as List;
        List<ChartData> status =
            results.map((e) => ChartData.fromJson(e)).toList();
        response.status = status;

        return response;
      } else {
        return response;
      }
    } catch (error) {
      print(error);
      return response;
    }
  }
}
