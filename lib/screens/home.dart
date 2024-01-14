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
  final active = 1;
  List<AppointmentStatus> agendamentos = [AppointmentStatus.confirmado, AppointmentStatus.pendente, AppointmentStatus.pendente, AppointmentStatus.pendente, AppointmentStatus.confirmado, AppointmentStatus.pendente];

  setResults(int index) {
    if(index == 0) {
      setState(() {
        agendamentos = [AppointmentStatus.confirmado, AppointmentStatus.pendente, AppointmentStatus.pendente, AppointmentStatus.pendente, AppointmentStatus.confirmado, AppointmentStatus.pendente];
      });
    } else {
      setState(() {
        agendamentos = [AppointmentStatus.finalizado, AppointmentStatus.declinado,];
      });
    }
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
                horizontal: 32,
                vertical: 25,
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
                    ...agendamentos.map((e) => CardAppointmentsUser(status: e,)).toList(),
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
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
            color: ColorPalette.primary,
            borderRadius: BorderRadius.circular(4)),
        child: IconButton(
          icon: Icon(FeatherIcons.plus),
          color: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}

/* 
Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),
            Container(
              width: double.infinity,
              transform: Matrix4.translationValues(0, -16, 0),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 25,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: ColorPalette.primary,
                      unselectedLabelColor: Colors.black38,
                      indicatorColor: ColorPalette.primary,
                      tabs: [
                        Tab(
                          text: 'Agendamentos',
                        ),
                        Tab(
                          text: 'Histórico',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 500,
                      child: TabBarView(children: [
                      ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) => const Column(
                          children: [
                            CardAppointmentsUser(),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                      ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) => const Column(
                          children: [
                            CardAppointmentsUser(),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ]),
                    ),
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
        margin: EdgeInsets.only(right: 16, bottom: 16),
        decoration: BoxDecoration(
            color: ColorPalette.primary,
            borderRadius: BorderRadius.circular(4)),
        child: IconButton(
          icon: Icon(FeatherIcons.plus),
          color: Colors.white,
          onPressed: () {},
        ),
      ),
    );
 */