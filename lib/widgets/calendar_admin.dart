import 'package:agenda_pastora_app/controllers/appointment_controller.dart';
import 'package:agenda_pastora_app/helpers/date.dart';
import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendarAdmin extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime selectedDate) onChange;
  const CustomCalendarAdmin({super.key, required this.selectedDate, required this.onChange});

  @override
  State<CustomCalendarAdmin> createState() => _CustomCalendarAdminState();
}

class _CustomCalendarAdminState extends State<CustomCalendarAdmin> {
  late final AppointmentController controller;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    controller = context.read<AppointmentController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TableCalendar(
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
            )
            )
    );
  }
}
