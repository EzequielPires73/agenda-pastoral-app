import 'package:agenda_pastora_app/controllers/appointment_controller.dart';
import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/models/appointment.dart';
import 'package:agenda_pastora_app/repositories/appointment_repository.dart';
import 'package:agenda_pastora_app/repositories/available_time_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendarAdmin extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime selectedDate) onChange;
  const CustomCalendarAdmin(
      {super.key, required this.selectedDate, required this.onChange});

  @override
  State<CustomCalendarAdmin> createState() => _CustomCalendarAdminState();
}

class _CustomCalendarAdminState extends State<CustomCalendarAdmin> {
  late final AppointmentController controller;
  final AppointmentRepository _appointmentRepository =
      AppointmentRepository();
  bool loading = true;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<Appointment> appointments = [];

  Future<void> findAppointments() async {
    setState(() {
      loading = true;
    });
    final shared = await SharedPreferences.getInstance();
    final accessToken = shared.getString('user.access_token');
    var res = await _appointmentRepository.findAll(null, accessToken, null);
    print(res);
    setState(() {
      appointments = res;
      loading = false;
    });
  }

  @override
  void initState() {
    findAppointments();
    super.initState();
    controller = context.read<AppointmentController>();
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return appointments.where((element) => element.date == formatDateSelected(day)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: loading == true ? Container(child: Text('Carregando...'),) : TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontSize: 12),
                weekendStyle: TextStyle(fontSize: 12)),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: ColorPalette.primaryLight,
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: ColorPalette.primary,
              ),
              selectedDecoration: BoxDecoration(
                color: ColorPalette.primary,
                shape: BoxShape.circle,
              ),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(widget.selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(widget.selectedDate, selectedDay)) {
                widget.onChange(selectedDay);
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) {
              return _getEventsForDay(day);
            },
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, day) {
                return Center(
                  child: Text(
                    '${formatMonthByNumber(day)} ${day.year}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.gray3),
                  ),
                );
              },
              dowBuilder: (context, day) {
                return Center(
                  child: Text(formatDayWeek(day),
                      style: const TextStyle(
                          fontSize: 12, color: ColorPalette.gray5)),
                );
              },
            )));
  }
}
