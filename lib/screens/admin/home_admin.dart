import 'package:agenda_pastora_app/controllers/appointment_controller.dart';
import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/cards/card-appointments-admin.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  final AppointmentRepository _repository = AppointmentRepository();
  var active = 0;
  bool loading = true;

  List<Appointment> appointments = [];

  setActive(int index) {
    setState(() {
      active = index;
    });
  }

  Future<void> findAppointments() async {
    setState(() {
      loading = true;
    });
    final shared = await SharedPreferences.getInstance();
    final accessToken = shared.getString('member.access_token');

    var resultsAppointments =
        await _repository.findAll('pendente,confirmado', accessToken, null);

    setState(() {
      appointments = resultsAppointments;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    findAppointments();
  }

  Future<void> _refresh() async {
    findAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(),
        Container(
          width: double.infinity,
          transform: Matrix4.translationValues(0, -16, 0),
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 8,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
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
                          child: loading == true
                              ? const CardAppointmentsAdminSk()
                              : CardAppointmentsAdmin(
                                  onPress: _refresh,
                                  appointment: appointments[index],
                                ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SizedBox(
                          width: 360,
                          child: loading == true
                              ? const CardAppointmentsAdminSk()
                              : CardAppointmentsAdmin(
                                  onPress: _refresh,
                                  appointment: appointments[index],
                                ),
                        ),
                      ),
                itemCount: loading != true ? appointments.length : 4,
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
                          child: loading == true
                              ? const CardAppointmentsAdminSk()
                              : CardAppointmentsAdmin(
                                  onPress: _refresh,
                                  appointment: appointments[index],
                                ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SizedBox(
                          width: 360,
                          child: loading == true
                              ? const CardAppointmentsAdminSk()
                              : CardAppointmentsAdmin(
                                  onPress: _refresh,
                                  appointment: appointments[index],
                                ),
                        ),
                      ),
                itemCount: loading != true ? appointments.length : 4,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    )));
  }
}
