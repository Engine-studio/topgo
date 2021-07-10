import 'package:url_launcher/url_launcher.dart';

Future<void> call(String phone) async => await canLaunch('tel:$phone')
    ? await launch('tel:$phone')
    : throw 'Could not launch tel:$phone';
