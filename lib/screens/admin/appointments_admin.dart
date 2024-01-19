import 'package:agenda_pastora_app/widgets/calendar.dart';
import 'package:agenda_pastora_app/widgets/cards/card-appointments-admin.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';

class AppointmentsAdminPage extends StatefulWidget {
  const AppointmentsAdminPage({super.key});

  @override
  State<AppointmentsAdminPage> createState() => _AppointmentsAdminPageState();
}

class _AppointmentsAdminPageState extends State<AppointmentsAdminPage> {
  List<AppointmentStatus> agendamentos = [
    AppointmentStatus.confirmado,
    AppointmentStatus.pendente,
    AppointmentStatus.pendente,
    AppointmentStatus.pendente,
    AppointmentStatus.confirmado,
    AppointmentStatus.pendente
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Header(),
                Container(
                  width: double.infinity,
                  transform: Matrix4.translationValues(0, -16, 0),
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const CustomCalendar(availableTimes: []),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            sliver: SliverList.separated(
              itemCount: agendamentos.length,
              itemBuilder: (context, index) =>
                  CardAppointmentsAdmin(status: agendamentos[index]),
              separatorBuilder: (context, index) => const SizedBox(
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
