import 'package:agenda_pastora_app/models/appointment_category.dart';

class AppointmentCategoryRepository {
  final categories = [
    AppointmentCategory(id: 1, name: 'Aconselhamento Pastoral', duration: 60),
    AppointmentCategory(id: 2, name: 'Orientação Espiritual', duration: 60),
    AppointmentCategory(id: 3, name: 'Celebrações e Ritos Religiosos', duration: 60),
    AppointmentCategory(id: 4, name: 'Dúvidas Doutrinárias', duration: 60),
    AppointmentCategory(id: 5, name: 'Eventos e Atividades da Igreja', duration: 60),
    AppointmentCategory(id: 6, name: 'Conselhos Familiares', duration: 60),
    AppointmentCategory(id: 7, name: 'Assistência Social', duration: 60),
    AppointmentCategory(id: 8, name: 'Treinamento e Discipulado', duration: 60),
  ];
}