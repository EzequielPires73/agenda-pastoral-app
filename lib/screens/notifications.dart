import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/cards/card-notification.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      const Header(),
      Container(
        width: double.infinity,
        transform: Matrix4.translationValues(0, -16, 0),
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 32,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notificações',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: ColorPalette.gray3,
                ),
              ),
              SizedBox(height: 16,),
              CardNotification(),
              SizedBox(height: 24,),
              CardNotification(),
              SizedBox(height: 24,),
              CardNotification(),
              SizedBox(height: 24,),
              CardNotification(),
              SizedBox(height: 24,),
            ],
          ),
        ),
      )
    ])));
  }
}
