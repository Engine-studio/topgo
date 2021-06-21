import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';

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
              children: [
                Container(
                  width: 109,
                  alignment: Alignment.center,
                  child: Container(
                    width: 79,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient:
                          this.has ? GrdStyle.accept : GrdStyle.lightPanel,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(color: ClrStyle.dropShadow, blurRadius: 3)
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => switchChoise(true),
                      child: Container(
                        margin: const EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'Есть',
                            style: TxtStyle.mainHeader,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 109,
                  alignment: Alignment.center,
                  child: Container(
                    width: 79,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient:
                          !this.has ? GrdStyle.accept : GrdStyle.lightPanel,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(color: ClrStyle.dropShadow, blurRadius: 3)
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => switchChoise(false),
                      child: Container(
                        margin: const EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'Нет',
                            style: TxtStyle.mainHeader,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
