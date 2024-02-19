import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class HeaderPages extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  const HeaderPages({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.primary,
      iconTheme: const IconThemeData(color: Colors.white),
      toolbarHeight: 80,
      actions: actions,
      title: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }
}
