import 'package:intl/intl.dart';

String formatDateDayMonth(DateTime date) {
  final DateFormat dateFormat = DateFormat('dd/MM');
  String formattedDate = dateFormat.format(date);
  return formattedDate;
}
String formatDateSelected(DateTime date) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = dateFormat.format(date);
  return formattedDate;
}
