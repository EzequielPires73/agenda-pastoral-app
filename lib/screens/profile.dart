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
          horizontal: 25,
          vertical: 32,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(children: [
          ProfileItem(icon: FeatherIcons.edit, path: '/edit_user', title: 'Editar Perfil'),
          SizedBox(height: 24,),
          ProfileItem(icon: FeatherIcons.info, path: '/about', title: 'Sobre o app'),
          SizedBox(height: 24,),
          ProfileItem(icon: FeatherIcons.shield, path: '/privacy_policy', title: 'Politica de privacidade'),
          SizedBox(height: 24,),
          ProfileItem(icon: FeatherIcons.logOut, path: '/choose_role', title: 'Sair'),
        ]),
      ),
    ])));
  }
}

class ProfileItem extends StatelessWidget {
  final String path;
  final String title;
  final IconData icon;
  const ProfileItem(
      {super.key, required this.icon, required this.path, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushReplacementNamed(context, path),
      child: Row(
        children: [
          Icon(icon, color: ColorPalette.gray3),
          const SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorPalette.gray3),
          ),
        ],
      ),
    );
  }
}
