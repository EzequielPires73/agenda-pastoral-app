import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/services/api_service.dart';
import 'package:flutter/material.dart';

class AvailableTimeRepository {
  final ApiService _apiService = ApiService();

  Future<List<AvailableTime>> findAll(String? date) async {
    try {
      var res = await _apiService.get('available-times?${date != null ? 'date=$date' : null}', null);

      if (res['success']) {
        var results = res['results'] as List;
        List<AvailableTime> availableTimes =
            results.map((e) => AvailableTime.fromJson(e)).toList();
        return availableTimes;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<bool> create(
      DateTime date, TimeOfDay start, TimeOfDay end, String? token) async {
    try {
      var res = await _apiService.post('available-times', {
        "date": formatDateSelected(date),
        "start": formatTimeSelected(start),
        "end": formatTimeSelected(end),
      }, {
        "authorization": 'Bearer $token'
      });

      print(res);

      if (res['success']) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
