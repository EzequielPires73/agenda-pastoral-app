import 'package:agenda_pastora_app/controllers/appointment_controller.dart';
import 'package:agenda_pastora_app/models/available_time.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  final List<AvailableTime> availableTimes;
  const CustomCalendar({super.key, required this.availableTimes});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late final AppointmentController controller;
  CalendarFormat _calendarFormat = CalendarFormat.week;

  bool _isDisabled(DateTime day) {
    return !widget.availableTimes.any((availableTime) =>
        DateTime.parse(availableTime.date)
            .isAtSameMomentAs(DateTime(day.year, day.month, day.day)));
  }

  @override
  void initState() {
    super.initState();
    controller = context.read<AppointmentController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Consumer<AppointmentController>(
        builder: (context, value, child) {
          return TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: value.focusedDay,
            calendarFormat: _calendarFormat,
            enabledDayPredicate: (DateTime day) {
              return !_isDisabled(day);
            },
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontSize: 12),
                weekendStyle: TextStyle(fontSize: 12)),
            calendarStyle: const CalendarStyle(
              defaultDecoration: BoxDecoration(
                color: ColorPalette.greenLight,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(color: ColorPalette.green),
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
              weekendDecoration: BoxDecoration(
                color: ColorPalette
                    .greenLight, // ou qualquer cor que você deseje para os finais de semana
                shape: BoxShape.circle,
              ),
              weekendTextStyle: TextStyle(color: ColorPalette.green),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(value.selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(value.selectedDay, selectedDay)) {
                value.changeDateSelected(selectedDay, focusedDay);
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
              value.changeDateSelected(value.selectedDay, focusedDay);
            },
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, day) {
                String monthText = '';
                switch (day.month) {
                  case 1:
                    monthText = 'Janeiro';
                    break;
                  case 2:
                    monthText = 'Fevereiro';
                    break;
                  case 3:
                    monthText = 'Março';
                    break;
                  case 4:
                    monthText = 'Abril';
                    break;
                  case 5:
                    monthText = 'Maio';
                    break;
                  case 6:
                    monthText = 'Junho';
                    break;
                  case 7:
                    monthText = 'Julho';
                    break;
                  case 8:
                    monthText = 'Agosto';
                    break;
                  case 9:
                    monthText = 'Setembro';
                    break;
                  case 10:
                    monthText = 'Outubro';
                    break;
                  case 11:
                    monthText = 'Novembro';
                    break;
                  case 12:
                    monthText = 'Dezembro';
                    break;
                  default:
                    break;
                }

                return Center(
                  child: Text(
                    '$monthText ${day.year}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.gray3),
                  ),
                );
              },
              dowBuilder: (context, day) {
                String text = '';
                if (day.weekday == DateTime.sunday) {
                  text = 'dom';
                } else if (day.weekday == DateTime.monday) {
                  text = 'seg';
                } else if (day.weekday == DateTime.tuesday) {
                  text = 'ter';
                } else if (day.weekday == DateTime.wednesday) {
                  text = 'qua';
                } else if (day.weekday == DateTime.thursday) {
                  text = 'qui';
                } else if (day.weekday == DateTime.friday) {
                  text = 'sex';
                } else if (day.weekday == DateTime.saturday) {
                  text = 'sab';
                }

                return Center(
                  child: Text(text,
                      style: const TextStyle(
                          fontSize: 12, color: ColorPalette.gray5)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
