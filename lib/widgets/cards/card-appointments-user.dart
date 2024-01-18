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
  const CardAppointmentsUser({super.key, required this.appointment});

  getColor() {
    Color color;
    switch (appointment.status) {
      case 'confirmado':
        color = ColorPalette.green;
        break;
      case 'pendente':
        color = ColorPalette.primary;
        break;
      case 'finalizado':
        color = ColorPalette.blue;
        break;
      case 'declinado':
        color = ColorPalette.red;
        break;

      default:
        color = ColorPalette.primary;
    }

    return color;
  }

  getBackground() {
    Color color;
    switch (appointment.status) {
      case 'confirmado':
        color = ColorPalette.greenLight;
        break;
      case 'pendente':
        color = ColorPalette.primaryLight;
        break;
      case 'finalizado':
        color = ColorPalette.blueLight;
        break;
      case 'declinado':
        color = ColorPalette.redLight;
        break;

      default:
        color = ColorPalette.primary;
    }

    return color;
  }

  getStatusText() {
    String title;
    switch (appointment.status) {
      case 'confirmado':
        title = 'Confirmado';
        break;
      case 'pendente':
        title = 'Pendente';
        break;
      case 'finalizado':
        title = 'Finalizado';
        break;
      case 'declinado':
        title = 'Declinado';
        break;

      default:
        title = 'Pendente';
    }

    return title;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
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
        padding: EdgeInsets.all(12),
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
                        color: getBackground(),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      getStatusText(),
                      style: TextStyle(
                          color: getColor(),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
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
                  const Text(
                    'Pr. Cornélio Neto ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.gray5),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    _formatDateTime(
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
                image: appointment.member.avatar?.isNotEmpty == true
                    ? appointment.member.avatar
                    : null,
                name: appointment.member.name,
                color: Colors.white,
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
                          onPressed: _showMyDialog, title: 'Cancelar'),
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
                    onPressed: () =>
                        Navigator.pushNamed(context, '/details_appointments'),
                    title: 'Detalhes'),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  String _formatDateTime(String date, String startTime, String endTime) {
    final DateFormat dateFormat = DateFormat('MM/dd');
    final DateFormat timeFormat = DateFormat('HH:mm');

    DateTime startDate = DateTime.parse(date);
    String formattedDate = dateFormat.format(startDate);
    String formattedStartTime =
        timeFormat.format(DateTime.parse('2000-01-01 $startTime'));
    String formattedEndTime =
        timeFormat.format(DateTime.parse('2000-01-01 $endTime'));

    return '$formattedDate - $formattedStartTime - $formattedEndTime';
  }
}
