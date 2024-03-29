import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_secondary.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:agenda_pastora_app/widgets/header_pages.dart';
import 'package:agenda_pastora_app/widgets/typography/h1.dart';
import 'package:agenda_pastora_app/widgets/typography/label.dart';
import 'package:agenda_pastora_app/widgets/typography/span.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserViewPage extends StatefulWidget {
  final User user;
  const UserViewPage({super.key, required this.user});

  @override
  State<UserViewPage> createState() => _UserViewPageState();
}

class _UserViewPageState extends State<UserViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: HeaderPages(title: 'Usuário do sistema'), preferredSize: Size(double.infinity, 80)),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Avatar(image: widget.user.avatar, name: widget.user.name),
              const SizedBox(
                height: 8,
              ),
              H1(text: widget.user.name),
              const SizedBox(
                height: 8,
              ),
              Label(text: 'Tel.: ${widget.user.phone}'),
              const SizedBox(
                height: 8,
              ),
              Span(text: widget.user.email),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(child: ButtonPrimary(onPressed: () => _launchPhone(widget.user.phone), title: 'Ligar')),
                  const SizedBox(width: 16,),
                  Expanded(child: ButtonSecondary(onPressed: () => _openWhatsApp(widget.user.phone), title: 'Whatsapp')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _launchPhone(String phone) async {
    final phoneNumber = Uri.parse('tel:${phone}');
    print(phoneNumber);
    if (await canLaunchUrl(phoneNumber)) {
      await launchUrl(phoneNumber);
    } else {
      throw 'Não foi possível abrir o número de telefone.';
    }
  }

  void _openWhatsApp(String phoneNumber) async {
    final url = Uri.parse("https://api.whatsapp.com/send?phone=$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
