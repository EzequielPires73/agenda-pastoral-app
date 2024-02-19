import 'package:agenda_pastora_app/models/appointment_category.dart';
import 'package:agenda_pastora_app/repositories/appointment_category_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_icon.dart';
import 'package:agenda_pastora_app/widgets/custom_alert_dialog.dart';
import 'package:agenda_pastora_app/widgets/typography/span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CardCategory extends StatelessWidget {
  final AppointmentCategory category;
  final Function() onRemove;
  CardCategory({super.key, required this.category, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    Future<void> showMyDialogCancel() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CustomAlertDialog(
              title: 'Remover Categoria',
              subtitle: 'Deseja mesmo remover a categoria ${category.name}?',
              onChange: onRemove,
          );
        }
      );
    }
    
    return Card(
      elevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffDDDDDD), width: 1),
            borderRadius: BorderRadius.circular(8)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category.name),
              const SizedBox(
                height: 4,
              ),
              Span(text: 'Duração: ${category.duration} minutos'),
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          Row(
            children: [
              ButtonIcon(
                icon: FeatherIcons.trash,
                color: ColorPalette.red,
                background: ColorPalette.redLight,
                onPressed: showMyDialogCancel,
              ),
            ],
          )
        ]),
      ),
    );
  }
}
