import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';

class TerminalSelection extends StatefulWidget {
  final bool has;
  final void Function(bool) onChange;
  const TerminalSelection({Key? key, this.has = false, required this.onChange})
      : super(key: key);

  @override
  _TerminalSelectionState createState() =>
      _TerminalSelectionState(has, onChange);
}

class _TerminalSelectionState extends State<TerminalSelection> {
  bool has;
  final void Function(bool) onChange;

  _TerminalSelectionState(this.has, this.onChange);

  void switchChoise(bool res) {
    setState(() {
      has = res;
      onChange(has);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> buttons = ['Есть', 'Нет'];
    return Container(
      child: Container(
        width: double.infinity,
        height: 69,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                'Наличие терминала',
                style: TxtStyle.selectedSmallText,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: buttons
                  .map(
                    (txt) => Container(
                      width: 85,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () => switchChoise(txt == 'Есть'),
                        child: BorderBox(
                          height: 44,
                          selected: (this.has && txt == 'Есть') ||
                              (!this.has && txt == 'Нет'),
                          child: Center(
                            child: Text(txt, style: TxtStyle.mainHeader),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
