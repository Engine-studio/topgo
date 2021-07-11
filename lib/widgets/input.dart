import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:topgo/styles.dart';

// TODO: implement phone masked text input controller
class Input extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
  final MaskedTextController? maskedController;
  final bool multilined;

  const Input({
    Key? key,
    required this.text,
    this.controller,
    this.maskedController,
    this.multilined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: multilined ? 104 : 44,
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
        controller: controller ?? maskedController,
        obscureText: this.text == 'Пароль',
        style: TxtStyle.selectedMainText,
        cursorColor: Colors.black,
        maxLines: multilined ? null : 1,
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
