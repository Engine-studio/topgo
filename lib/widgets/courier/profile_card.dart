import 'package:flutter/widgets.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/courier/profile_photo.dart';
import 'package:topgo/widgets/courier/star_holder.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  final String surname, name, patronymic, phone;
  final double rating;
  const ProfileCard({
    Key? key,
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.phone,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  StarHolder(rating: rating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
