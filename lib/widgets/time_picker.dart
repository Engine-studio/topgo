import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_picker/flutter_picker.dart';

String jsonTime() {
  List<int> hours = List<int>.generate(24, (int index) => index);
  List<int> minutes = List<int>.generate(60, (int index) => index);
  return "[[${hours.join(',')}],[${minutes.join(',')}]]";
}

showTimePicker({
  required BuildContext context,
  List<int> selected = const [0, 0],
  required void Function(List<int>) onConfirm,
}) {
  Picker(
    height: 200,
    confirmText: 'Выбрать',
    cancelText: 'Отменить',
    adapter: PickerDataAdapter<String>(
      pickerdata: new JsonDecoder().convert(jsonTime()),
      isArray: true,
    ),
    selecteds: selected,
    delimiter: [
      PickerDelimiter(
          child: Center(child: Text(':', style: TextStyle(fontSize: 24)))),
    ],
    onConfirm: (Picker picker, List<int> value) => onConfirm(value),
  ).showModal(context); //_scaffoldKey.currentState);
}
