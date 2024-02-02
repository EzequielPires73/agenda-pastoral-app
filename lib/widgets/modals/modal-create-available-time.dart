import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_confirm.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:flutter/material.dart';

class ModalCreateAvailableTime extends StatefulWidget {
  final Function(TimeOfDay start, TimeOfDay end) onSubmit;
  const ModalCreateAvailableTime({super.key, required this.onSubmit});

  @override
  State<ModalCreateAvailableTime> createState() =>
      _ModalCreateAvailableTimeState();
}

class _ModalCreateAvailableTimeState extends State<ModalCreateAvailableTime> {
  TimeOfDay? start;
  TimeOfDay? end;

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
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: const Text(
            'Cadastrar Tempo Livre',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Início:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(start != null
                  ? '${start!.hour.toString().padLeft(2, '0')}:${start!.minute.toString().padLeft(2, '0')}'
                  : 'Selecione um horário'),
              const SizedBox(
                height: 12,
              ),
              ButtonPrimary(
                onPressed: () async {
                  var startTime = await showTimePicker(
                    initialTime: const TimeOfDay(hour: 8, minute: 0),
                    context: context,
                  );
                  setState(() {
                    start = startTime;
                  });
                },
                title: 'Selecionar',
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Final:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(end != null
                  ? '${end!.hour.toString().padLeft(2, '0')}:${end!.minute.toString().padLeft(2, '0')}'
                  : 'Selecione um horário'),
              const SizedBox(
                height: 12,
              ),
              ButtonPrimary(
                onPressed: () async {
                  var endTime = await showTimePicker(
                    initialTime: const TimeOfDay(hour: 12, minute: 0),
                    context: context,
                  );

                  setState(() {
                    end = endTime;
                  });
                },
                title: 'Selecionar',
              ),
            ],
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
                        if (start != null && end != null) {
                          widget.onSubmit(start!, end!);
                          Navigator.of(context).pop();
                        }
                      },
                      title: 'Confirmar'),
                ),
              ],
            ),
          ],
        ));
  }
}
