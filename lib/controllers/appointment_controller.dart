import 'dart:convert';

import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/models/appointment_category.dart';
import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/repositories/appointment_category_repository.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/repositories/available_time_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppointmentState { idle, loadding, loaddingTimes, error, success }

class AppointmentController extends ChangeNotifier {
  var state = AppointmentState.idle;
  final AppointmentRepository _appointmentRepository = AppointmentRepository();
  final AppointmentCategoryRepository _appointmentCategoryRepository =
      AppointmentCategoryRepository();
  final AvailableTimeRepository _availableTimeRepository =
      AvailableTimeRepository();

  List<AvailableTime> availableTimes = [];
  List<AppointmentCategory> appointmentsCategories = [];
  List<Time> times = [];

  List<Appointment> appointments = [];
  Appointment? appointment;
  TextEditingController observation = TextEditingController();
  AppointmentCategory? category;
  Time? time;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  Future<void> loadInitialValues() async {
    try {
      availableTimes = await _availableTimeRepository.findAll();
      appointmentsCategories = await _appointmentCategoryRepository.findAll();
    } catch (error) {
      state = AppointmentState.error;
      notifyListeners();
    } finally {
      state = AppointmentState.idle;
      notifyListeners();
    }
  }

  Future<void> changeDateSelected(DateTime selected, DateTime focused) async {
    selectedDay = selected;
    focusedDay = focused;
    if (category != null) {
      await loadAvaibleTimes(category!);
    }
    notifyListeners();
  }

  Future<void> changeCategorySelected(
      AppointmentCategory appointmentCategory) async {
    category = appointmentCategory;
    await loadAvaibleTimes(appointmentCategory);
    notifyListeners();
  }

  changeTimeSelected(Time timeSelected) {
    time = timeSelected;
    notifyListeners();
  }

  Future<void> loadAvaibleTimes(AppointmentCategory appointmentCategory) async {
    state = AppointmentState.loaddingTimes;
    notifyListeners();
    try {
      times = await _appointmentCategoryRepository.findTimes(
          appointmentCategory, focusedDay);
    } catch (error) {
      state = AppointmentState.error;
      notifyListeners();
    } finally {
      state = AppointmentState.idle;
      notifyListeners();
    }
  }

  Future<void> findAppointments() async {
    try {
      state = AppointmentState.loadding;
      notifyListeners();
      final shared = await SharedPreferences.getInstance();
      final accessToken = shared.getString('access_token');
      await Future.delayed(const Duration(seconds: 3));
      appointments =
          await _appointmentRepository.findAll('pendente', accessToken, null);
      state = AppointmentState.idle;
    } catch (error) {
      state = AppointmentState.error;
    }
    notifyListeners();
  }

  Future<void> createAppointment() async {
    state = AppointmentState.loadding;
    notifyListeners();

    try {
      final shared = await SharedPreferences.getInstance();
      final accessToken = shared.getString('access_token');
      final member = shared.getString('member');

      if (category != null && time != null && member != null) {
        appointment = await _appointmentRepository.create(
            Appointment(
              category: category!,
              date: formatDateSelected(selectedDay),
              observation: observation.text,
              start: time!.start,
              end: time!.end,
              status: 'pendente',
              member: Member.fromJson(jsonDecode(member)),
            ),
            accessToken);

        if (appointment != null) {
          state = AppointmentState.success;
        } else {
          state = AppointmentState.error;
        }
      } else {
        state = AppointmentState.error;
      }
    } catch (error) {
      print(error);
      state = AppointmentState.error;
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }
}
