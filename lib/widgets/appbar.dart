import 'package:flutter/material.dart';
import 'package:topgo/styles.dart';

List dictionary = [
  {
    'history': 'История',
    'rocket': 'Заказы',
    'user': 'Профиль',
    'documents': 'Отчеты',
  }
];

class Appbar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final void Function() onPressed;

  Appbar(this.title, {Key? key, required this.onPressed})
      : preferredSize = Size.fromHeight(50),
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            dictionary[0][title],
            style:
                TxtStyle.mainHeader.copyWith(color: ClrStyle.lightBackground),
          ),
          actions: [
            title == 'user' || title == 'documents'
                ? Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: Image.asset(
                        'assets/icons/file-text.png',
                        width: 24,
                        height: 24,
                        color: ClrStyle.lightBackground,
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => onPressed(),
                    ),
                  )
                : Container()
          ],
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
