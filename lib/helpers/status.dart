import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

getStatusText(String status) {
    String title;
    switch (status) {
      case 'confirmado':
        title = 'Confirmado';
        break;
      case 'pendente':
        title = 'Pendente';
        break;
      case 'finalizado':
        title = 'Finalizado';
        break;
      case 'declinado':
        title = 'Declinado';
        break;

      default:
        title = 'Pendente';
    }

    return title;
  }

  getColor(status) {
    Color color;
    switch (status) {
      case 'confirmado':
        color = ColorPalette.green;
        break;
      case 'pendente':
        color = ColorPalette.primary;
        break;
      case 'finalizado':
        color = ColorPalette.blue;
        break;
      case 'declinado':
        color = ColorPalette.red;
        break;

      default:
        color = ColorPalette.primary;
    }

    return color;
  }

  getBackground(status) {
    Color color;
    switch (status) {
      case 'confirmado':
        color = ColorPalette.greenLight;
        break;
      case 'pendente':
        color = ColorPalette.primaryLight;
        break;
      case 'finalizado':
        color = ColorPalette.blueLight;
        break;
      case 'declinado':
        color = ColorPalette.redLight;
        break;

      default:
        color = ColorPalette.primary;
    }

    return color;
  }