import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/avatar.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_cancel.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_confirm.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_secondary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class DetailsAppointments extends StatefulWidget {
  const DetailsAppointments({super.key});

  @override
  State<DetailsAppointments> createState() => _DetailsAppointmentsState();
}

class _DetailsAppointmentsState extends State<DetailsAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          toolbarHeight: 80,
          title: const Text(
            'Agendamento',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aconselhamento Pastoral',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.gray3,
                  ),
                ),
                /* const SizedBox(
                  height: 24,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pr. Cornélio Neto',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorPalette.gray3,
                          ),
                        ),
                        Text(
                          'Pastor Presidente',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ColorPalette.gray5,
                          ),
                        ),
                      ],
                    ),
                    Avatar(
                      image:
                          'https://adcatalao.nyc3.digitaloceanspaces.com/wp-content/uploads/2018/04/FOTO-PASTORES-DO-CAMPO-AD-CATAL%C3%83O.jpg',
                    )
                  ],
                ), */
                const SizedBox(
                  height: 24,
                ),
                const Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          FeatherIcons.calendar,
                          color: ColorPalette.primary,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text('20 de Janeiro')
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(
                          FeatherIcons.clock,
                          color: ColorPalette.primary,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text('09:00')
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(
                          FeatherIcons.checkCircle,
                          color: ColorPalette.primary,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text('Confirmado')
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Observação',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.gray3,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xffdddddd), width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                          'Busco orientação pastoral em relação a uma questão familiar e gostaria de receber aconselhamento.'),
                    )
                  ],
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    ButtonPrimary(
                      onPressed: () => {},
                      title: 'Alterar agendamento',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ButtonSecondary(
                      onPressed: _showMyDialog,
                      title: 'Cancelar agendamento',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text(
            'Cancelar Agendamento',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja mesmo cancelar o agendamento?'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: ButtonCancel(
                      onPressed: () => Navigator.of(context).pop(),
                      title: 'Cancelar'),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: ButtonConfirm(
                      onPressed: () => Navigator.of(context).pop(),
                      title: 'Confirmar'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
