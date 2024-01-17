import 'package:agenda_pastora_app/screens/screen_navigator.dart';
import 'package:agenda_pastora_app/screens/admin/screen_navigator_admin.dart';
import 'package:agenda_pastora_app/screens/admin/login_admin.dart';
import 'package:agenda_pastora_app/screens/choose_role.dart';
import 'package:agenda_pastora_app/screens/create_appointments.dart';
import 'package:agenda_pastora_app/screens/details_appointments.dart';
import 'package:agenda_pastora_app/screens/home.dart';
import 'package:agenda_pastora_app/screens/login.dart';
import 'package:agenda_pastora_app/screens/notifications.dart';
import 'package:agenda_pastora_app/screens/singup.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder> {
    '/choose_role': (_) => const ChooseRolePage(),
    '/login': (_) => const LoginPage(),
    '/home': (_) => const ScreenNavigatorPage(),
    '/notificacao': (_) => const NotificationsPage(),
    '/singup': (_) => const SingUpPage(),
    '/create_appointments': (_) => const CreateAppointmentsPage(),
    '/details_appointments': (_) => const DetailsAppointments(),

    /* Admin Routes */
    '/admin/login': (_) => const LoginAdminPage(),
    '/admin/home': (_) => const ScreenNavigatorAdminPage(),
  };

  static String initial = '/choose_role';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}