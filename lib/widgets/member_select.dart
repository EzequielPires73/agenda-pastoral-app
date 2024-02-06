import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/dialogs/select_member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MemberSelect extends StatefulWidget {
  final String title;
  final String placeholder;
  const MemberSelect(
      {super.key, required this.title, required this.placeholder});

  @override
  State<MemberSelect> createState() => _MemberSelectState();
}

class _MemberSelectState extends State<MemberSelect> {
  Future<void> showView() async {
    return showDialog(
      context: context,
      builder: (context) => const SelectMember(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorPalette.gray3,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: showView,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: ColorPalette.input,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xffeeeeee), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.placeholder,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.gray5,
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