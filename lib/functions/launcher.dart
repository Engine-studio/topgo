import 'package:topgo/api/general.dart';
import 'package:url_launcher/url_launcher.dart';

void call(phone) async => await canLaunch('tel:+$phone')
    ? await launch('tel:+$phone')
    : throw 'Could not launch ${'tel:+$phone'}';

void openDoc(source) async => await canLaunch('https://$host/$source')
    ? launch('http://docs.google.com/viewer?url=https://$host/$source')
    : throw 'Could not launch $source';
