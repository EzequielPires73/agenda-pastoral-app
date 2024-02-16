import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:agenda_pastora_app/widgets/cards/card-member.dart';
import 'package:agenda_pastora_app/widgets/dialogs/select_member.dart';
import 'package:agenda_pastora_app/widgets/typography/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MemberSelect extends StatefulWidget {
  final String title;
  final String placeholder;
  final Function(UserAbstract member) onSelect;

  const MemberSelect({
    super.key,
    required this.title,
    required this.placeholder,
    required this.onSelect,
  });

  @override
  State<MemberSelect> createState() => _MemberSelectState();
}

class _MemberSelectState extends State<MemberSelect> {
  Member? member;

  Future<void> showView() async {
    return showDialog(
      context: context,
      builder: (context) => SelectMember(
        onSelect: (memberSelected) {
          setState(() {
            member = memberSelected;
            widget.onSelect(memberSelected);
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
          member != null
              ? Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) => setState(() {
                        member = null;
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
                  child: CardMember(member: member!, onTap: () {}))
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
