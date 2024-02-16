import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class H1 extends StatelessWidget {
  final String text;
  const H1({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: ColorPalette.gray3),
    );
  }
}
