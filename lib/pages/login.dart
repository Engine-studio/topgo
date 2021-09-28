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

class LoginPage extends StatefulWidget {
  final bool init;
  const LoginPage({Key? key, this.init = true}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late MaskedTextController phone;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    phone = MaskedTextController(mask: '+0 (000) 000-00-00');
    password = TextEditingController();
  }

  @override
  void dispose() {
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String number;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    context.read<User>().copy(user);

                    if (user.logined &&
                        !(user.courier != null && user.courier!.deleted))
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MenuPage(),
                        ),
                      );
                    else
                      password.text = '';
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
