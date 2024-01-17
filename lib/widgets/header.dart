import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 25, right: 25, top: 48, bottom: 32),
      color: ColorPalette.primary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Olá, Ezequiel Pires',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  children: [
                    TextSpan(text: 'Bem-vindo ao '),
                    TextSpan(
                      text: 'Agenda Pastoral',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Avatar(
            image: 'https://avatars.githubusercontent.com/u/145378534?v=4',
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
