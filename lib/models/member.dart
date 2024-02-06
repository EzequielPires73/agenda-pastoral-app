import 'package:agenda_pastora_app/models/user.dart';

class Member extends UserAbstract {
  String? cpf;
  bool? deficiency;
  List? appointments;

  Member({
    required String name,
    required String email,
    required String phone,
    String? password,
    String? avatar,
    String? notificationToken,
    String? id,
    this.cpf,
    this.deficiency,
    this.appointments,
  }) : super(
          id: id,
          name: name,
          email: email,
          phone: phone,
          password: password,
          avatar: avatar,
          notificationToken: notificationToken,
        );

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      cpf: json['cpf'],
      deficiency: json['deficiency'] ?? false,
      notificationToken: json['notificationToken'],
    );
  }

  toJson() {
    if (id != null) {
      return {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "cpf": cpf,
      };
    } else {
       return {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "cpf": cpf,
      };
    }
  }
}
