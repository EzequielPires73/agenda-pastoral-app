import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CategoiresAdminPage extends StatefulWidget {
  const CategoiresAdminPage({super.key});

  @override
  State<CategoiresAdminPage> createState() => _CategoiresAdminPageState();
}

class _CategoiresAdminPageState extends State<CategoiresAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorPalette.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          toolbarHeight: 80,
          title: const Text(
            'Categorias de agendamento',
            style: TextStyle(color: Colors.white),
          ),
        ),
    );
  }
}