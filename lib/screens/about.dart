import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 80,
        title: const Text(
          'Sobre o App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Agenda Pastoral AD Catalão',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Bem-vindo à página oficial do aplicativo "Agenda Pastoral AD Catalão". Estamos felizes em apresentar a você uma ferramenta dedicada a facilitar e fortalecer a comunicação e organização dentro da comunidade religiosa da Assembleia de Deus em Catalão e região.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'O que é a Agenda Pastoral AD Catalão?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'A Agenda Pastoral AD Catalão é uma aplicação móvel desenvolvida para atender às necessidades específicas da comunidade da Assembleia de Deus em Catalão. Ela é projetada para auxiliar membros da igreja, líderes e todos os interessados a se manterem atualizados sobre eventos, cultos, estudos bíblicos e demais atividades da congregação.',
              style: TextStyle(fontSize: 16.0),
            ),
            // Adicione mais informações conforme necessário
          ],
        ),
      ),
    );
  }
}
