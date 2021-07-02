import 'package:flutter/material.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/dialog.dart';

enum DiscardType {
  Full,
  Cash,
  Terminal,
  Salary,
}

class CourierDiscardDialog extends StatefulWidget {
  const CourierDiscardDialog({Key? key}) : super(key: key);

  @override
  _CourierDiscardDialogState createState() => _CourierDiscardDialogState();
}

class _CourierDiscardDialogState extends State<CourierDiscardDialog> {
  DiscardType? discard = DiscardType.Full;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: Colors.white),
      child: DialogBox(
        title: 'Сбросить показатели',
        height: 311,
        children: [
          ...DiscardType.values.map(
            (value) => Container(
              width: double.infinity,
              height: 16,
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: ShaderMask(
                      shaderCallback: (bounds) => GrdStyle()
                          .panelGradient(context)
                          .createShader(bounds),
                      child: Transform.scale(
                        scale: 0.85,
                        child: Radio<DiscardType>(
                          activeColor: Colors.white,
                          splashRadius: 0,
                          //title: Text('Сбросить все', style: TxtStyle.mainText),
                          value: value,
                          groupValue: discard,
                          onChanged: (DiscardType? value) {
                            setState(() {
                              discard = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    value == DiscardType.Full
                        ? 'Сбросить все'
                        : value == DiscardType.Cash
                            ? 'Оплата наличными'
                            : value == DiscardType.Terminal
                                ? 'Оплата по терминалу'
                                : 'Заработная плата',
                    style: TxtStyle.smallText,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Button(
            text: 'Сбросить',
            buttonType: ButtonType.Accept,
            onPressed: () => {
              //TODO: implement discard function
              Navigator.pop(context),
            },
          ),
          SizedBox(height: 8),
          Button(
            text: 'Отказаться',
            buttonType: ButtonType.Decline,
            filled: false,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
