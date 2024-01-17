import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_secondary.dart';
import 'package:flutter/material.dart';

class ChooseRolePage extends StatefulWidget {
  const ChooseRolePage({super.key});

  @override
  State<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo_v.png',
              width: 134,
            ),
            const SizedBox(
              height: 48,
            ),
            ButtonPrimary(onPressed: () => Navigator.pushNamed(context, '/login'), title: 'Area do membro'),
            const SizedBox(
              height: 24,
            ),
            ButtonSecondary(onPressed: () => Navigator.pushNamed(context, '/admin/login'), title: 'Area do pastor')
          ],
        ),
      ),
    );
  }
}
