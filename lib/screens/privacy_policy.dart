import 'package:agenda_pastora_app/utils/colors.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 80,
        title: const Text(
          'Politica de privacidade',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Política de Privacidade',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Última atualização: 15 de fevereiro de 2024',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'A equipe por trás do aplicativo "Agenda Pastoral AD Catalão" está comprometida em proteger a sua privacidade. Esta Política de Privacidade descreve como suas informações pessoais são coletadas, usadas e compartilhadas quando você utiliza nosso aplicativo.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Informações que Coletamos',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- Informações de Conta: Podemos coletar informações como nome, endereço de e-mail e outras informações de contato que você fornecer voluntariamente ao criar uma conta ou usar determinados recursos do aplicativo.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Informações de Uso: Podemos coletar informações sobre como você utiliza o aplicativo, como as páginas que visita, as funcionalidades que utiliza e outras estatísticas de uso.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Como Utilizamos Suas Informações',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'As informações que coletamos podem ser utilizadas para:',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Fornecer e manter o aplicativo;',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Personalizar sua experiência dentro do aplicativo;',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Enviar-lhe atualizações, notificações e outras comunicações relacionadas ao aplicativo;',
              style: TextStyle(fontSize: 16.0),
            ),
            // Adicione mais informações sobre o uso das informações conforme necessário
            SizedBox(height: 20.0),
            Text(
              'Compartilhamento de Informações',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Não compartilhamos suas informações pessoais com terceiros, exceto quando necessário para oferecer suporte e manter o funcionamento do aplicativo ou quando exigido por lei.',
              style: TextStyle(fontSize: 16.0),
            ),
            // Adicione mais informações sobre compartilhamento de informações conforme necessário
            SizedBox(height: 20.0),
            Text(
              'Segurança',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Valorizamos a segurança de suas informações pessoais e adotamos medidas razoáveis para protegê-las contra acesso não autorizado, uso indevido ou divulgação.',
              style: TextStyle(fontSize: 16.0),
            ),
            // Adicione mais informações sobre segurança conforme necessário
            SizedBox(height: 20.0),
            Text(
              'Seus Direitos',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Você tem o direito de acessar, corrigir ou excluir suas informações pessoais a qualquer momento. Se desejar exercer esses direitos ou tiver alguma dúvida sobre esta Política de Privacidade, entre em contato conosco utilizando as informações fornecidas abaixo.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Alterações a Esta Política de Privacidade',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Podemos atualizar esta Política de Privacidade de tempos em tempos. Recomendamos que você revise periodicamente esta página para estar ciente de quaisquer alterações. As alterações nesta Política de Privacidade são efetivas quando publicadas nesta página.',
              style: TextStyle(fontSize: 16.0),
            ),
            // Adicione mais informações sobre alterações à política de privacidade conforme necessário
            SizedBox(height: 20.0),
            Text(
              'Contato',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Se tiver alguma dúvida ou preocupação sobre esta Política de Privacidade ou sobre como tratamos suas informações pessoais, entre em contato conosco pelo e-mail [inserir e-mail de contato].',
              style: TextStyle(fontSize: 16.0),
            ),
            // Adicione mais informações de contato conforme necessário
          ],
        ),
      ),
    );
  }
}
