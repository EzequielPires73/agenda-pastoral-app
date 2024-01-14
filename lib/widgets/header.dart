import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 25, right: 25, top: 48, bottom: 32),
      color: ColorPalette.primary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá, Gustavo Neves',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Bem-vindo ao Agenda Pastoral',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(64),
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(64),
              child: Image.network(
                  'https://img.freepik.com/fotos-gratis/retrato-de-homem-feliz-e-sorridente_23-2149022620.jpg?size=626&ext=jpg&ga=GA1.1.1412446893.1705190400&semt=ais',
                  fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }
}
