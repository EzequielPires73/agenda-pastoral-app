import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class UsersAdminPage extends StatefulWidget {
  const UsersAdminPage({super.key});

  @override
  State<UsersAdminPage> createState() => _UsersAdminPageState();
}

class _UsersAdminPageState extends State<UsersAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorPalette.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          toolbarHeight: 80,
          title: const Text(
            'Usuários do sistema',
            style: TextStyle(color: Colors.white),
          ),
        ),
    );
  }
}