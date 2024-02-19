import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var durationFormatter = MaskTextInputFormatter(
    mask: "###",
    filter: {"#": RegExp(r'[0-9]')},
  );

var cpfFormatter = MaskTextInputFormatter(
    mask: "###.###.###-##",
    filter: {"#": RegExp(r'[0-9]')},
  );

var phoneFormatter = MaskTextInputFormatter(
    mask: "(##) #####-####",
    filter: {"#": RegExp(r'[0-9]')},
  );