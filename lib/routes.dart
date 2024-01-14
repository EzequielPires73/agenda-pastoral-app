import 'package:agenda_pastora_app/screens/ScreenNavigator.dart';
import 'package:agenda_pastora_app/screens/home.dart';
import 'package:agenda_pastora_app/screens/login.dart';
import 'package:agenda_pastora_app/screens/notifications.dart';
import 'package:agenda_pastora_app/screens/singup.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder> {
    '/login': (_) => const LoginPage(),
    '/home': (_) => const ScreenNavigatorPage(),
    '/notificacao': (_) => const NotificationsPage(),
    '/singup': (_) => const SingUpPage(),
  };

  static String initial = '/login';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}