import 'package:flutter/widgets.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/courier/profile_photo.dart';
import 'package:topgo/widgets/courier/star_holder.dart';
import 'package:provider/provider.dart';

class CourierProfileCard extends StatelessWidget {
  const CourierProfileCard({Key? key}) : super(key: key);

  Widget statusText(bool warned, bool blocked) {
    String text = blocked
        ? 'Блокировка'
        : warned
            ? 'Предупреждение'
            : 'ОК';
    TextStyle style = TxtStyle.selectedSmallText.copyWith(
      fontSize: 11,
      color: blocked
          ? ClrStyle.darkDecline
          : warned
              ? ClrStyle.darkSelect
              : ClrStyle.darkAccept,
    );

    return Text(text, style: style);
  }

  @override
  Widget build(BuildContext context) {
    bool warned = context.read<User>().courier!.warned;
    bool blocked = context.read<User>().courier!.blocked;
    return BorderBox(
      height: 105,
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
                  Text(
                    context.read<User>().fullName,
                    style: TxtStyle.selectedMainText,
                  ),
                  Spacer(flex: 3),
                  Text(context.read<User>().phone, style: TxtStyle.smallText),
                  Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StarHolder(rating: context.read<User>().courier!.rating),
                      SizedBox(
                        height: 15,
                        child: statusText(warned, blocked),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
