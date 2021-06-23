import 'package:flutter/material.dart';
import 'package:topgo/styles.dart';

class Search extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const Search({Key? key, required this.text, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 35,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6A9DD9).withOpacity(0.15),
                blurRadius: 3,
              )
            ],
          ),
          child: TextField(
            controller: this.controller,
            style: TxtStyle.selectedMainText,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              prefixIcon: Image(
                image: ResizeImage(
                  AssetImage('assets/icons/search.png'),
                  width: 16,
                  height: 16,
                ),
                color: ClrStyle.icons,
              ),
              hintStyle: TxtStyle.mainText,
              hintText: this.text,
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            ...['По имени', 'По адресу'].map(
              (txt) => Container(
                margin: const EdgeInsets.only(right: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.5, vertical: 4),
                height: 23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: ClrStyle.lightBackground,
                ),
                child: Center(
                  child: Text(txt, style: TxtStyle.selectedSmallText),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
