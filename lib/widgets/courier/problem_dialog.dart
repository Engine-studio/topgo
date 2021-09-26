import 'package:flutter/widgets.dart';
import 'package:topgo/functions/launcher.dart';
import 'package:topgo/models/simple_curator.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/dialog.dart';

class ProblemDialog extends StatelessWidget {
  final SimpleCurator curator;

  const ProblemDialog({
    Key? key,
    required this.curator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(curator);
    return DialogBox(
      title: 'Чрезвычайное происшествие',
      height: 403,
      children: [
        Text(
          'Если у вас произошло что-то ' +
              'непредвиденное, свяжитесь ' +
              'с куратором и ждите ' +
              'дальшейших указаний',
          style: TxtStyle.smallText,
          textAlign: TextAlign.center,
        ),
        Spacer(),
        BorderBox(
          height: 117,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    curator.photo,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(flex: 28),
                      Text(
                        curator.fullName,
                        style: TxtStyle.selectedMainText,
                      ),
                      Spacer(flex: 12),
                      Text(curator.phone, style: TxtStyle.smallText),
                      Spacer(flex: 28),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Button(
          text: 'Позвонить',
          buttonType: ButtonType.Accept,
          onPressed: () async => call(curator.phoneSource),
        ),
        SizedBox(height: 8),
        Button(
          text: 'Назад',
          buttonType: ButtonType.Decline,
          filled: false,
          onPressed: () async => Navigator.pop(context),
        ),
      ],
    );
  }
}
