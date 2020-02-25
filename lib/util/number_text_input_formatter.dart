import 'package:flutter/services.dart';

/// 只允许输入数子  第一个为.的装换成0.
class UsNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;

  static double str2Float(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    // 如果第只有. 自动转换成0.
    if (value == '.') {
      value = '0.';
      selectionIndex++;
    } else if (value != '' &&
        value != defaultDouble.toString() &&
        str2Float(value, defaultDouble) == defaultDouble) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: selectionIndex));
  }
}
