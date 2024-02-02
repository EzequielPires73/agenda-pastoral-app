import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_secondary.dart';
import 'package:agenda_pastora_app/widgets/form_components/text_field_primary.dart';
import 'package:flutter/material.dart';

class CreateMemberAdminPage extends StatefulWidget {
  const CreateMemberAdminPage({super.key});

  @override
  State<CreateMemberAdminPage> createState() => _CreateMemberAdminPageState();
}

class _CreateMemberAdminPageState extends State<CreateMemberAdminPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final cpf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorPalette.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          toolbarHeight: 80,
          title: const Text(
            'Cadastrar membro',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFieldPrimary(
                  controller: name,
                  label: 'Nome',
                  placeholder: 'Insira seu nome completo'),
              const SizedBox(
                height: 24,
              ),
              TextFieldPrimary(
                  controller: phone,
                  label: 'Telefone',
                  placeholder: 'Insira seu telefone'),
              const SizedBox(
                height: 24,
              ),
              TextFieldPrimary(
                  controller: cpf,
                  label: 'CPF',
                  placeholder: 'Insira seu CPF'),
              const SizedBox(
                height: 24,
              ),
              TextFieldPrimary(
                  controller: email,
                  label: 'Email',
                  placeholder: 'Insira seu email'),
              const SizedBox(
                height: 24,
              ),
              TextFieldPrimary(
                  controller: password,
                  label: 'Password',
                  placeholder: 'Insira sua senha',
                  obscureText: true),
              const SizedBox(
                height: 24,
              ),
              ButtonPrimary(onPressed: () => {}, title: 'Cadastrar'),
            ],
          ),
        ),
      ),
    );
  }
}