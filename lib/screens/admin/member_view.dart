import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_secondary.dart';
import 'package:agenda_pastora_app/widgets/header_pages.dart';
import 'package:agenda_pastora_app/widgets/typography/h1.dart';
import 'package:agenda_pastora_app/widgets/typography/label.dart';
import 'package:agenda_pastora_app/widgets/typography/span.dart';
import 'package:flutter/material.dart';

class MemberViewPage extends StatefulWidget {
  final Member member;
  const MemberViewPage({super.key, required this.member});

  @override
  State<MemberViewPage> createState() => _MemberViewPageState();
}

class _MemberViewPageState extends State<MemberViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: HeaderPages(title: 'Membros'), preferredSize: Size(double.infinity, 80)),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Avatar(image: widget.member.avatar, name: widget.member.name),
              const SizedBox(
                height: 8,
              ),
              H1(text: widget.member.name),
              const SizedBox(
                height: 8,
              ),
              Label(text: 'Tel.: ${widget.member.phone}'),
              const SizedBox(
                height: 8,
              ),
              Label(text: 'CPF: ${widget.member.cpf}'),
              const SizedBox(
                height: 8,
              ),
              Span(text: widget.member.email),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(child: ButtonPrimary(onPressed: () {}, title: 'Ligar')),
                  const SizedBox(width: 16,),
                  Expanded(child: ButtonSecondary(onPressed: () {}, title: 'Whatsapp')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
