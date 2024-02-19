import 'package:agenda_pastora_app/helpers/mask.dart';
import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/repositories/member_repository.dart';
import 'package:agenda_pastora_app/repositories/user_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_secondary.dart';
import 'package:agenda_pastora_app/widgets/form_components/text_field_primary.dart';
import 'package:flutter/material.dart';

class CreateResponsibleAdminPage extends StatefulWidget {
  const CreateResponsibleAdminPage({super.key});

  @override
  State<CreateResponsibleAdminPage> createState() =>
      _CreateResponsibleAdminPageState();
}

class _CreateResponsibleAdminPageState
    extends State<CreateResponsibleAdminPage> {
  final UserRepoistory _userRepoistory = UserRepoistory();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final cpf = TextEditingController();
  bool loading = false;
  String? type = 'shepherd';

  void handleErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> handleSubmit() async {
    setState(() {
      loading = true;
    });

    if (_formKey.currentState!.validate()) {
      var res = await _userRepoistory.create(User(
        name: name.text,
        email: email.text,
        phone: phone.text,
        password: password.text,
        type: type,
      ));

      if (res.errorMessage != null) handleErrorMessage(res.errorMessage!);
      if (res.user != null) Navigator.pop(context);
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 80,
        title: const Text(
          'Cadastrar Responsável',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  label: 'Password',
                  placeholder: 'Insira sua senha',
                  obscureText: true,
                  required: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tipo de usuário',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    ListTile(
                      title: const Text('Administrador'),
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      onTap: () => setState(() {
                        type = 'admin';
                      }),
                      leading: Radio<String>(
                        value: 'admin',
                        groupValue: type,
                        onChanged: (String? value) {
                          setState(() {
                            type = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Pastor'),
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      onTap: () => setState(() {
                        type = 'shepherd';
                      }),
                      leading: Radio<String>(
                        value: 'shepherd',
                        groupValue: type,
                        onChanged: (String? value) {
                          setState(() {
                            type = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Pastor Presidente'),
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      onTap: () => setState(() {
                        type = 'shepherd_president';
                      }),
                      leading: Radio<String>(
                        value: 'shepherd_president',
                        groupValue: type,
                        onChanged: (String? value) {
                          setState(() {
                            type = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                ButtonPrimary(
                    onPressed: handleSubmit,
                    isLoading: loading,
                    title: 'Cadastrar'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
