import 'package:flutter/widgets.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/time_picker.dart';

class TimeHolder extends StatefulWidget {
  final String text;
  final List<int> time;
  final bool disabled;
  final void Function() onChange;
  const TimeHolder({
    Key? key,
    required this.text,
    required this.time,
    required this.disabled,
    required this.onChange,
  }) : super(key: key);

  @override
  _TimeHolderState createState() => _TimeHolderState(time: this.time);
}

class _TimeHolderState extends State<TimeHolder> {
  List<int> time;

  _TimeHolderState({required this.time});

  changeTime(List<int> time) {
    setState(() {
      this.time = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 109,
      height: 69,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.text, style: TxtStyle.selectedSmallText),
          Container(
            width: 79,
            height: 44,
            decoration: BoxDecoration(
              gradient: GrdStyle.lightPanel,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [BoxShadow(color: ClrStyle.dropShadow, blurRadius: 3)],
            ),
            child: AbsorbPointer(
              absorbing: widget.disabled,
              child: GestureDetector(
                onTap: () => showTimePicker(
                  context: context,
                  selected: this.time,
                  onConfirm: (List<int> time) => changeTime(time),
                ),
                child: Container(
                  margin: const EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      '${this.time[0] < 10 ? "0${this.time[0]}" : this.time[0]}' +
                          ' : ' +
                          '${this.time[1] < 10 ? "0${this.time[1]}" : this.time[1]}',
                      style: TxtStyle.mainHeader,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
