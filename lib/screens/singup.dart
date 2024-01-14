import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_secondary.dart';
import 'package:agenda_pastora_app/widgets/form_components/text_field_primary.dart';
import 'package:flutter/material.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final cpf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo_v.png',
                width: 134,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Junte-se à Agenda Pastoral',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.primary),
              ),
              const Text(
                'Crie sua conta',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 24,
              ),
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
              const SizedBox(
                height: 24,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'Já tem uma conta?',
                  style: TextStyle(color: ColorPalette.gray5),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ButtonSecondary(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                title: 'Entrar',
              )
            ],
          ),
        ),
      ),
    );
  }
}
