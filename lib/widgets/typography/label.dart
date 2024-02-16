import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String text;
  const Label({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ColorPalette.gray3),
    );
  }
}
