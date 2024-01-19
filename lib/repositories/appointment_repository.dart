import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/services/api_service.dart';

class AppointmentRepository {
  final ApiService _apiService = ApiService();

  Future<List<Appointment>> findAppointmentsByMember(String status, String? token) async {
    try {
      var res = await _apiService.get('appointments/me?status=$status', {"authorization": "Bearer $token"});

      if (res['success']) {
        var results = res['results'] as List;

        List<Appointment> appointments =
            results.map((e) => Appointment.fromJson(e)).toList();

        return appointments;
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  Future<Appointment?> findOne(int id) async {
    try {
      var res = await _apiService.get('appointments/$id', null);

      if(res['success']) {
        Appointment appointment = Appointment.fromJson(res['result']);

        return appointment;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
