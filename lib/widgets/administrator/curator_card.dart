import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:topgo/functions/launcher.dart';
import 'package:topgo/models/simple_curator.dart';
import 'package:topgo/models/user.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/administrator/curator_deleting_dialog.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/curator/action_icon.dart';

class CuratorCard extends StatelessWidget {
  final SimpleCurator curator;
  const CuratorCard({Key? key, required this.curator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderBox(
      height: 112,
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                  Text(
                    curator.fullName,
                    style: TxtStyle.selectedMainText,
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(curator.phone, style: TxtStyle.smallText),
                      Spacer(),
                      SizedBox(width: 4),
                      ActionIcon(
                        iconName: 'trash-alt',
                        accept: false,
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            return ChangeNotifierProvider.value(
                              value: Provider.of<User>(context, listen: false),
                              child: CuratorDeletingDialog(curator: curator),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 4),
                      ActionIcon(
                        iconName: 'call',
                        onTap: () async => call(curator.phoneSource!),
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
