import 'package:agenda_pastora_app/controllers/auth_controller.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late final AuthController controller;

  void authListene() {
    var userState = controller.userState;
    var member = controller.member;
    var user = controller.user;
    if (userState == UserState.logged && (member != null || user != null)) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/admin/home');
      }
      if (member != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else if (userState == UserState.loggedOut) {
      Navigator.pushReplacementNamed(context, '/choose_role');
    }
  }

  @override
  void initState() {
    super.initState();
    controller = context.read<AuthController>();
    controller.loadUser();
    controller.addListener(authListene);
  }

  @override
  void dispose() {
    controller.removeListener(authListene);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        color: ColorPalette.primary,
      ),
    );
  }
}
