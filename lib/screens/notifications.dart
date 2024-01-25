import 'package:agenda_pastora_app/controllers/auth_controller.dart';
import 'package:agenda_pastora_app/models/notification.dart';
import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/repositories/notification_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/cards/card-notification.dart';
import 'package:agenda_pastora_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final AuthController _controller;
  final NotificationRepository _repository = NotificationRepository();
  List<AppointmentNotification> notifications = [];

  Future<void> findNotifications() async {
    final shared = await SharedPreferences.getInstance();
    final accessToken = shared.getString('member.access_token') ?? shared.getString('user.access_token');
    List<AppointmentNotification> res = await _repository.findAll(_controller.user != null ? 'user' : 'member', accessToken);

    setState(() {
      notifications = res;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = context.read<AuthController>();
    findNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const Header(),
              Container(
                width: double.infinity,
                transform: Matrix4.translationValues(0, -16, 0),
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                  top: 32,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const SizedBox(
                  child: Column(
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          sliver: SliverList.separated(
            itemCount: notifications.length,
            itemBuilder: (context, index) => CardNotification(notification: notifications[index]),
            separatorBuilder: (context, index) => const SizedBox(
              height: 24,
            ),
          ),
        ),
      ]),
    );
  }
}
