class AppointmentCategory {
  int id;
  String name;
  int duration;
  String? slug;

  AppointmentCategory({required this.id, required this.name, required this.duration, this.slug});
}