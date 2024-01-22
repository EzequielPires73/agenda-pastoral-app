import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/cards/card-appointments-user.dart';
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
  List<Appointment> appointments = [];
  List<Appointment> history = [];

  setActive(int index) {
    setState(() {
      active = index;
    });
  }

  Future<void> findAppointments() async {
    final shared = await SharedPreferences.getInstance();
    final accessToken = shared.getString('member.access_token');
    var resultsAppointments = await _repository.findAppointmentsByMember(
        'pendente,confirmado', accessToken);
    var resultsHistory = await _repository.findAppointmentsByMember(
        'finalizado,declinado', accessToken);
    setState(() {
      appointments = resultsAppointments;
      history = resultsHistory;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    findAppointments();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('voltou');
  }

  @override
  void initState() {
    findAppointments();
    super.initState();
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
                child: DefaultTabController(
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
                          ? Column(
                              children: [
                                ...appointments
                                    .map((e) => CardAppointmentsUser(
                                          appointment: e,
                                        ))
                                    .toList(),
                              ],
                            )
                          : Column(
                              children: [
                                ...history
                                    .map((e) => CardAppointmentsUser(
                                          appointment: e,
                                        ))
                                    .toList(),
                              ],
                            )
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
          icon: Icon(FeatherIcons.plus),
          color: Colors.white,
          onPressed: () => Navigator.pushNamed(context, '/create_appointments'),
        ),
      ),
    );
  }
}
