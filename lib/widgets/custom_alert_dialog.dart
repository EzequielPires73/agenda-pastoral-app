import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_confirm.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function() onChange;

  const CustomAlertDialog(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  8), // Ajuste o valor conforme necessário
            ),
          ),
        ),
        child: AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(subtitle),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: ButtonCancel(
                      onPressed: () => Navigator.of(context).pop(),
                      title: 'Cancelar'),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: ButtonConfirm(
                      onPressed: () {
                        onChange();
                        Navigator.of(context).pop();
                      },
                      title: 'Confirmar'),
                ),
              ],
            ),
          ],
        ));
  }
}
