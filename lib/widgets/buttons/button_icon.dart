import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final Color? background;
  final Color? color;
  final IconData icon;
  final Function() onPressed;

  const ButtonIcon({super.key, required this.onPressed, required this.icon, this.background, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            color: background ?? ColorPalette.primary,
            borderRadius: BorderRadius.circular(4)),
        child: IconButton(
          icon: Icon(icon),
          color: color ?? Colors.white,
          onPressed: onPressed,
        ),
      );
  }
}