import 'package:agenda_pastora_app/models/custom_notification.dart';
import 'package:agenda_pastora_app/routes.dart';
import 'package:agenda_pastora_app/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  Future<void> initilize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            badge: true, sound: true, alert: true);

    getDeviceFirebaseToken();
    _onMessage();
    //_onMessageOpenedApp();
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }

  Future<String?> getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();

    debugPrint('============================');
    debugPrint('TOKEN: $token');
    debugPrint('============================');

    return token;
  }

  _onMessage() async {
    print('Entrou aqui 1');
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        print('Entrou aqui 2');
        _notificationService.showNotification(CustomNotification(
            id: android.hashCode,
            title: notification.title,
            body: notification.body,
            payload: message.data['route'] ?? ''));
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message) {
    print('Entrou aqui');
    final String route = message.data['route'] ?? '';
    if (route.isNotEmpty) {
      Routes.navigatorKey?.currentState?.pushNamed('/home', arguments: {"selectedIndex": 1});
    }
  }

  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");

    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      // Aqui você pode fazer o que quiser com a notificação em segundo plano
      print('Notification Title: ${notification.title}');
      print('Notification Body: ${notification.body}');

      // Exemplo: Mostrar notificação em segundo plano
      await NotificationService().showNotification(CustomNotification(
        id: android.hashCode,
        title: notification.title ?? '',
        body: notification.body ?? '',
        payload: message.data['route'] ?? '',
      ));
    }
  }
}
