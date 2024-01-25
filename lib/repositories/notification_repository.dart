import 'package:agenda_pastora_app/models/notification.dart';
import 'package:agenda_pastora_app/services/api_service.dart';

class NotificationRepository {
  final ApiService _apiService = ApiService();

  Future<List<AppointmentNotification>> findAll(
      String destination, String? token) async {
    try {
      var res = await _apiService.get('notifications?destination=$destination',
          {"authorization": "Bearer $token"});
      print(res);
      if (res['success']) {
        var results = res['results'] as List;
        List<AppointmentNotification> notifications =
            results.map((e) => AppointmentNotification.fromJson(e)).toList();

        return notifications;
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }
}
