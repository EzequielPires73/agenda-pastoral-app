import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class AlertMessage extends StatelessWidget {
  final Color? color;
  final Color? backgorund;
  final String message;
  const AlertMessage({super.key, required this.message, this.color, this.backgorund});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
          color: backgorund ?? ColorPalette.redLight, borderRadius: BorderRadius.circular(6)),
      child: Text(
        message,
        style: TextStyle(
            color: color ?? ColorPalette.red, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}
