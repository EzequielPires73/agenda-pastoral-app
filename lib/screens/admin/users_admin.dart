import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/screens/admin/user_view.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_icon.dart';
import 'package:agenda_pastora_app/widgets/cards/card-member.dart';
import 'package:agenda_pastora_app/widgets/header_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class UsersAdminPage extends StatefulWidget {
  const UsersAdminPage({super.key});

  @override
  State<UsersAdminPage> createState() => _UsersAdminPageState();
}

class _UsersAdminPageState extends State<UsersAdminPage> {
  final AppointmentRepository _repository = AppointmentRepository();
  List<User> responsible = [];
  bool loading = true;

  Future<void> findResponsible() async {
    setState(() {
      loading = true;
    });

    var resResponsible = await _repository.findResponsibles();
    setState(() {
      responsible = resResponsible;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    findResponsible();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: HeaderPages(
          title: 'Usuários do sistema',
          actions: [
            ButtonIcon(
                onPressed: () async {
                  await Navigator.pushNamed(
                      context, '/admin/create_responsible');
                  await findResponsible();
                },
                icon: FeatherIcons.plus)
          ],
        ),
        preferredSize: Size(double.infinity, 80),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
              child: ListView.separated(
                itemBuilder: (context, index) => CardMember(
                  member: responsible[index],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserViewPage(user: responsible[index]),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: responsible.length,
              ),
            ),
    );
  }
}
