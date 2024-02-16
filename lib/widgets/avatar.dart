import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? image;
  final String name;
  final Color? color;
  const Avatar(
      {super.key, required this.image, this.color, required this.name});

  String abbreviateName(String fullName) {
    List<String> words = fullName.split(' ').where((element) => element.toLowerCase() != 'de' && element.toLowerCase() != 'e').toList();
    String abbreviation = '';
    int i = 1;

    for (String word in words) {
      if (word.isNotEmpty && i <= 2) {
        abbreviation += word[0];
      }
      i++;
    }

    return abbreviation.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: ColorPalette.gray3,
        borderRadius: BorderRadius.circular(64),
        border: Border.all(color: color ?? ColorPalette.gray3, width: 3),
      ),
      child: image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(64),
              child: Image.network(image!, fit: BoxFit.cover),
            )
          : Container(
              alignment: Alignment.center,
              child: Text(
                abbreviateName(name),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
    );
  }
}
