import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class ButtonSecondary extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool? isLoading;
  final Color? color;
  final Color? background;

  const ButtonSecondary({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLoading,
    this.color,
    this.background
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Opacity(
        opacity: isLoading == true ? 0.5 : 1,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => background ?? ColorPalette.primaryLight),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
          ),
          onPressed: isLoading == true ? null : onPressed,
          child: isLoading == true
              ? const CircularProgressIndicator()
              : Text(
                  title,
                  style: TextStyle(
                      color: color ?? ColorPalette.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
        ),
      ),
    );
  }
}
