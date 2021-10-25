import 'package:flutter/material.dart';

class ApiError {
  String route;
  int code;
  String text;

  ApiError({required this.route, required this.code, required this.text}) {
    if (this.text ==
        'error decoding response body: expected value at line 1 column 1') {
      this.text = 'Geocoding API error';
    }
  }

  void show(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Ошибка #$code.\n\n' +
              'Запрос: ${route.replaceFirst('/api', '')}\n\n' +
              'Сообщение: <' +
              text[0].toUpperCase() +
              text.substring(1) +
              '>',
        ),
      ));
}
