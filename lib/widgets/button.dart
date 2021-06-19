import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';

enum ButtonType {
  Accept,
  Decline,
  Select,
}

class Button extends StatefulWidget {
  final String text;
  final ButtonType buttonType;
  final void Function() onPressed;

  const Button({
    Key? key,
    required this.text,
    required this.buttonType,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ButtonState createState() =>
      _ButtonState(this.text, this.buttonType, this.onPressed);
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  final String _text;
  final ButtonType _buttonType;
  final void Function() onPressed;

  _ButtonState(this._text, this._buttonType, this.onPressed);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      reverseDuration: Duration(milliseconds: 0),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
    onPressed();
  }

  void _tapDown(TapDownDetails details) => _controller.forward();

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: _buttonType == ButtonType.Accept
                ? GrdStyle.accept
                : _buttonType == ButtonType.Decline
                    ? GrdStyle.decline
                    : GrdStyle.select,
          ),
          child: Center(
            child: Text(
              this._text,
              style: TxtStyle.button.copyWith(color: ClrStyle.lightBackground),
            ),
          ),
        ),
      ),
    );
  }
}
