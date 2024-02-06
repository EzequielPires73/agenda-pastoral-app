import 'dart:convert';

import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/services/api_service.dart';

class AppointmentRepository {
  final ApiService _apiService = ApiService();

  Future<List<Appointment>> findAppointmentsByMember(
      String status, String? token) async {
    try {
      var res = await _apiService.get(
          'appointments/me?status=$status', {"authorization": "Bearer $token"});

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

  Future<List<Appointment>> findAll(String? status, String? token, String? date) async {
    try {
      String path = 'appointments?';
      status != null ? path = '${path}status=$status&' : null;
      date != null ? path = '${path}date=$date&' : null;

      var res = await _apiService.get(
          path, {"authorization": "Bearer $token"});

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

      if (res['success']) {
        Appointment appointment = Appointment.fromJson(res['result']);

        return appointment;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<Appointment?> create(Appointment appointment, String? token) async {
    try {
      var res = await _apiService.post(
        'appointments',
        appointment.toJson(),
        {"authorization": "Bearer $token"},
      );
      if (res['success']) {
        Appointment appointment = Appointment.fromJson(res['result']);
        return appointment;
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  Future<Appointment?> updateStatus(int id, String status, String? responsibleId) async {
    try {
      var res = await _apiService.post(
          '/appointments/change-status/$id', {"status": status, "responsibleId": responsibleId}, null);

      if (res['success']) {
        return Appointment.fromJson(res['result']);
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  Future<List<User>> findResponsibles() async {
    try {
      var res = await _apiService.get('users?types=shepherd,shepherd_president', null);

      if(res['success']) {
        var list = res['results'] as List;
        List<User> responsibles = list.map((e) => User.fromJson(e)).toList();

        return responsibles;
      }

      return [];
    } catch(error) {
      return [];
    }
  }
  
  Future<List<Member>> findMembers() async {
    try {
      var res = await _apiService.get('members', null);

      if(res['success']) {
        var list = res['results'] as List;
        List<Member> responsibles = list.map((e) => Member.fromJson(e)).toList();

        return responsibles;
      }

      return [];
    } catch(error) {
      return [];
    }
  }
}
