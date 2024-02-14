import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/widgets/cards/card-member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class SelectResponsible extends StatefulWidget {
  final Function(UserAbstract user) onSelect;
  const SelectResponsible({super.key, required this.onSelect});

  @override
  State<SelectResponsible> createState() => _SelectResponsibleState();
}

class _SelectResponsibleState extends State<SelectResponsible> {
  final AppointmentRepository _repository = AppointmentRepository();
  List<User> responsible = [];

  Future<void> findResponsible() async {
    var resResponsible = await _repository.findResponsibles();
    setState(() {
      responsible = resResponsible;
    });
  }

  @override
  void initState() {
    super.initState();
    findResponsible();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 72,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(FeatherIcons.x),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(FeatherIcons.search)),
            IconButton(
              icon: const Icon(FeatherIcons.plus),
              onPressed: () async {
                  await Navigator.pushNamed(context, '/admin/create_responsible');
                  await findResponsible();
              }
            ),
          ],
          title: const Text(
            'Selecione o responsável',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView.separated(
            itemBuilder: (context, index) => CardMember(
              member: responsible[index],
              onTap: () {
                widget.onSelect(responsible[index]);
                Navigator.pop(context);
              },
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
            itemCount: responsible.length,
          ),
        ),
      ),
    );
  }
}
