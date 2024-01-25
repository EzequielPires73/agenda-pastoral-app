import 'package:agenda_pastora_app/controllers/appointment_controller.dart';
import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/widgets/calendar.dart';
import 'package:agenda_pastora_app/widgets/calendar_admin.dart';
import 'package:agenda_pastora_app/widgets/cards/card-appointments-admin.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentsAdminPage extends StatefulWidget {
  const AppointmentsAdminPage({super.key});

  @override
  State<AppointmentsAdminPage> createState() => _AppointmentsAdminPageState();
}

class _AppointmentsAdminPageState extends State<AppointmentsAdminPage> {
  late final AppointmentController controller;
  final AppointmentRepository _repository = AppointmentRepository();
  List<Appointment> appointments = [];
  bool loading = false;
  DateTime selectedDate = DateTime.now();

  changeSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    findAppointments(date);
  }

  Future<void> findAppointments(DateTime date) async {
    setState(() {
      loading = true;
    });
    final shared = await SharedPreferences.getInstance();
    final accessToken = shared.getString('member.access_token');

    var resultsAppointments =
        await _repository.findAll(null, accessToken, formatDateSelected(date));

    setState(() {
      appointments = resultsAppointments;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = context.read<AppointmentController>();
    findAppointments(selectedDate);
  }

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
                  child: CustomCalendarAdmin(
                      onChange: (selectedDate) =>
                          changeSelectedDate(selectedDate),
                      selectedDate: selectedDate),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            sliver: appointments.isNotEmpty || loading == true ? SliverList.separated(
              itemCount: loading ? 4 : appointments.length,
              itemBuilder: (context, index) => loading
                  ? const CardAppointmentsAdminSk()
                  : CardAppointmentsAdmin(
                      appointment: appointments[index], onPress: () {}),
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
            ) : const SliverToBoxAdapter(
              child: Text('Nenhum compromisso foi encontrado.'),
            ),
          ),
        ],
      ),
    );
  }
}
