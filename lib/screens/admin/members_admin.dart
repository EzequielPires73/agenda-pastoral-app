import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/screens/admin/member_view.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/cards/card-member.dart';
import 'package:agenda_pastora_app/widgets/header_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MembersAdminPage extends StatefulWidget {
  const MembersAdminPage({super.key});

  @override
  State<MembersAdminPage> createState() => _MembersAdminPageState();
}

class _MembersAdminPageState extends State<MembersAdminPage> {
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
    return Scaffold(
      appBar: PreferredSize(child: HeaderPages(title: 'Membros'), preferredSize: Size(double.infinity, 80)),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
              child: ListView.separated(
                itemBuilder: (context, index) => CardMember(
                  member: members[index],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MemberViewPage(member: members[index]),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: members.length,
              ),
            ),
      floatingActionButton: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            color: ColorPalette.primary,
            borderRadius: BorderRadius.circular(4)),
        child: IconButton(
          icon: const Icon(FeatherIcons.plus),
          color: Colors.white,
          onPressed: () async {
            await Navigator.pushNamed(context, '/admin/create_member');
            await findMembers();
          },
        ),
      ),
    );
  }
}
