import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/cards/card-appointments-user.dart';
import 'package:agenda_pastora_app/widgets/custom_alert_dialog.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppointmentRepository _repository = AppointmentRepository();
  var active = 0;
  bool loading = true;
  List<Appointment> appointments = [];
  List<Appointment> history = [];

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

    var resultsAppointments = await _repository.findAppointmentsByMember(
        'pendente,confirmado', accessToken);
    var resultsHistory = await _repository.findAppointmentsByMember(
        'finalizado,declinado', accessToken);

    setState(() {
      appointments = resultsAppointments;
      history = resultsHistory;
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
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
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
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(
                              onTap: (value) => setActive(value),
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
                            const SizedBox(
                              height: 16,
                            ),
                            active == 0
                                ? ContentView(
                                    title: 'Agendamentos',
                                    appointments: appointments,
                                    onCancel: (id) => _showMyDialogCancel(id),
                                    onRefresh: _refresh,
                                  )
                                : ContentView(
                                    title: 'Histórico',
                                    appointments: history,
                                    onCancel: (id) => _showMyDialogCancel(id),
                                    onRefresh: _refresh,
                                  ),
                          ],
                        ),
                      ),
              )
            ],
          ),
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
            await Navigator.pushNamed(context, '/create_appointments');
            _refresh();
          },
        ),
      ),
    );
  }
}

class ContentView extends StatelessWidget {
  final String title;
  final List<Appointment> appointments;
  final Function() onRefresh;
  final Function(int id) onCancel;
  const ContentView(
      {super.key,
      required this.title,
      required this.appointments,
      required this.onRefresh,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return appointments.isNotEmpty
        ? Column(
            children: [
              ...appointments
                  .map((e) => CardAppointmentsUser(
                        appointment: e,
                        onPress: onRefresh,
                        onCancel: (id) => onCancel(id),
                      ))
                  .toList(),
            ],
          )
        : Container(
            child: Text('Nenhum compromisso em $title foi encontrado'),
          );
  }
}
