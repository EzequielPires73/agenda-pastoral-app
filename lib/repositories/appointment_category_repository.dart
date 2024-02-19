import 'package:agenda_pastora_app/models/appointment_category.dart';
import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/services/api_service.dart';
import 'package:intl/intl.dart';

class AppointmentCategoryCreationResult {
  AppointmentCategory? category;
  String? errorMessage;

  AppointmentCategoryCreationResult({this.category, this.errorMessage});
}

class AppointmentCategoryRepository {
  final ApiService _apiService = ApiService();

  Future<List<AppointmentCategory>> findAll() async {
    try {
      var res = await _apiService.get('appointments-categories', null);

      if (res['success']) {
        var results = res['results'] as List;
        List<AppointmentCategory> categories =
            results.map((e) => AppointmentCategory.fromJson(e)).toList();

        return categories;
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<List<Time>> findTimes(
      AppointmentCategory category, DateTime date) async {
    try {
      var res = await _apiService.get(
          'appointments-categories/avaible-times/${category.id}?date=${_formatDate(date)}',
          null);

      if (res['success']) {
        var results = res['results'] as List;
        List<Time> times = results.map((e) => Time.fromJson(e)).toList();

        return times;
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<AppointmentCategoryCreationResult> create(
      AppointmentCategory category, String? token) async {
    try {
      var res = await _apiService.post(
        'appointments-categories',
        category.toJson(),
        {"authorization": "Bearer $token"},
      );

      if(res['success']) {
        return AppointmentCategoryCreationResult(category: AppointmentCategory.fromJson(res['result']));
      } else {
        return AppointmentCategoryCreationResult(errorMessage: res['message']);
      }
    } catch (error) {
      return AppointmentCategoryCreationResult(errorMessage: error.toString());
    }
  }

  String _formatDate(DateTime date) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(date);
    return formattedDate;
  }
}
