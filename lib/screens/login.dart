import 'package:agenda_pastora_app/controllers/auth_controller.dart';
import 'package:agenda_pastora_app/models/custom_notification.dart';
import 'package:agenda_pastora_app/services/firebase_messaging_service.dart';
import 'package:agenda_pastora_app/services/notification_service.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_secondary.dart';
import 'package:agenda_pastora_app/widgets/form_components/text_field_primary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthController controller;
  final email = TextEditingController();
  final password = TextEditingController();
  late final String? tokenNotification;

  /* showNotification() {
    Provider.of<NotificationService>(context, listen: false).showNotification(
      CustomNotification(id: 1, title: 'Teste', body: 'Acesse o app', payload: '/notificacao')
    );
  } */

  Future<void> _handleSubmit() async {
    controller.singinMember(
        email.value.text, password.value.text);
  }

  void _authListener() {
    AuthState state = controller.state;
    switch (state) {
      case AuthState.idle:
        break;
      case AuthState.success:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case AuthState.error:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(controller.errorMsg)));
        break;
    }
  }

  Future<void> getNotificationToken() async {
    var notificationService = context.read<FirebaseMessagingService>();
    tokenNotification = await notificationService.getDeviceFirebaseToken();

    if (tokenNotification != null) {
      final shared = await SharedPreferences.getInstance();
      await shared.setString('tokenNotification', tokenNotification!);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = context.read<AuthController>();
    controller.addListener(_authListener);
    getNotificationToken();
  }

  @override
  void dispose() {
    controller.removeListener(_authListener);
    super.dispose();
  }

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
                'Conecte-se ao Pastor',
                style: TextStyle(
                    fontSize: 20,
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
                child: const InkWell(
                    child: Text(
                  'Esqueceu sua senha?',
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),
              ),
              const SizedBox(
                height: 24,
              ),
              Consumer<AuthController>(
                builder: (context, value, child) => ButtonPrimary(
                  onPressed: _handleSubmit,
                  title: 'Entrar',
                  isLoading: value.isLoading,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'Não tem uma conta?',
                  style: TextStyle(color: ColorPalette.gray5),
                ),
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
