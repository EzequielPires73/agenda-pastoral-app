import 'package:agenda_pastora_app/app.dart';
import 'package:agenda_pastora_app/routes.dart';
import 'package:agenda_pastora_app/screens/login.dart';
import 'package:agenda_pastora_app/services/firebase_messaging_service.dart';
import 'package:agenda_pastora_app/services/notification_service.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      Provider<NotificationService>(
        create: (context) => NotificationService(),
      ),
      Provider<FirebaseMessagingService>(
        create: (context) => FirebaseMessagingService(context.read<NotificationService>()),
      )
    ],
    child: const App(),
  ));
}
