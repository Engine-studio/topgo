import 'package:flutter/widgets.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/courier/profile_photo.dart';
import 'package:provider/provider.dart';

class CuratorAndAdminProfileCard extends StatelessWidget {
  const CuratorAndAdminProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderBox(
      height: 117,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: [
            ProfilePhoto(),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 28),
                  Text(
                    context.read<User>().fullName,
                    style: TxtStyle.selectedMainText,
                  ),
                  Spacer(flex: 12),
                  Text(context.read<User>().phone, style: TxtStyle.smallText),
                  Spacer(flex: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
