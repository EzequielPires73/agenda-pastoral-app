import 'package:agenda_pastora_app/controllers/auth_controller.dart';
import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/helpers/status.dart';
import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_confirm.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_secondary.dart';
import 'package:agenda_pastora_app/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    if (isLoading == false) {
      setState(() {
        isLoading = true;
      });
    }
    var res = await _repository.findOne(id);
    setState(() {
      appointmentId = res?.id;
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
            ? const Center(
                child: CircularProgressIndicator(),
              )
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
                                    Text(formatDate(appointment!.date))
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
                                        '${formatTime(appointment!.start)} - ${formatTime(appointment!.end)}')
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            appointment?.observation.isEmpty != true
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xffdddddd),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(appointment!.observation),
                                      )
                                    ],
                                  )
                                : Container(),
                            const SizedBox(height: 32),
                            Column(
                              children: [
                                Consumer<AuthController>(
                                  builder: (context, value, child) {
                                    if (value.user != null &&
                                        appointment!.status == 'pendente') {
                                      return ButtonPrimary(
                                        onPressed: _showMyDialogConfirm,
                                        title: 'Confirmar agendamento',
                                      );
                                    } else if (value.member != null) {
                                      ButtonPrimary(
                                        onPressed: () => {},
                                        title: 'Alterar agendamento',
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                appointment!.status == 'pendente' || appointment!.status == 'confirmado' ?  ButtonSecondary(
                                  onPressed: _showMyDialogCancel,
                                  title: 'Cancelar agendamento',
                                ) : Container(),
                              ],
                            ),
                          ],
                        )
                      : const Text('Compromisso não foi encontrado.'),
                ),
              ));
  }

  Future<void> _showMyDialogCancel() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomAlertDialog(
            title: 'Cancelar Agendamento',
            subtitle: 'Deseja mesmo cancelar o agendamento?',
            onChange: () async {
              await _repository.updateStatus(appointmentId!, 'declinado');
              await findAppointment(appointmentId!);
            });
      },
    );
  }

  Future<void> _showMyDialogConfirm() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CustomAlertDialog(
            title: 'Confirmar Agendamento',
            subtitle: 'Deseja mesmo confirmar o agendamento?',
            onChange: () async {
              await _repository.updateStatus(appointmentId!, 'confirmado');
              await findAppointment(appointmentId!);
            });
      },
    );
  }
}
