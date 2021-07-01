import 'package:flutter/widgets.dart';
import 'package:topgo/functions/time_string.dart';
import 'package:topgo/styles.dart';
import 'package:topgo/widgets/border_box.dart';
import 'package:topgo/widgets/time_picker.dart';

class TimeHolder extends StatefulWidget {
  final String text;
  final List<int> time;
  final bool disabled;
  final void Function(List<int>) onChange;
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
    widget.onChange(time);
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
          AbsorbPointer(
            absorbing: widget.disabled,
            child: GestureDetector(
              onTap: () => showTimePicker(
                context: context,
                selected: time,
                onConfirm: (List<int> time) => changeTime(time),
              ),
              child: BorderBox(
                width: 79,
                height: 44,
                child: Center(
                  child: Text(timeString(time), style: TxtStyle.mainHeader),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
