import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    if (newText.isEmpty) {
      return newValue;
    }

    // Remove any non-digit or non-slash characters
    newText = newText.replaceAll(RegExp(r'[^0-9/]'), '');

    // Limit to 10 characters
    if (newText.length > 10) {
      newText = newText.substring(0, 10);
    }

    // Add slashes automatically (ensuring index safety)
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 2 || i == 5) {
        if (newText[i] != '/') {
          formattedText += '/';
        }
      }
      formattedText += newText[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
