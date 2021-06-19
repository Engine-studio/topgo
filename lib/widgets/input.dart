import 'package:flutter/material.dart';
import 'package:topgo/styles.dart';

class Input extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const Input({Key? key, required this.text, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6A9DD9).withOpacity(0.15),
            blurRadius: 3,
          )
        ],
      ),
      child: TextField(
        controller: this.controller,
        obscureText: this.text == 'Пароль',
        style: TxtStyle.selectedMainText,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintStyle: TxtStyle.mainText,
          hintText: this.text,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        ),
      ),
    );
  }
}
