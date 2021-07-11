import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/api/general.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/pages/menu.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/input.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final MaskedTextController phone;
  final TextEditingController password;

  LoginPage({Key? key})
      : phone = MaskedTextController(mask: '+0 (000) 000-00-00'),
        password = TextEditingController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String number;
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 78,
          horizontal: 50,
        ),
        decoration: BoxDecoration(gradient: GrdStyle.splash),
        child: SafeArea(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 50,
              ),
              SizedBox(height: 40),
              Input(text: 'Логин', controller: phone),
              SizedBox(height: 24),
              Input(text: 'Пароль', controller: password),
              SizedBox(height: 40),
              Button(
                text: 'Вход',
                buttonType: ButtonType.Select,
                onPressed: () async {
                  number = phone.text;
                  for (String str in ['+', '(', ')', '-', ' '])
                    number = number.replaceAll(str, '');
                  if (number.length == 11 && password.text != '') {
                    User user = await logInFirst(number, password.text);
                    if (user.logined) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ChangeNotifierProvider<User>(
                            create: (context) => user,
                            child: MenuPage(),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
