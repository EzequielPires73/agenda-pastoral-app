import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class Span extends StatelessWidget {
  final String text;
  const Span({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: ColorPalette.gray7),
    );
  }
}
