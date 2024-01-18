import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/cards/card-appointments-user.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppointmentRepository _repository = AppointmentRepository();
  final active = 1;
  List<Appointment> appointments = [];
  
  setResults(int index) {
    /* if(index == 0) {
      setState(() {
        agendamentos = [AppointmentStatus.confirmado, AppointmentStatus.pendente, AppointmentStatus.pendente, AppointmentStatus.pendente, AppointmentStatus.confirmado, AppointmentStatus.pendente];
      });
    } else {
      setState(() {
        agendamentos = [AppointmentStatus.finalizado, AppointmentStatus.declinado,];
      });
    } */
  }

  Future<void> findAppointments() async {
    var results = await _repository.findAppointments();
    setState(() {
      appointments = results;
    });
  }

  @override
  void initState() {
    findAppointments();
    super.initState();
  }

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
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      onTap: (value) => setResults(value),
                      labelColor: ColorPalette.primary,
                      unselectedLabelColor: Colors.black38,
                      indicatorColor: ColorPalette.primary,
                      tabs: const [
                        Tab(
                          text: 'Agendamentos',
                        ),
                        Tab(
                          text: 'Histórico',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    ...appointments.map((e) => CardAppointmentsUser(appointment: e,)).toList(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            color: ColorPalette.primary,
            borderRadius: BorderRadius.circular(4)),
        child: IconButton(
          icon: Icon(FeatherIcons.plus),
          color: Colors.white,
          onPressed: () => Navigator.pushNamed(context, '/create_appointments'),
        ),
      ),
    );
  }
}