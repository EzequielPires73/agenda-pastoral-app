import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/widgets/cards/card-member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class SelectMember extends StatefulWidget {
  final Function(Member member) onSelect;
  const SelectMember({super.key, required this.onSelect});

  @override
  State<SelectMember> createState() => _SelectMemberState();
}

class _SelectMemberState extends State<SelectMember> {
  final AppointmentRepository _repository = AppointmentRepository();
  List<Member> members = [];
  bool loading = true;

  Future<void> findMembers() async {
    setState(() {
      loading = true;
    });
    var resMembers = await _repository.findMembers();
    setState(() {
      members = resMembers;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    findMembers();
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
                   await Navigator.pushNamed(context, '/admin/create_member');
                   await findMembers();
              }
            ),
          ],
          title: const Text(
            'Selecione o membro',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView.separated(
            itemBuilder: (context, index) => CardMember(
              member: members[index],
              onTap: () {
                widget.onSelect(members[index]);
                Navigator.pop(context);
              },
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
            itemCount: members.length,
          ),
        ),
      ),
    );
  }
}
