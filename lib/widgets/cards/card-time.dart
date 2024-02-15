import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CardTime extends StatelessWidget {
  final Time time;
  final bool active;
  final Function() onAction;
  const CardTime(
      {super.key,
      required this.time,
      required this.active,
      required this.onAction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAction,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: active ? ColorPalette.primaryLight : ColorPalette.input,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Início',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: active ? ColorPalette.primary : ColorPalette.gray5,
                  ),
                ),
                Text(
                  time.start,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: active ? ColorPalette.primary : ColorPalette.gray5,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Final',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: active ? ColorPalette.primary : ColorPalette.gray5,
                  ),
                ),
                Text(
                  time.end,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: active ? ColorPalette.primary : ColorPalette.gray5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
