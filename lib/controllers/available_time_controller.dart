import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/repositories/available_time_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvailableTimeController extends ChangeNotifier {
  final AppointmentRepository _appointmentRepository = AppointmentRepository();
  final AvailableTimeRepository _availableTimeRepository =
      AvailableTimeRepository();

  List<Appointment> appointments = [];
  List<AvailableTime> availableTimes = [];
  bool loading = false;
  bool error = false;

  Future<void> findAppointments(DateTime date) async {
    loading = true;
    notifyListeners();

    final shared = await SharedPreferences.getInstance();
    final accessToken = shared.getString('user.access_token');

    var resultsAppointments = await _appointmentRepository.findAll(
        null, accessToken, formatDateSelected(date));
    var resultsAvailableTime =
        await _availableTimeRepository.findAll(formatDateSelected(date));

    appointments = resultsAppointments;
    availableTimes = resultsAvailableTime;
    loading = false;
    notifyListeners();
  }

  Future<void> createAvailableTime(
      DateTime date, TimeOfDay start, TimeOfDay end) async {
    try {
      loading = true;
      error = false;
      notifyListeners();

      if (start.hour + start.minute >= end.hour + end.minute) {
        error = true;
        notifyListeners();
      }

      final shared = await SharedPreferences.getInstance();
      final accessToken = shared.getString('user.access_token');

      var res =
          await _availableTimeRepository.create(date, start, end, accessToken);

      if (!res) {
        error = true;
        notifyListeners();
      }
    } catch (e) {
      error = true;
      notifyListeners();
    } finally {
      loading = false;
      error = false;
      notifyListeners();
    }
  }
}
