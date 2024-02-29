import 'package:agenda_pastora_app/controllers/appointment_controller.dart';
import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/models/appointment_category.dart';
import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/alerts/alert_message.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_confirm.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_secondary.dart';
import 'package:agenda_pastora_app/widgets/calendar.dart';
import 'package:agenda_pastora_app/widgets/cards/card-member.dart';
import 'package:agenda_pastora_app/widgets/cards/card-time.dart';
import 'package:agenda_pastora_app/widgets/dialogs/select_member.dart';
import 'package:agenda_pastora_app/widgets/form_components/text_field_primary.dart';
import 'package:agenda_pastora_app/widgets/member_select.dart';
import 'package:agenda_pastora_app/widgets/modals/modal-create-available-time.dart';
import 'package:agenda_pastora_app/widgets/typography/label.dart';
import 'package:agenda_pastora_app/widgets/user_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class CreateAppointmentAdminPage extends StatefulWidget {
  const CreateAppointmentAdminPage({super.key});

  @override
  State<CreateAppointmentAdminPage> createState() =>
      _CreateAppointmentAdminPageState();
}

class _CreateAppointmentAdminPageState
    extends State<CreateAppointmentAdminPage> {
  late final AppointmentController controller;
  List<AvailableTime> availableTimes = [];
  List<AppointmentCategory> appointmentsCategories = [];
  AppointmentCategory? category;
  UserAbstract? member;
  UserAbstract? user;
  int? time;
  bool loading = true;

  void handleErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  _successListener() {
    if (controller.state == AppointmentState.success) {
      Navigator.pushReplacementNamed(context, '/details_appointments',
          arguments: {"id": controller.appointment?.id});
    } else if (controller.state == AppointmentState.error) {
      handleErrorMessage(controller.errorMsg);
    }
  }

  Future<void> _loadInitialValues() async {
    await controller.loadInitialValues();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = context.read<AppointmentController>();
    controller.addListener(_successListener);
    _loadInitialValues();
  }

  @override
  void dispose() {
    controller.removeListener(_successListener);
    controller.onDispose();
    super.dispose();
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
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return controller.state == AppointmentState.loadding
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: CustomCalendar(
                        availableTimes: controller.availableTimes,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 32),
                        child: TextFieldPrimary(
                          controller: controller.observation,
                          label: 'Descrição do agendamento',
                          placeholder:
                              'Por favor, forneça uma breve descrição do motivo para o atendimento.',
                          maxLines: 4,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 32, bottom: 16),
                        child: Label(
                          text: 'Motivo do agendamento',
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      sliver: controller.appointmentsCategories.isNotEmpty
                          ? SliverGrid.count(
                              crossAxisCount: 2,
                              childAspectRatio: 2.5,
                              crossAxisSpacing:
                                  8.0, // Espaçamento entre colunas
                              mainAxisSpacing: 8.0,
                              children: List.generate(
                                controller.appointmentsCategories.length,
                                (index) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      controller.changeCategorySelected(
                                          controller
                                              .appointmentsCategories[index]);
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: controller.category?.id ==
                                              controller
                                                  .appointmentsCategories[index]
                                                  .id
                                          ? ColorPalette.primaryLight
                                          : ColorPalette.input,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      controller
                                          .appointmentsCategories[index].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: controller.category?.id ==
                                                controller
                                                    .appointmentsCategories[
                                                        index]
                                                    .id
                                            ? ColorPalette.primary
                                            : ColorPalette.gray5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SliverToBoxAdapter(),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 32, bottom: 16),
                        child: Label(
                          text:
                              'Horário do agendamento - ${formatDateDayMonth(controller.selectedDay)}',
                        ),
                      ),
                    ),
                    controller.state == AppointmentState.loaddingTimes
                        ? const SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            sliver: controller
                                        .appointmentsCategories.isNotEmpty &&
                                    controller.category != null
                                ? SliverGrid.count(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2,
                                    crossAxisSpacing:
                                        8.0, // Espaçamento entre colunas
                                    mainAxisSpacing: 8.0,
                                    children: List.generate(
                                      controller.times.length,
                                      (index) => CardTime(
                                        time: controller.times[index],
                                        active: controller.times[index].start ==
                                            controller.time?.start,
                                        onAction: () =>
                                            controller.changeTimeSelected(
                                                controller.times[index]),
                                      ),
                                    ),
                                  )
                                : SliverToBoxAdapter(
                                    child: AlertMessage(
                                      message:
                                          'Selecione uma data e um motivo para o agendamento',
                                    ),
                                  ),
                          ),
                    controller.state != AppointmentState.loaddingTimes &&
                            controller.times.isEmpty &&
                            controller.category != null
                        ? SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: AlertMessage(
                                message: 'Nenhum horário disponível encontrado',
                              ),
                            ),
                          )
                        : SliverToBoxAdapter(),
                    SliverToBoxAdapter(
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          margin: EdgeInsets.only(top: 16),
                          child: ButtonPrimary(
                              onPressed: showMyDialogCreateAvaibleTime,
                              title: 'Adicionar Horário Dinâmico')),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          MemberSelect(
                            title: 'Membro do agendamento',
                            placeholder: 'Selecione o membro',
                            onSelect: (memberSelected) {
                              setState(() {
                                member = memberSelected;
                              });
                            },
                          ),
                          UserSelect(
                            title: 'Responsável do agendamento',
                            placeholder: 'Selecione o responsável',
                            onSelect: (userSelected) {
                              setState(() {
                                user = userSelected;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 32, bottom: 32),
                        child: Row(
                          children: [
                            Expanded(
                              child: ButtonCancel(
                                  onPressed: () => Navigator.pop(context),
                                  title: 'Cancelar'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: ButtonConfirm(
                                  onPressed: () => controller.createAppointmentByAdmin(
                                      memberSelected: member,
                                      responsibleSelected: user),
                                  title: 'Solicitar'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Future<void> showMyDialogCreateAvaibleTime() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return ModalCreateAvailableTime(
          onSubmit: (start, end) => controller.changeTimes(
            [
              ...controller.times,
              Time(
                start: formatTimeHourMinute(start),
                end: formatTimeHourMinute(end),
              ),
            ],
          ),
        );
      },
    );
  }
}
