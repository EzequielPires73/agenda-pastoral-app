abstract class UserAbstract {
  String id;
  String name;
  String email;
  String phone;
  String? password;
  String? avatar;
  String? notificationToken;

  UserAbstract(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      this.password,
      this.avatar,
      this.notificationToken});
}

class User extends UserAbstract {
  String? type;
  List? appointments;

  User({
    required String id,
    required String name,
    required String email,
    required String phone,
    String? password,
    String? avatar,
    String? notificationToken,
    this.type,
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      appointments: json['appointments'] ?? [],
      type: json['type'],
      notificationToken: json['notificationToken'],
    );
  }
}
