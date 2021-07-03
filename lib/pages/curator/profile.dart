import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/button.dart';
import 'package:topgo/widgets/curator/notification_dialog.dart';
import 'package:topgo/widgets/curator/profile_card.dart';

class CuratorAndAdminProfileTab extends StatelessWidget {
  const CuratorAndAdminProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          CuratorAndAdminProfileCard(),
          SizedBox(height: 16),
          Button(
            text: 'Создать уведомление',
            buttonType: ButtonType.Panel,
            onPressed: () => showDialog(
              context: context,
              builder: (_) {
                return ChangeNotifierProvider.value(
                  value: Provider.of<User>(context, listen: false),
                  child: NotificationDialog(),
                );
              },
            ),
          ),
          Spacer(flex: 96),
          Text(
            'Вы можете создавать\nуведомления, которые увидят\nвсе курьеры',
            style: TxtStyle.mainText,
            textAlign: TextAlign.center,
          ),
          Spacer(flex: 297),
        ],
      ),
    );
  }
}
