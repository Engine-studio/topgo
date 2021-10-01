import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_picker/flutter_picker.dart';

String jsonTime(bool forShift) {
  List<int> hours = !forShift
      ? List<int>.generate(24, (int index) => index)
      : List<int>.generate(9, (int index) => index + 2);
  List<int> minutes = List<int>.generate(60, (int index) => index);
  return "[[${hours.join(',')}],[${minutes.join(',')}]]";
}

showTimePicker({
  required BuildContext context,
  List<int> selected = const [0, 0],
  bool forShift = false,
  required void Function(List<int>) onConfirm,
}) {
  Picker(
    height: 200,
    confirmText: 'Выбрать',
    cancelText: 'Отменить',
    adapter: PickerDataAdapter<String>(
      pickerdata: new JsonDecoder().convert(jsonTime(forShift)),
      isArray: true,
    ),
    selecteds: !forShift ? selected : [selected[0] - 2, selected[1]],
    delimiter: [
      PickerDelimiter(
          child: Center(child: Text(':', style: TextStyle(fontSize: 24)))),
    ],
    onConfirm: (Picker picker, List<int> value) =>
        onConfirm(!forShift ? value : [value[0] + 2, value[1]]),
  ).showModal(context); //_scaffoldKey.currentState);
}
