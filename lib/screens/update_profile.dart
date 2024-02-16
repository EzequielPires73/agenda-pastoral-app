import 'dart:convert';

import 'package:agenda_pastora_app/controllers/auth_controller.dart';
import 'package:agenda_pastora_app/models/member.dart';
import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/repositories/member_repository.dart';
import 'package:agenda_pastora_app/repositories/user_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_secondary.dart';
import 'package:agenda_pastora_app/widgets/form_components/text_field_primary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late final SharedPreferences shared;
  late final AuthController _authController;
  final MemberRepoistory _memberRepository = MemberRepoistory();
  final UserRepoistory _userRepoistory = UserRepoistory();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final cpf = TextEditingController();
  late final Member? member;
  late final User? user;
  int type = 1;

  void handleErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> hydrate() async {
    shared = await SharedPreferences.getInstance();
    final memberData = shared.getString('member');
    final userData = shared.getString('user');

    if (memberData != null) {
      member = Member.fromJson(jsonDecode(memberData));
      email.text = member?.email ?? '';
      name.text = member?.name ?? '';
      phone.text = member?.phone ?? '';
      cpf.text = member?.cpf ?? '';

      setState(() {
        type = 2;
      });
    } else if (userData != null) {
      user = User.fromJson(jsonDecode(userData));
      email.text = user?.email ?? '';
      name.text = user?.name ?? '';
      phone.text = user?.phone ?? '';
      cpf.text = '';
      setState(() {
        type = 1;
      });
    }
  }

  Future<void> handleSubmit() async {
    if ((type == 1) && (user != null) && (user!.id != null)) {
      var res = await _userRepoistory.update(
        member!.id!,
        User(
          name: name.text,
          email: email.text,
          phone: phone.text,
        ),
      );

      if (res.errorMessage != null) handleErrorMessage(res.errorMessage!);
      if (res.user != null) {
        handleErrorMessage('Dados atualizados com sucesso.');
        await _authController.changeUser(res.user!);
      }
    } else if ((type == 2) && (member != null) && (member!.id != null)) {
      var res = await _memberRepository.update(
        member!.id!,
        Member(
          name: name.text,
          email: email.text,
          phone: phone.text,
          cpf: cpf.text,
        ),
      );

      if (res.errorMessage != null) handleErrorMessage(res.errorMessage!);
      if (res.member != null) {
        handleErrorMessage('Dados atualizados com sucesso.');
        await _authController.changeMember(res.member!);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authController = context.read<AuthController>();
    hydrate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 80,
        title: const Text(
          'Editar Perfil',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFieldPrimary(
                controller: name,
                label: 'Nome',
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldPrimary(
                controller: phone,
                label: 'Telefone',
              ),
              type == 2
                  ? const SizedBox(
                      height: 24,
                    )
                  : Container(),
              type == 2
                  ? TextFieldPrimary(
                      controller: cpf,
                      label: 'CPF',
                    )
                  : Container(),
              const SizedBox(
                height: 24,
              ),
              TextFieldPrimary(
                controller: email,
                label: 'Email',
              ),
              const SizedBox(
                height: 24,
              ),
              ButtonPrimary(onPressed: handleSubmit, title: 'Atualizar'),
              const SizedBox(
                height: 24,
              ),
              ButtonSecondary(onPressed: () => {}, title: 'Atualizar senha'),
            ],
          ),
        ),
      ),
    );
  }
}
