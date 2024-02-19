import 'package:agenda_pastora_app/controllers/auth_controller.dart';
import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    final UserAbstract? user = controller.member ?? controller.user;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 25, right: 25, top: 48, bottom: 32),
      color: ColorPalette.primary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          user != null
              ? Avatar(
                  image: user.avatar?.isNotEmpty == true ? user.avatar : null,
                  name: user.name,
                  color: Colors.white,
                )
              : Container(),
          const SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, ${user?.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    children: [
                      TextSpan(text: 'Bem-vindo ao '),
                      TextSpan(
                        text: 'Agenda Pastoral',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
                /* const SizedBox(width: 12,),
                IconButton(onPressed: () {}, padding: EdgeInsets.zero, icon: Icon(FeatherIcons.bell, color: Colors.white,)) */
          
        ],
      ),
    );
  }
}
