class AppointmentCategory {
  int id;
  String name;
  int duration;
  String? slug;

  AppointmentCategory(
      {required this.id,
      required this.name,
      required this.duration,
      this.slug});

  factory AppointmentCategory.fromJson(Map<String, dynamic> json) {
    return AppointmentCategory(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
      slug: json['slug']
    );
  }
}
