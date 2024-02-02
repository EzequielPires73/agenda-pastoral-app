import 'package:agenda_pastora_app/app.dart';
import 'package:agenda_pastora_app/controllers/appointment_controller.dart';
import 'package:agenda_pastora_app/controllers/auth_controller.dart';
import 'package:agenda_pastora_app/controllers/available_time_controller.dart';
import 'package:agenda_pastora_app/routes.dart';
import 'package:agenda_pastora_app/screens/login.dart';
import 'package:agenda_pastora_app/services/firebase_messaging_service.dart';
import 'package:agenda_pastora_app/services/notification_service.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: ColorPalette.primary),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppointmentController(),
      ),
      ChangeNotifierProvider(
        create: (context) => AvailableTimeController(),
      ),
      Provider<NotificationService>(
        create: (context) => NotificationService(),
      ),
      Provider<FirebaseMessagingService>(
        create: (context) =>
            FirebaseMessagingService(context.read<NotificationService>()),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthController(),
      ),
    ],
    child: const App(),
  ));
}
