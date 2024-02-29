import 'package:agenda_pastora_app/helpers/mask.dart';
import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/repositories/member_repository.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final repository = MemberRepoistory();
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final cpf = TextEditingController();

  bool loading = false;
  bool isCreated = false;

  void handleErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> handleSubmit() async {
    try {
      setState(() {
        loading = true;
      });
      if (_formKey.currentState!.validate()) {
        var response = await repository.create(
          Member(
            name: name.text,
            email: email.text,
            phone: phone.text,
            cpf: cpf.text,
            password: password.text,
          ),
        );

        if (response.member != null) {
          setState(() {
            isCreated = true;
          });
        } else {
          handleErrorMessage(response.errorMessage!);
        }
      }
    } catch (error) {
      handleErrorMessage(error.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isCreated
          ? Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 48),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/user_created.jpg',
                      width: 300,
                    ),
                    const Text(
                      'Usuário criado com sucesso.',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ButtonPrimary(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/login'),
                        title: 'Entrar'),
                  ]),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 48),
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
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
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
                        placeholder: 'Insira seu nome completo',
                        required: true,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFieldPrimary(
                        controller: phone,
                        label: 'Telefone',
                        placeholder: 'Insira seu telefone',
                        formatter: [phoneFormatter],
                        type: TextInputType.number,
                        required: true,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFieldPrimary(
                        controller: cpf,
                        label: 'CPF',
                        placeholder: 'Insira seu CPF',
                        formatter: [cpfFormatter],
                        type: TextInputType.number,
                        required: true,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFieldPrimary(
                        controller: email,
                        label: 'Email',
                        placeholder: 'Insira seu email',
                        required: true,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFieldPrimary(
                        controller: password,
                        label: 'Senha',
                        placeholder: 'Insira sua senha',
                        obscureText: true,
                        required: true,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ButtonPrimary(
                          onPressed: handleSubmit,
                          isLoading: loading,
                          title: 'Cadastrar'),
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
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/login'),
                        title: 'Entrar',
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
