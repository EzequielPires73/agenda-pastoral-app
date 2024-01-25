import 'package:agenda_pastora_app/models/appointment_category.dart';
import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/models/user.dart';

class Appointment {
  int? id;
  AppointmentCategory category;
  String date;
  String observation;
  String start;
  String end;
  String status;
  Member member;
  User? responsible;

  Appointment({
    required this.category,
    required this.date,
    required this.observation,
    required this.start,
    required this.end,
    required this.status,
    required this.member,
    this.responsible,
    this.id,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      category: AppointmentCategory.fromJson(json['category']),
      date: json['date'],
      observation: json['observation'],
      start: json['start'],
      end: json['end'],
      status: json['status'],
      member: Member.fromJson(json['member']),
      responsible: json['responsible'] != null ? User.fromJson(json['responsible']) : null
    );
  }
  
  toJson() {
    return {
      "category": category.toJson(),
      "date": date,
      "observation": observation,
      "start": start,
      "end": end,
      "status": status,
      "member": member.toJson(),
    };
  }
}
