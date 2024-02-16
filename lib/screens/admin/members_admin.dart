import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class MembersAdminPage extends StatefulWidget {
  const MembersAdminPage({super.key});

  @override
  State<MembersAdminPage> createState() => _MembersAdminPageState();
}

class _MembersAdminPageState extends State<MembersAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorPalette.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          toolbarHeight: 80,
          title: const Text(
            'Membros',
            style: TextStyle(color: Colors.white),
          ),
        ),
    );
  }
}