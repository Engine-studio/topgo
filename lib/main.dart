import 'package:flutter/material.dart';
import 'package:topgo/styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Заголовок",
                    style: TxtStyle.mainHeader,
                  ),
                  Text(
                    "Заголовок",
                    style: TxtStyle.smallHeader,
                  ),
                  Text(
                    "Кнопка",
                    style: TxtStyle.button,
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Основной текст",
                    style: TxtStyle.mainText,
                  ),
                  Text(
                    "Основной текст выделение",
                    style: TxtStyle.selectedMainText,
                  ),
                  Text("Основной маленький", style: TxtStyle.smallText),
                  Text(
                    "Основной маленький выделение",
                    style: TxtStyle.selectedSmallText,
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
