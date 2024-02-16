import 'package:agenda_pastora_app/controllers/appointment_controller.dart';
import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/cards/card-appointments-admin.dart';
import 'package:agenda_pastora_app/widgets/custom_alert_dialog.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
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

  List<Appointment> appointmentsReminders = [];
  List<Appointment> appointmentsPendents = [];

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
    final accessToken = shared.getString('user.access_token');

    var reminders = await _repository.findAll('confirmado', accessToken, null);
    var pendents = await _repository.findAll('pendente', accessToken, null);

    setState(() {
      appointmentsReminders = reminders;
      appointmentsPendents = pendents;
      loading = false;
    });
  }

  Future<void> _showMyDialogCancel(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomAlertDialog(
            title: 'Cancelar Agendamento',
            subtitle: 'Deseja mesmo cancelar o agendamento?',
            onChange: () async {
              await _repository.updateStatus(id, 'declinado', null);
              await findAppointments();
            });
      },
    );
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
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
              ),
            ),
            SwipperAppointments(
              appointments: appointmentsReminders,
              loading: loading,
              refresh: _refresh,
              title: 'Lembretes',
              showMyDialogCancel: _showMyDialogCancel,
            ),
            const SizedBox(
              height: 24,
            ),
            SwipperAppointments(
              appointments: appointmentsPendents,
              loading: loading,
              refresh: _refresh,
              title: 'Pendentes',
              showMyDialogCancel: _showMyDialogCancel,
            ),
            const SizedBox(
              height: 24,
            ),
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
          icon: const Icon(FeatherIcons.plus),
          color: Colors.white,
          onPressed: () async {
            await Navigator.pushNamed(context, '/admin/create_appointments');
            await findAppointments();
          },
        ),
      ),
    );
  }
}

class SwipperAppointments extends StatelessWidget {
  final String title;
  final bool loading;
  final Function() refresh;
  final Function(int id)? showMyDialogCancel;
  final List<Appointment> appointments;

  const SwipperAppointments({
    super.key,
    required this.title,
    required this.appointments,
    required this.loading,
    required this.refresh,
    this.showMyDialogCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ColorPalette.gray3,
            ),
          ),
        ),
        SizedBox(
          height: 222,
          child: appointments.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => index == 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 25, right: 16),
                          child: SizedBox(
                            width: 348,
                            child: loading == true
                                ? const CardAppointmentsAdminSk()
                                : CardAppointmentsAdmin(
                                    onPress: refresh,
                                    appointment: appointments[index],
                                    onCancel: showMyDialogCancel,
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
                                    onPress: refresh,
                                    appointment: appointments[index],
                                    onCancel: showMyDialogCancel,
                                  ),
                          ),
                        ),
                  itemCount: loading != true ? appointments.length : 4,
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text('Nenhum compromisso em $title foi encontrado'),
                ),
        )
      ],
    );
  }
}
