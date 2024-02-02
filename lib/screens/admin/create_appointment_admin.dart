import 'package:agenda_pastora_app/controllers/appointment_controller.dart';
import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/models/appointment_category.dart';
import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_confirm.dart';
import 'package:agenda_pastora_app/widgets/calendar.dart';
import 'package:agenda_pastora_app/widgets/cards/card-member.dart';
import 'package:agenda_pastora_app/widgets/dialogs/select_member.dart';
import 'package:agenda_pastora_app/widgets/form_components/text_field_primary.dart';
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
  int? time;
  bool loading = true;

  _successListener() {
    if (controller.state == AppointmentState.success) {
      Navigator.pushReplacementNamed(context, '/details_appointments',
          arguments: {"id": controller.appointment?.id});
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
                          label: 'Assunto do agendamento',
                          placeholder:
                              'Descreva brevemente o assunto do agendamento',
                          maxLines: 4,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 32, bottom: 16),
                        child: const Text(
                          'Motivo do agendamento',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorPalette.gray3,
                          ),
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
                        child: Text(
                          'Horário do agendamento ${formatDateDayMonth(controller.selectedDay)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorPalette.gray3,
                          ),
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
                                    crossAxisCount: 4,
                                    childAspectRatio: 2,
                                    crossAxisSpacing:
                                        8.0, // Espaçamento entre colunas
                                    mainAxisSpacing: 8.0,
                                    children: List.generate(
                                      controller.times.length,
                                      (index) => InkWell(
                                        onTap: () =>
                                            controller.changeTimeSelected(
                                                controller.times[index]),
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color:
                                                controller.times[index].start ==
                                                        controller.time?.start
                                                    ? ColorPalette.primaryLight
                                                    : ColorPalette.input,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            controller.times[index].start,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: controller
                                                          .times[index].start ==
                                                      controller.time?.start
                                                  ? ColorPalette.primary
                                                  : ColorPalette.gray5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SliverToBoxAdapter(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                          color: ColorPalette.input,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: const Text(
                                          'Selecione um motivo do agendamento'),
                                    ),
                                  ),
                          ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 32, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Membro do agendamento',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: ColorPalette.gray3,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            InkWell(
                              onTap: _showDialog,
                              child: const SizedBox(
                                height: 48,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Selecione o membro',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: ColorPalette.gray5,
                                      ),
                                    ),
                                    Icon(
                                      FeatherIcons.chevronRight,
                                      color: ColorPalette.gray5,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                  onPressed: () =>
                                      controller.createAppointment(),
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

  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      builder: (context) => SelectMember(),
    );
  }
}
