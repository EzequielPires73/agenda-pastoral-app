import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:agenda_pastora_app/widgets/cards/card-member.dart';
import 'package:agenda_pastora_app/widgets/dialogs/select_member.dart';
import 'package:agenda_pastora_app/widgets/dialogs/select_responsible.dart';
import 'package:agenda_pastora_app/widgets/typography/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class UserSelect extends StatefulWidget {
  final String title;
  final String placeholder;
  final Function(UserAbstract user) onSelect;

  const UserSelect({
    super.key,
    required this.title,
    required this.placeholder,
    required this.onSelect,
  });

  @override
  State<UserSelect> createState() => _UserSelectState();
}

class _UserSelectState extends State<UserSelect> {
  UserAbstract? user;

  Future<void> showView() async {
    return showDialog(
      context: context,
      builder: (context) => SelectResponsible(
        onSelect: (userSelected) {
          setState(() {
            user = userSelected;
            widget.onSelect(userSelected);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(text: widget.title),
          const SizedBox(
            height: 8,
          ),
          user != null
              ? Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) => setState(() {
                        user = null;
                      }),
                  background: const SizedBox(
                    width: 64,
                    child: Card(
                      color: ColorPalette.redLight,
                      child: Icon(
                        FeatherIcons.trash,
                        color: ColorPalette.red,
                      ),
                    ),
                  ),
                  child: CardMember(member: user!, onTap: () {}))
              : InkWell(
                  onTap: showView,
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: ColorPalette.input,
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(color: const Color(0xffeeeeee), width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.placeholder,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: ColorPalette.gray7,
                          ),
                        ),
                        const Icon(
                          FeatherIcons.chevronRight,
                          color: ColorPalette.gray5,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
