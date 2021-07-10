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
  final TextEditingController loginController, passwordController;

  LoginPage({Key? key})
      : loginController = TextEditingController(),
        passwordController = TextEditingController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Input(text: 'Логин', controller: this.loginController),
              SizedBox(height: 24),
              Input(text: 'Пароль', controller: this.passwordController),
              SizedBox(height: 40),
              Button(
                text: 'Вход',
                buttonType: ButtonType.Select,
                onPressed: () async {
                  if (loginController.text != '' &&
                      passwordController.text != '') {
                    User user = await logIn(context);
                    if (user.logined) {
                      context.read<User>().copy(user);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => MenuPage(),
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
