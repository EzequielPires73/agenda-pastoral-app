import 'package:agenda_pastora_app/models/appointment_category.dart';
import 'package:agenda_pastora_app/repositories/appointment_category_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_confirm.dart';
import 'package:agenda_pastora_app/widgets/calendar.dart';
import 'package:agenda_pastora_app/widgets/form_components/text_field_primary.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateAppointmentsPage extends StatefulWidget {
  const CreateAppointmentsPage({super.key});

  @override
  State<CreateAppointmentsPage> createState() => _CreateAppointmentsPageState();
}

class _CreateAppointmentsPageState extends State<CreateAppointmentsPage> {
  DateTime date = DateTime.now();
  final AppointmentCategoryRepository categoryRepository =
      AppointmentCategoryRepository();
  late final List<AppointmentCategory> categories;
  final TextEditingController observation = TextEditingController();
  AppointmentCategory? category;
  int? time;

  @override
  void initState() {
    categories = categoryRepository.categories;
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
      body: CustomScrollView(slivers: [
        const SliverToBoxAdapter(
          child: CustomCalendar(),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 32, bottom: 16),
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
          sliver: categories.isNotEmpty
              ? SliverGrid.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 8.0, // Espaçamento entre colunas
                  mainAxisSpacing: 8.0,
                  children: List.generate(
                    8,
                    (index) => InkWell(
                      onTap: () {
                        setState(() {
                          category = categories[index];
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: category?.id == categories[index].id
                              ? ColorPalette.primaryLight
                              : ColorPalette.input,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          categories[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: category?.id == categories[index].id
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
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 32, bottom: 16),
            child: const Text(
              'Horário do agendamento',
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
          sliver: categories.isNotEmpty
              ? SliverGrid.count(
                  crossAxisCount: 4,
                  childAspectRatio: 2,
                  crossAxisSpacing: 8.0, // Espaçamento entre colunas
                  mainAxisSpacing: 8.0,
                  children: List.generate(
                    10,
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
                        '${index + 8 >= 10 ? '${index+8}' : '0${index+8}'}:00',
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
              : const SliverToBoxAdapter(),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 32),
            child: TextFieldPrimary(
              controller: observation,
              label: 'Observação',
              placeholder: 'Descreva brevemente o agendamento',
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 32, bottom: 32),
            child: Row(
              children: [
                Expanded(
                  child: ButtonCancel(onPressed: () {}, title: 'Cancelar'),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: ButtonConfirm(onPressed: () {}, title: 'Solicitar'),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
