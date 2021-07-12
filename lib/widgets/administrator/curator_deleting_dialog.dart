import 'package:flutter/widgets.dart';
import 'package:topgo/api/curators.dart';
import 'package:topgo/models/simple_curator.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/dialog.dart';
import 'package:provider/provider.dart';

class CuratorDeletingDialog extends StatelessWidget {
  final SimpleCurator curator;
  const CuratorDeletingDialog({
    Key? key,
    required this.curator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogBox(
      title: 'Внимание!',
      height: 267,
      children: [
        Text(
          'Вы собираетесь удалить аккаунт\nданного куратора.' +
              '\n\nВы точно хотите это сделать?',
          style: TxtStyle.mainText,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
        Button(
          text: 'Принять',
          buttonType: ButtonType.Accept,
          onPressed: () async => {
            if (curator.id != null) await deleteCurator(context, curator),
            // TODO: BUG remove this bug
            context.read<User>().deleteCurator(curator),
            Navigator.pop(context),
          },
        ),
        SizedBox(height: 8),
        Button(
          text: 'Отказаться',
          buttonType: ButtonType.Decline,
          filled: false,
          onPressed: () async => Navigator.pop(context),
        ),
      ],
    );
  }
}
