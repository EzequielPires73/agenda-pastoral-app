import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String image;
  final Color? color;
  const Avatar({super.key, required this.image, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(64),
        border: Border.all(color: color ?? ColorPalette.gray3, width: 3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(64),
        child: Image.network(image, fit: BoxFit.cover),
      ),
    );
  }
}
