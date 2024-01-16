import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      const Header(),
      Container(
        width: double.infinity,
        transform: Matrix4.translationValues(0, -16, 0),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 25,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(children: [
          InkWell(
            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
            child: const Row(
              children: [
                Icon(FeatherIcons.logOut, color: ColorPalette.gray3),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'Sair',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.gray3),
                ),
              ],
            ),
          ),
        ]),
      ),
    ])));
  }
}
