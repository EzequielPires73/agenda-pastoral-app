import 'package:agenda_pastora_app/models/appointment_category.dart';
import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/repositories/appointment_category_repository.dart';
import 'package:agenda_pastora_app/repositories/available_time_repository.dart';
import 'package:flutter/material.dart';

class AppointmentController extends ChangeNotifier {
  final AppointmentCategoryRepository _appointmentCategoryRepository =
      AppointmentCategoryRepository();
  final AvailableTimeRepository _availableTimeRepository =
      AvailableTimeRepository();

  List<AvailableTime> availableTimes = [];
  List<AppointmentCategory> appointmentsCategories = [];
  List<Time> times = [];

  AppointmentCategory? category;
  Time? time;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  Future<void> loadInitialValues() async {
    availableTimes = await _availableTimeRepository.findAll();
    appointmentsCategories = await _appointmentCategoryRepository.findAll();
    notifyListeners();
  }

  void changeDateSelected(DateTime selected, DateTime focused) {
    selectedDay = selected;
    focusedDay = focused;
    notifyListeners();
  }

  Future<void> changeCategorySelected(
      AppointmentCategory appointmentCategory) async {
    category = appointmentCategory;
    await loadAvaibleTimes(appointmentCategory);
    notifyListeners();
  }

  Future<void> loadAvaibleTimes(AppointmentCategory appointmentCategory) async {
    if (category != null) {
      times = await _appointmentCategoryRepository.findTimes(
          appointmentCategory, focusedDay);
      print(times[0].start);
      notifyListeners();
    }
  }
}
