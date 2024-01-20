import 'package:agenda_pastora_app/controllers/appointment_controller.dart';
import 'package:agenda_pastora_app/models/appointment_category.dart';
import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/repositories/appointment_category_repository.dart';
import 'package:agenda_pastora_app/repositories/available_time_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_confirm.dart';
import 'package:agenda_pastora_app/widgets/calendar.dart';
import 'package:agenda_pastora_app/widgets/form_components/text_field_primary.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateAppointmentsPage extends StatefulWidget {
  const CreateAppointmentsPage({super.key});

  @override
  State<CreateAppointmentsPage> createState() => _CreateAppointmentsPageState();
}

class _CreateAppointmentsPageState extends State<CreateAppointmentsPage> {
  late final AppointmentController controller;
  final TextEditingController observation = TextEditingController();
  List<AvailableTime> availableTimes = [];
  List<AppointmentCategory> appointmentsCategories = [];
  AppointmentCategory? category;
  int? time;

  Future<void> findAvailableTimes() async {}

  @override
  void initState() {
    super.initState();
    findAvailableTimes();
    controller = context.read<AppointmentController>();
    controller.loadInitialValues();
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
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CustomCalendar(availableTimes: controller.availableTimes,),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 32),
                  child: TextFieldPrimary(
                    controller: observation,
                    label: 'Observação',
                    placeholder: 'Descreva brevemente o agendamento',
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
                        crossAxisSpacing: 8.0, // Espaçamento entre colunas
                        mainAxisSpacing: 8.0,
                        children: List.generate(
                          controller.appointmentsCategories.length,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                controller.changeCategorySelected(controller.appointmentsCategories[index]);
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: controller.category?.id ==
                                        controller.appointmentsCategories[index].id
                                    ? ColorPalette.primaryLight
                                    : ColorPalette.input,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                controller.appointmentsCategories[index].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: controller.category?.id ==
                                          controller.appointmentsCategories[index].id
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
                    'Horário do agendamento ${_formatDate(controller.selectedDay)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.gray3,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                sliver: controller.appointmentsCategories.isNotEmpty && controller.category != null
                    ? SliverGrid.count(
                        crossAxisCount: 4,
                        childAspectRatio: 2,
                        crossAxisSpacing: 8.0, // Espaçamento entre colunas
                        mainAxisSpacing: 8.0,
                        children: List.generate(
                          controller.times.length,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                time = index;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: time == index
                                    ? ColorPalette.primaryLight
                                    : ColorPalette.input,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                controller.times[index].start,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: time == index
                                      ? ColorPalette.primary
                                      : ColorPalette.gray5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SliverToBoxAdapter(child: Text('Selecione um motivo do agendamento'),),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 32, bottom: 32),
                  child: Row(
                    children: [
                      Expanded(
                        child:
                            ButtonCancel(onPressed: () {}, title: 'Cancelar'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child:
                            ButtonConfirm(onPressed: () {}, title: 'Solicitar'),
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

  String _formatDate(DateTime date) {
    final DateFormat dateFormat = DateFormat('dd/MM');
    String formattedDate = dateFormat.format(date);
    return formattedDate;
  }
}
