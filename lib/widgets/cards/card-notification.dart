import 'package:agenda_pastora_app/controllers/auth_controller.dart';
import 'package:agenda_pastora_app/models/notification.dart';
import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardNotification extends StatelessWidget {
  final AppointmentNotification notification;

  const CardNotification({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    UserAbstract? user = notification.destination == 'user' ? notification.member : notification.user;
    return InkWell(
      onTap: () => notification.appointment != null ? Navigator.pushNamed(context, '/details_appointments', arguments: {"id": notification.appointment?.id}) : null,
      child: SizedBox(
        child: Row(
          children: [
            Avatar(
              image: user?.avatar,
              name: user?.name ?? 'AD Catalão',
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    notification.body,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
