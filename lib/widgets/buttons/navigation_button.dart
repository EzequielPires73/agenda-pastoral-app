import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final Function() onChangeSelected;
  final IconData icon;
  final String title;

  const NavigationButton(
      {super.key,
      required this.title,
      required this.index,
      required this.selectedIndex,
      required this.onChangeSelected,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onChangeSelected,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color:
                selectedIndex == index ? ColorPalette.primary : ColorPalette.gray7,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
                color: selectedIndex == index
                    ? ColorPalette.primary
                    : ColorPalette.gray7,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}