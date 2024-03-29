import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldPrimary extends StatelessWidget {
  final String label;
  final String? placeholder;
  final TextEditingController controller;
  final bool obscureText;
  final bool? required;
  final int? maxLines;
  final TextInputType? type;
  final List<TextInputFormatter>? formatter;

  const TextFieldPrimary(
      {super.key,
      required this.controller,
      required this.label,
      this.obscureText = false,
      this.required,
      this.placeholder,
      this.formatter,
      this.maxLines,
      this.type
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 6,
        ),
        TextFormField(
          validator: (value) {
            if (required == true && (value == '' || value == null)) {
              return 'Preencha um valor';
            } else return null;
          },
          controller: controller,
          inputFormatters: formatter,
          obscureText: obscureText,
          maxLines: maxLines ?? 1,
          keyboardType: type,
          decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: ColorPalette.gray7),
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              hintText: placeholder ?? '',
              fillColor: ColorPalette.input,
              filled: true,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffeeeeee)),
              ),
              border: const OutlineInputBorder()),
        )
      ],
    );
  }
}
