import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';

class MovementSelection extends StatefulWidget {
  final bool disabled;
  final int index;
  final void Function(int) onChange;
  const MovementSelection({
    Key? key,
    this.index = 0,
    required this.onChange,
    required this.disabled,
  }) : super(key: key);

  @override
  _MovementSelectionState createState() =>
      _MovementSelectionState(index, onChange);
}

class _MovementSelectionState extends State<MovementSelection> {
  int currentIndex;
  final void Function(int) onChange;

  _MovementSelectionState(this.currentIndex, this.onChange);

  void switchChoise(int ind) {
    setState(() {
      currentIndex = ind;
      onChange(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> pics = ['pedestrian', 'bicycle', 'car'];
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
                                  ? GrdStyle.panel
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
                                )
                              ],
                            ),
                            child: ShaderMask(
                              shaderCallback: (bounds) =>
                                  (pics.indexOf(pic) != currentIndex
                                          ? GrdStyle.panel
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
                    .toList()
                // GestureDetector(
                //   onTap: () => switchChoise(0),
                //   child: Container(
                //     width: 44,
                //     height: 44,
                //     decoration: BoxDecoration(
                //       gradient: this.currentIndex == 0
                //           ? GrdStyle.accept
                //           : GrdStyle.lightPanel,
                //       borderRadius: BorderRadius.circular(6),
                //       boxShadow: [
                //         BoxShadow(color: ClrStyle.dropShadow, blurRadius: 3)
                //       ],
                //     ),
                //     child: GestureDetector(
                //       onTap: () => switchChoise(0),
                //       child: Container(
                //         margin: const EdgeInsets.all(1.5),
                //         decoration: BoxDecoration(
                //           color: Color(0xFFFFFFFF),
                //           borderRadius: BorderRadius.circular(6),
                //         ),
                //         child: Center(
                //           child: Text(
                //             'Есть',
                //             style: TxtStyle.mainHeader,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                //),
                ),
          ],
        ),
      ),
    );
  }
}
