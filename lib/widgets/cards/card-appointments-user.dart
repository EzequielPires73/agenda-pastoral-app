import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/helpers/status.dart';
import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_confirm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum AppointmentStatus {
  pendente,
  confirmado,
  finalizado,
  declinado,
}

class CardAppointmentsUser extends StatelessWidget {
  final Appointment appointment;
  final Function() onPress;
  const CardAppointmentsUser(
      {super.key, required this.appointment, required this.onPress});

  @override
  Widget build(BuildContext context) {
    Future<void> showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text(
              'Cancelar Agendamento',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Deseja mesmo cancelar o agendamento?'),
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
                        onPressed: () => Navigator.of(context).pop(),
                        title: 'Confirmar'),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    return Card(
      elevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffDDDDDD), width: 1),
            borderRadius: BorderRadius.circular(8)),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: getBackground(appointment.status),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      getStatusText(appointment.status),
                      style: TextStyle(
                        color: getColor(appointment.status),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    appointment.category.name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.gray3),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    appointment.responsible?.name ?? '',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.gray5),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    formatDateTime(
                        appointment.date, appointment.start, appointment.end),
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.gray3),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              Avatar(
                image: appointment.responsible?.avatar?.isNotEmpty == true
                    ? appointment.responsible?.avatar
                    : null,
                name: appointment.responsible?.name ?? '',
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              appointment.status == 'confirmado' ||
                      appointment.status == 'pendente'
                  ? Expanded(
                      child: ButtonCancel(
                          onPressed: showMyDialog, title: 'Cancelar'),
                    )
                  : Container(),
              SizedBox(
                width: appointment.status == 'confirmado' ||
                        appointment.status == 'pendente'
                    ? 8
                    : 0,
              ),
              Expanded(
                child: ButtonConfirm(
                    onPressed: () async {
                      await Navigator.pushNamed(
                          context, '/details_appointments',
                          arguments: {"id": appointment.id});
                      onPress();
                    },
                    title: 'Detalhes'),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
