import 'package:agenda_pastora_app/helpers/mask.dart';
import 'package:agenda_pastora_app/models/appointment_category.dart';
import 'package:agenda_pastora_app/repositories/appointment_category_repository.dart';
import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:agenda_pastora_app/widgets/buttons/button_primary.dart';
import 'package:agenda_pastora_app/widgets/form_components/text_field_primary.dart';
import 'package:agenda_pastora_app/widgets/header_pages.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateCategoryAdminPage extends StatefulWidget {
  const CreateCategoryAdminPage({super.key});

  @override
  State<CreateCategoryAdminPage> createState() =>
      _CreateCategoryAdminPageState();
}

class _CreateCategoryAdminPageState extends State<CreateCategoryAdminPage> {
  final AppointmentCategoryRepository _repository =
      AppointmentCategoryRepository();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final description = TextEditingController();
  final duration = TextEditingController();

  bool loading = false;

  void handleErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: ColorPalette.redLight,
        content: Text(
          message,
          style: TextStyle(color: ColorPalette.red),
        )));
  }

  handleSubmit() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      var res = await _repository.create(
          AppointmentCategory(
            name: name.text,
            duration: int.parse(duration.text),
          ),
          null);

      if (res.errorMessage != null) handleErrorMessage(res.errorMessage!);
      if (res.category != null) Navigator.pop(context);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: HeaderPages(
            title: 'Cadastrar Categoria',
          ),
          preferredSize: Size(double.infinity, 80)),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                  placeholder: 'Insira o nome da categoria',
                  required: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFieldPrimary(
                  controller: duration,
                  label: 'Duração',
                  placeholder: 'Insira a duração em minutos da categoria',
                  type: TextInputType.number,
                  required: true,
                  formatter: [durationFormatter],
                ),
                const SizedBox(
                  height: 24,
                ),
                ButtonPrimary(
                    onPressed: handleSubmit,
                    isLoading: false,
                    title: 'Cadastrar'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
