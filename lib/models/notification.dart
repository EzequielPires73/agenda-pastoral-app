import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/models/user.dart';

class AppointmentNotification {
  int? id;
  String title;
  String body;
  String route;
  String destination;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  Member? member;
  Appointment? appointment;

  AppointmentNotification(
      {required this.body,
      required this.title,
      required this.route,
      required this.destination,
      this.id,
      this.createdAt,
      this.member,
      this.updatedAt,
      this.user,
      this.appointment
      });

  factory AppointmentNotification.fromJson(Map<String, dynamic> json) {
    return AppointmentNotification(
      body: json['body'],
      title: json['title'],
      route: json['route'],
      destination: json['destination'],
      member: json['member'] != null ? Member.fromJson(json['member']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      id: json['id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      appointment: json['appointment'] != null ? Appointment.fromJson(json['appointment']) : null
    );
  }
}
