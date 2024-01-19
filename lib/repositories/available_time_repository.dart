import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/services/api_service.dart';

class AvailableTimeRepository {
  final ApiService _apiService = ApiService();

  Future<List<AvailableTime>> findAll() async {
    try {
      var res = await _apiService.get('available-times', null);

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
}
