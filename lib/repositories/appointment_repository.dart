import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/services/api_service.dart';

class AppointmentRepository {
  final ApiService _apiService = ApiService();
  
  Future<List<Appointment>> findAppointments() async {
    try {
      var res = await _apiService.get('appointments');
      if(res['success']) {
        var results = res['results'] as List;

        List<Appointment> appointments = results.map((e) => Appointment.fromJson(e)).toList();

        return appointments;
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }
}
