import 'package:url_launcher/url_launcher.dart';

void launchPhone(String phone) async {
  final phoneNumber = Uri.parse('tel:${phone}');
  print(phoneNumber);
  if (await canLaunchUrl(phoneNumber)) {
    await launchUrl(phoneNumber);
  } else {
    throw 'Não foi possível abrir o número de telefone.';
  }
}

void openWhatsApp(String phoneNumber) async {
  final url = Uri.parse("https://api.whatsapp.com/send?phone=$phoneNumber");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
