import 'dart:convert';

import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/models/appointment_category.dart';
import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/repositories/appointment_category_repository.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/repositories/available_time_repository.dart';
import 'package:flutter/foundation.dart';
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

  String errorMsg = '';
  List<Appointment> appointments = [];
  Appointment? appointment;
  TextEditingController observation = TextEditingController();
  AppointmentCategory? category;
  Time? time;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  Future<void> onDispose() async {
    time = null;
    errorMsg = '';
    state = AppointmentState.idle;
    observation.text = '';
    category = null;
    focusedDay = DateTime.now();
    selectedDay = DateTime.now();
  }

  changeTimes(List<Time> newList) {
    times = newList;
    notifyListeners();
  }

  Future<void> loadInitialValues() async {
    try {
      availableTimes = await _availableTimeRepository.findAll(null);
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
      final member = shared.getString('member');
      final accessToken = shared.getString('member.access_token');

      verifyErrorsMember(
        category: category,
        time: time,
        memberSelected: member != null
            ? Member.fromJson(
                jsonDecode(member),
              )
            : null,
        accessToken: accessToken,
      );

      if (category != null && time != null && member != null) {
        var res = await _appointmentRepository.create(
            Appointment(
              category: category!,
              date: formatDateSelected(selectedDay),
              observation: observation.text,
              start: '${time!.start.replaceAll(' AM', '').replaceAll(' PM', '')}:00',
              end: '${time!.end.replaceAll(' AM', '').replaceAll(' PM', '')}:00',
              status: 'pendente',
              member: Member.fromJson(jsonDecode(member)),
            ),
            accessToken);

        appointment = res.appointment;

        if (appointment != null) {
          state = AppointmentState.success;
          notifyListeners();
        } else {
          errorMsg = res.errorMessage ??
              'Erro ao agendar esse compromisso, tente novamente ou entre em contato.';
          state = AppointmentState.error;
          notifyListeners();
        }
      } else {
        state = AppointmentState.error;
      }
    } catch (error) {
      print(error);
      state = AppointmentState.error;
      errorMsg = error.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> createAppointmentByAdmin(
      {UserAbstract? memberSelected, UserAbstract? responsibleSelected}) async {
    state = AppointmentState.loadding;
    notifyListeners();
    try {
      verifyErrors(
        category: category,
        memberSelected: memberSelected,
        responsibleSelected: responsibleSelected,
        time: time,
      );

      final shared = await SharedPreferences.getInstance();
      final accessToken = shared.getString('user.access_token');

      if (category != null && time != null && memberSelected != null) {
        var res = await _appointmentRepository.create(
            Appointment(
                category: category!,
                date: formatDateSelected(selectedDay),
                observation: observation.text,
                start: '${time!.start.replaceAll(' AM', '').replaceAll(' PM', '')}:00',
                end: '${time!.end.replaceAll(' AM', '').replaceAll(' PM', '')}:00',
                status: responsibleSelected != null ? 'confirmado' : 'pendente',
                member: memberSelected as Member,
                responsible: responsibleSelected != null
                    ? responsibleSelected as User
                    : null),
            accessToken);

        appointment = res.appointment;

        if (appointment != null) {
          state = AppointmentState.success;
          notifyListeners();
        } else {
          errorMsg = res.errorMessage ??
              'Erro ao agendar esse compromisso, tente novamente ou entre em contato.';
          state = AppointmentState.error;
          notifyListeners();
        }
      } else {
        state = AppointmentState.error;
      }
    } catch (error) {
      state = AppointmentState.error;
      errorMsg = error.toString();
    } finally {
      notifyListeners();
    }
  }

  verifyErrors(
      {AppointmentCategory? category,
      UserAbstract? memberSelected,
      UserAbstract? responsibleSelected,
      Time? time}) {
    if (category == null) {
      return throw Exception('Selecione um motivo do agendamento.');
    } else if (time == null) {
      return throw Exception(
          'Selecione um horário disponível para o agendamento.');
    } else if (memberSelected == null) {
      return throw Exception('Selecione um membro para o agendamento.');
    } else if (responsibleSelected == null) {
      return throw Exception('Selecione um responsável para o agendamento.');
    }
  }

  verifyErrorsMember({
    AppointmentCategory? category,
    UserAbstract? memberSelected,
    Time? time,
    String? accessToken,
  }) {
    if (category == null) {
      return throw Exception('Selecione um motivo do agendamento.');
    } else if (time == null) {
      return throw Exception(
          'Selecione um horário disponível para o agendamento.');
    } else if (memberSelected == null) {
      return throw Exception(
          'Um membro é necessário para o agendamento, faça login novamente.');
    } else if (accessToken == null) {
      return throw Exception('Usuário inválido faça login novamente.');
    }
  }
}
