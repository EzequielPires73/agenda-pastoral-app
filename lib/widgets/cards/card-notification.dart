import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:flutter/material.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Row(
          children: [
            const Avatar(
                image: 'https://avatars.githubusercontent.com/u/145378534?v=4'),
                const SizedBox(width: 16,),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const [
                    TextSpan(
                      text: 'Ezequiel Pires',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    TextSpan(
                        text: ' Marcou um agendamento Pastoral no dia 17/01 às 09:00'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
