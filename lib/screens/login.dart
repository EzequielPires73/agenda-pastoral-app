import 'package:agenda_pastora_app/models/custom_notification.dart';
import 'package:agenda_pastora_app/services/notification_service.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_secondary.dart';
import 'package:agenda_pastora_app/widgets/form_components/text_field_primary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  showNotification() {
    Provider.of<NotificationService>(context, listen: false).showNotification(
      CustomNotification(id: 1, title: 'Teste', body: 'Acesse o app', payload: '/notificacao')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Conecte-se ao Pastor',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.primary),
              ),
              const Text(
                'Faça seu login',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
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
              Container(
                alignment: Alignment.centerRight,
                child: const InkWell(child: Text('Esqueceu sua senha?', style: TextStyle(fontWeight: FontWeight.w600),)),
              ),
              const SizedBox(
                height: 24,
              ),
              ButtonPrimary(onPressed: () => showNotification(), title: 'Entrar'),
              const SizedBox(
                height: 24,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text('Não tem uma conta?', style: TextStyle(color: ColorPalette.gray5),),
              ),
              const SizedBox(
                height: 24,
              ),
              ButtonSecondary(
                onPressed: () => Navigator.pushNamed(context, '/singup'),
                title: 'Quero me cadastrar',
              )
            ],
          ),
        ),
      ),
    );
  }
}
