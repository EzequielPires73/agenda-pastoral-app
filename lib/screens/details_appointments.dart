import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_confirm.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_secondary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';

class DetailsAppointments extends StatefulWidget {
  const DetailsAppointments({super.key});

  @override
  State<DetailsAppointments> createState() => _DetailsAppointmentsState();
}

class _DetailsAppointmentsState extends State<DetailsAppointments> {
  final AppointmentRepository _repository = AppointmentRepository();
  late int? appointmentId;
  late Appointment? appointment;
  bool isLoading = true;

  Future<void> findAppointment(int id) async {
    var res = await _repository.findOne(id);
    setState(() {
      appointment = res;
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      findAppointment(args['id']);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          toolbarHeight: 80,
          title: const Text(
            'Agendamento',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: isLoading == true
            ? Center(child: CircularProgressIndicator(),)
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 32),
                  child: appointment != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                  color: getBackground(appointment!.status),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                getStatusText(appointment!.status),
                                style: TextStyle(
                                    color: getColor(appointment!.status),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              appointment!.category.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: ColorPalette.gray3,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      FeatherIcons.calendar,
                                      color: ColorPalette.primary,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(_formatDate(appointment!.date))
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      FeatherIcons.clock,
                                      color: ColorPalette.primary,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                        '${_formatTime(appointment!.start)} - ${_formatTime(appointment!.end)}')
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Observação',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: ColorPalette.gray3,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xffdddddd), width: 1),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(appointment!.observation),
                                )
                              ],
                            ),
                            const SizedBox(height: 32),
                            Column(
                              children: [
                                ButtonPrimary(
                                  onPressed: () => {},
                                  title: 'Alterar agendamento',
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                ButtonSecondary(
                                  onPressed: _showMyDialog,
                                  title: 'Cancelar agendamento',
                                ),
                              ],
                            ),
                          ],
                        )
                      : Text('Encontro não foi encontrado.'),
                ),
              ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text(
            'Cancelar Agendamento',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja mesmo cancelar o agendamento?'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: ButtonCancel(
                      onPressed: () => Navigator.of(context).pop(),
                      title: 'Cancelar'),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: ButtonConfirm(
                      onPressed: () => Navigator.of(context).pop(),
                      title: 'Confirmar'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String _formatDate(String date) {
    final DateFormat dateFormat = DateFormat('dd/MM');
    String formattedDate = dateFormat.format(DateTime.parse(date));
    return formattedDate;
  }

  String _formatTime(String time) {
    final DateFormat timeFormat = DateFormat('HH:mm');
    String formattedTime =
        timeFormat.format(DateTime.parse('2000-01-01 $time'));
    return formattedTime;
  }

  getStatusText(String status) {
    String title;
    switch (status) {
      case 'confirmado':
        title = 'Confirmado';
        break;
      case 'pendente':
        title = 'Pendente';
        break;
      case 'finalizado':
        title = 'Finalizado';
        break;
      case 'declinado':
        title = 'Declinado';
        break;

      default:
        title = 'Pendente';
    }

    return title;
  }

  getColor(status) {
    Color color;
    switch (status) {
      case 'confirmado':
        color = ColorPalette.green;
        break;
      case 'pendente':
        color = ColorPalette.primary;
        break;
      case 'finalizado':
        color = ColorPalette.blue;
        break;
      case 'declinado':
        color = ColorPalette.red;
        break;

      default:
        color = ColorPalette.primary;
    }

    return color;
  }

  getBackground(status) {
    Color color;
    switch (status) {
      case 'confirmado':
        color = ColorPalette.greenLight;
        break;
      case 'pendente':
        color = ColorPalette.primaryLight;
        break;
      case 'finalizado':
        color = ColorPalette.blueLight;
        break;
      case 'declinado':
        color = ColorPalette.redLight;
        break;

      default:
        color = ColorPalette.primary;
    }

    return color;
  }
}
