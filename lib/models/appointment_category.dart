class AppointmentCategory {
  int? id;
  String name;
  int duration;
  String? slug;

  AppointmentCategory({
    required this.name,
    required this.duration,
    this.id,
    this.slug,
  });

  factory AppointmentCategory.fromJson(Map<String, dynamic> json) {
    return AppointmentCategory(
        id: json['id'],
        name: json['name'],
        duration: json['duration'],
        slug: json['slug']);
  }

  toJson() {
    if (id != null) {
      return {"id": id, "name": name, "duration": duration, "slug": slug};
    } else {
      return {"name": name, "duration": duration,};
    }
  }
}
