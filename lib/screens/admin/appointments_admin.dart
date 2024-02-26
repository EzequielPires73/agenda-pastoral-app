import 'package:agenda_pastora_app/controllers/appointment_controller.dart';
import 'package:agenda_pastora_app/controllers/available_time_controller.dart';
import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/repositories/available_time_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_confirm.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/calendar.dart';
import 'package:agenda_pastora_app/widgets/calendar_admin.dart';
import 'package:agenda_pastora_app/widgets/cards/card-appointments-admin.dart';
import 'package:agenda_pastora_app/widgets/cards/card-available-time.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:agenda_pastora_app/widgets/modals/modal-create-available-time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentsAdminPage extends StatefulWidget {
  const AppointmentsAdminPage({super.key});

  @override
  State<AppointmentsAdminPage> createState() => _AppointmentsAdminPageState();
}

class _AppointmentsAdminPageState extends State<AppointmentsAdminPage> {
  late final AppointmentController controller;
  late final AvailableTimeController availableTimeController;
  final AppointmentRepository _repository = AppointmentRepository();
  final AvailableTimeRepository _availableTimeRepository =
      AvailableTimeRepository();

  List<Appointment> appointments = [];
  List<AvailableTime> availableTimes = [];
  bool loading = false;
  bool error = false;
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
    final accessToken = shared.getString('user.access_token');

    var resultsAppointments =
        await _repository.findAll(null, accessToken, formatDateSelected(date));
    var resultsAvailableTime =
        await _availableTimeRepository.findAll(formatDateSelected(date));

    setState(() {
      appointments = resultsAppointments;
      availableTimes = resultsAvailableTime;
      loading = false;
    });
  }

  Future<void> availableTimeListener() async {
    if (availableTimeController.error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error ao cadastrar horário.')));
    }
  }

  @override
  void initState() {
    super.initState();
    controller = context.read<AppointmentController>();
    availableTimeController = context.read<AvailableTimeController>();

    availableTimeController.addListener(availableTimeListener);
    findAppointments(selectedDate);
  }

  @override
  void dispose() {
    availableTimeController.removeListener(availableTimeListener);
    super.dispose();
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
                  padding: const EdgeInsets.only(
                    top: 32,
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
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 8),
              child: const Text(
                'Horários livres',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.gray3,
                ),
              ),
            ),
          ),
          loading
              ? SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  sliver: SliverToBoxAdapter(
                    child: Text('Nenhum horário livre foi encontrado.'),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  sliver: availableTimes.isNotEmpty &&
                          availableTimes[0].times.isNotEmpty
                      ? SliverGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1.4,
                          children: availableTimes[0]
                              .times
                              .map((e) => CardAvailableTime(
                                    time: e,
                                    onAction: () =>
                                        findAppointments(selectedDate),
                                  ))
                              .toList(),
                        )
                      : const SliverToBoxAdapter(
                          child: Text('Nenhum horário livre foi encontrado.'),
                        ),
                ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(right: 25, left: 25, top: 16),
              child: ButtonPrimary(
                  onPressed: showMyDialogCreateAvaibleTime,
                  title: 'Adicionar horário'),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 8, top: 24),
              child: const Text(
                'Agendamentos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.gray3,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(right: 25, left: 25, bottom: 24),
            sliver: appointments.isNotEmpty || loading == true
                ? SliverList.separated(
                    itemCount: loading ? 4 : appointments.length,
                    itemBuilder: (context, index) => loading
                        ? const CardAppointmentsAdminSk()
                        : CardAppointmentsAdmin(
                            appointment: appointments[index], onPress: () {}),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                  )
                : const SliverToBoxAdapter(
                    child: Text('Nenhum compromisso foi encontrado.'),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> showMyDialogCreateAvaibleTime() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return ModalCreateAvailableTime(
            onSubmit: (start, end) => createAvailableTime(start, end));
      },
    );
  }

  void handleErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> createAvailableTime(TimeOfDay start, TimeOfDay end) async {
    try {
      setState(() {
        loading = true;
        error = false;
      });

      final shared = await SharedPreferences.getInstance();
      final accessToken = shared.getString('member.access_token');

      var res = await _availableTimeRepository.create(
          selectedDate, start, end, accessToken);

      print(res);

      if (res.errorMessage != null) handleErrorMessage(res.errorMessage!);
      if (res.success == true) await findAppointments(selectedDate);
    } catch (e) {
      setState(() {
        error = true;
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
