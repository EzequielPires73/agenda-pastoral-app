import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_confirm.dart';
import 'package:flutter/material.dart';

enum AppointmentStatus {
  pendente,
  confirmado,
  finalizado,
  declinado,
  lembrete,
}

class CardAppointmentsAdmin extends StatelessWidget {
  final AppointmentStatus status;
  const CardAppointmentsAdmin({super.key, required this.status});

  getColor() {
    Color color;
    switch (status) {
      case AppointmentStatus.confirmado:
        color = ColorPalette.green;
        break;
      case AppointmentStatus.lembrete:
        color = ColorPalette.gray3;
        break;
      case AppointmentStatus.pendente:
        color = ColorPalette.primary;
        break;
      case AppointmentStatus.finalizado:
        color = ColorPalette.blue;
        break;
      case AppointmentStatus.declinado:
        color = ColorPalette.red;
        break;

      default:
        color = ColorPalette.primary;
    }

    return color;
  }

  getBackground() {
    Color color;
    switch (status) {
      case AppointmentStatus.confirmado:
        color = ColorPalette.greenLight;
        break;
      case AppointmentStatus.pendente:
        color = ColorPalette.primaryLight;
        break;
      case AppointmentStatus.lembrete:
        color = ColorPalette.input;
        break;
      case AppointmentStatus.finalizado:
        color = ColorPalette.blueLight;
        break;
      case AppointmentStatus.declinado:
        color = ColorPalette.redLight;
        break;

      default:
        color = ColorPalette.primary;
    }

    return color;
  }

  getStatusText() {
    String title;
    switch (status) {
      case AppointmentStatus.confirmado:
        title = 'Confirmado';
        break;
      case AppointmentStatus.pendente:
        title = 'Pendente';
        break;
      case AppointmentStatus.lembrete:
        title = 'Lembrete';
        break;
      case AppointmentStatus.finalizado:
        title = 'Finalizado';
        break;
      case AppointmentStatus.declinado:
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
                  const Text(
                    'Aconselhamento Pastoral',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.gray3),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Ezequiel Pires',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.gray5),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    '12/01 - 09:00',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.gray3),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              const Avatar(
                image: 'https://avatars.githubusercontent.com/u/145378534?v=4',
                name: 'Ezequiel Pires',
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              status == AppointmentStatus.confirmado ||
                      status == AppointmentStatus.pendente
                  ? Expanded(
                      child: ButtonCancel(
                          onPressed: _showMyDialog, title: 'Cancelar'),
                    )
                  : Container(),
              SizedBox(
                width: status == AppointmentStatus.confirmado ||
                        status == AppointmentStatus.pendente
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
}
