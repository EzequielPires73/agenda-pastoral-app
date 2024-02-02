import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:agenda_pastora_app/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class CardAvailableTime extends StatelessWidget {
  final Time time;
  const CardAvailableTime({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    Future<void> showMyDialogCancel() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CustomAlertDialog(
              title: 'Cancelar Horário',
              subtitle: 'Deseja mesmo cancelar o horário?',
              onChange: () {});
        },
      );
    }
    
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffDDDDDD), width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Inicio'),
                Text(
                  formatTime(time.start),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Final'),
                Text(
                  formatTime(time.end),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
            Expanded(
              child: Container(),
            ),
            ButtonCancel(onPressed: showMyDialogCancel, title: 'Remover')
          ],
        ),
      ),
    );
  }
}
