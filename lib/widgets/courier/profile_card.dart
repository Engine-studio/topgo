import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/courier/profile_photo.dart';

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
    return Container(
      width: double.infinity,
      height: 105,
      decoration: BoxDecoration(
        gradient: GrdStyle.lightPanel,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [BoxShadow(color: ClrStyle.dropShadow, blurRadius: 3)],
      ),
      child: Container(
        margin: const EdgeInsets.all(1.5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            ProfilePhoto(),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$surname $name $patronymic',
                    style: TxtStyle.selectedMainText,
                  ),
                  Spacer(flex: 3),
                  Text('$phone', style: TxtStyle.smallText),
                  Spacer(flex: 2),
                  Row(
                    children: [
                      Text('$rating', style: TxtStyle.smallText),
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            GrdStyle.select.createShader(bounds),
                        child: Image.asset(
                          'assets/icons/star.png',
                          width: 15,
                          height: 15,
                          color: Color(0xFFFFFFFF),
                        ),
                      )
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
