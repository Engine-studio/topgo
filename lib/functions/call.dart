import 'package:url_launcher/url_launcher.dart';

void call(phone) async => await canLaunch('tel:+$phone')
    ? await launch('tel:+$phone')
    : throw 'Could not launch ${'tel:+$phone'}';
