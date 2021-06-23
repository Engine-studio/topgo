import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';

class MovementSelection extends StatefulWidget {
  final bool disabled;
  final int index;
  final void Function(int) onChange;
  const MovementSelection({
    Key? key,
    this.index = 0,
    required this.disabled,
    required this.onChange,
  }) : super(key: key);

  @override
  _MovementSelectionState createState() =>
      _MovementSelectionState(index, onChange, disabled);
}

class _MovementSelectionState extends State<MovementSelection> {
  int currentIndex;
  final bool disabled;
  final void Function(int) onChange;

  _MovementSelectionState(this.currentIndex, this.onChange, this.disabled);

  void switchChoise(int ind) {
    setState(() {
      currentIndex = ind;
      onChange(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> pics = ['pedestrian', 'bicycle', 'car'];
    return AbsorbPointer(
      absorbing: disabled,
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
                'Способ передвижения',
                style: TxtStyle.selectedSmallText,
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: pics
                    .map((pic) => GestureDetector(
                          onTap: () => switchChoise(pics.indexOf(pic)),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: pics.indexOf(pic) == currentIndex
                                  ? GrdStyle().panelGradient(context)
                                  : LinearGradient(colors: [
                                      Color(0xFFFFFFFF),
                                      Color(0xFFFFFFFF),
                                    ]),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: ClrStyle.dropShadow,
                                  blurRadius:
                                      pics.indexOf(pic) == currentIndex ? 3 : 0,
                                ),
                              ],
                            ),
                            child: ShaderMask(
                              shaderCallback: (bounds) =>
                                  (pics.indexOf(pic) != currentIndex
                                          ? GrdStyle().panelGradient(context)
                                          : LinearGradient(colors: [
                                              Color(0xFFFFFFFF),
                                              Color(0xFFFFFFFF),
                                            ]))
                                      .createShader(bounds),
                              child: Image(
                                image: ResizeImage(
                                  AssetImage('assets/icons/$pic.png'),
                                  width: 32,
                                  height: 32,
                                ),
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ))
                    .toList()),
          ],
        ),
      ),
    );
  }
}
