import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class HeaderPages extends StatelessWidget {
  final String title;
  const HeaderPages({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.primary,
      iconTheme: const IconThemeData(color: Colors.white),
      toolbarHeight: 80,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
