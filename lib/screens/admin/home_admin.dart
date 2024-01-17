import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/cards/card-appointments-admin.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  List<AppointmentStatus> confirmados = [
    AppointmentStatus.lembrete,
    AppointmentStatus.lembrete,
    AppointmentStatus.lembrete,
    AppointmentStatus.lembrete,
    AppointmentStatus.lembrete,
  ];
  List<AppointmentStatus> pendentes = [
    AppointmentStatus.pendente,
    AppointmentStatus.pendente,
    AppointmentStatus.pendente,
    AppointmentStatus.pendente
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const Header(),
          Container(
            width: double.infinity,
            transform: Matrix4.translationValues(0, -16, 0),
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 32,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 16),
                child: Text(
                  'Lembretes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.gray3,
                  ),
                ),
              ),
              SizedBox(
                height: 222,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => index == 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 25, right: 16),
                          child: SizedBox(
                            width: 348,
                            child: CardAppointmentsAdmin(
                                status: confirmados[index]),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: SizedBox(
                            width: 360,
                            child: CardAppointmentsAdmin(
                                status: confirmados[index]),
                          ),
                        ),
                  itemCount: confirmados.length,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 16),
                child: Text(
                  'Pendentes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.gray3,
                  ),
                ),
              ),
              SizedBox(
                height: 222,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => index == 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 25, right: 16),
                          child: SizedBox(
                            width: 348,
                            child: CardAppointmentsAdmin(
                                status: pendentes[index]),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: SizedBox(
                            width: 360,
                            child: CardAppointmentsAdmin(
                                status: pendentes[index]),
                          ),
                        ),
                  itemCount: pendentes.length,
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
