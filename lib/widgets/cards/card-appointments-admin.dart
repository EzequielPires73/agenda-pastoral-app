import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/helpers/status.dart';
import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_confirm.dart';
import 'package:agenda_pastora_app/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum AppointmentStatus {
  pendente,
  confirmado,
  finalizado,
  declinado,
  lembrete,
}

class CardAppointmentsAdmin extends StatelessWidget {
  final Appointment appointment;
  final Function() onPress;
  const CardAppointmentsAdmin(
      {super.key, required this.appointment, required this.onPress});

  @override
  Widget build(BuildContext context) {
    Future<void> showMyDialogCancel() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CustomAlertDialog(
              title: 'Cancelar Agendamento',
              subtitle: 'Deseja mesmo cancelar o agendamento?',
              onChange: () {});
        },
      );
    }

    return Card(
      elevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.white,
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
                  Text(
                    appointment.member.name,
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
                image: appointment.member.avatar,
                name: appointment.member.name,
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
                          onPressed: showMyDialogCancel, title: 'Cancelar'),
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

class CardAppointmentsAdminSk extends StatelessWidget {
  const CardAppointmentsAdminSk({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffDDDDDD), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      height: 32,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      height: 32,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      height: 24,
                      width: 148,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      height: 24,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 64,
                  width: 64,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(64),
                  ),
                ),
              ),
            ],
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
