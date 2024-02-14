import 'package:agenda_pastora_app/controllers/auth_controller.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

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
        child: Column(children: [
          const ProfileItem(
              icon: FeatherIcons.edit,
              path: '/update_profile',
              title: 'Editar Perfil'),
          const SizedBox(
            height: 24,
          ),
          const ProfileItem(
              icon: FeatherIcons.info, path: '/about', title: 'Sobre o app'),
          const SizedBox(
            height: 24,
          ),
          const ProfileItem(
              icon: FeatherIcons.shield,
              path: '/privacy_policy',
              title: 'Politica de privacidade'),
          const SizedBox(
            height: 24,
          ),
          Consumer<AuthController>(
            builder: (context, value, child) => ProfileItem(
                icon: FeatherIcons.logOut,
                path: '/choose_role',
                title: 'Sair',
                onAction: () async {
                  Navigator.pushReplacementNamed(context, '/choose_role');
                  await value.logout();
                }),
          )
        ]),
      ),
    ])));
  }
}

class ProfileItem extends StatelessWidget {
  final String path;
  final String title;
  final IconData icon;
  final Function()? onAction;

  const ProfileItem(
      {super.key,
      required this.icon,
      required this.path,
      required this.title,
      this.onAction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAction ?? () => Navigator.pushNamed(context, path),
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
