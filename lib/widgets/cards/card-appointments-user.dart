import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:flutter/material.dart';

enum AppointmentStatus {
  pendente,
  confirmado,
  finalizado,
  declinado,
}

class CardAppointmentsUser extends StatelessWidget {
  final AppointmentStatus status;
  const CardAppointmentsUser({super.key, required this.status});

  getColor() {
    Color color;
    switch (status) {
      case AppointmentStatus.confirmado:
        color = ColorPalette.green;
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
    return Card(
      elevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.only(bottom: 16), 
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffDDDDDD), width: 1),
          borderRadius: BorderRadius.circular(8)
        ),
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
                    'Pr. Cornélio Neto ',
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
                  const InkWell(
                    child: Text(
                      'Detalhes',
                      style: TextStyle(
                          color: ColorPalette.primary,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(64),
                  border: Border.all(color: ColorPalette.gray3, width: 3),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(64),
                  child: Image.network(
                      'https://adcatalao.nyc3.digitaloceanspaces.com/wp-content/uploads/2018/04/FOTO-PASTORES-DO-CAMPO-AD-CATAL%C3%83O.jpg',
                      fit: BoxFit.cover),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          status == AppointmentStatus.confirmado || status == AppointmentStatus.pendente ? ButtonCancel(onPressed: () {}, title: 'Cancelar') : Container()
        ]),
      ),
    );
  }
}