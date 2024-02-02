import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class ButtonCancel extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool? isLoading;

  const ButtonCancel(
      {super.key,
      required this.onPressed,
      required this.title,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Opacity(
        opacity: isLoading == true ? 0.5 : 1,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => ColorPalette.input),
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
                  style: const TextStyle(
                      color: ColorPalette.gray3,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
        ),
      ),
    );
  }
}
