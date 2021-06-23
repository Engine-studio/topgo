import 'package:flutter/material.dart';
import 'package:topgo/models/items.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/search.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final void Function() onPressed;
  final AppBarItem appBarItem;

  Appbar({
    Key? key,
    required this.appBarItem,
    required this.onPressed,
  })  : preferredSize = Size.fromHeight(appBarItem.withSearch ? 124 : 50),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(0, 0.5),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
        child: AppBar(
          toolbarHeight: appBarItem.withSearch ? 124 : 50,
          title: Column(
            children: [
              SizedBox(height: appBarItem.withSearch ? 4 : 0),
              Row(
                children: [
                  Spacer(),
                  Text(
                    appBarItem.title,
                    style: TxtStyle.mainHeader
                        .copyWith(color: ClrStyle.lightBackground),
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => onPressed(),
                        child: appBarItem.button,
                      ),
                    ),
                  ),
                ],
              ),
              ...appBarItem.withSearch
                  ? [
                      SizedBox(height: 16),
                      Search(
                        text: 'Search',
                        searchHelpers: appBarItem.searchHelpers
                            .map(
                              (str) => {
                                str: () => {},
                              },
                            )
                            .toList(),
                        controller: controller,
                      ),
                    ]
                  : [],
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GrdStyle().panelGradient(context),
            ),
          ),
        ),
      ),
    );
  }
}
