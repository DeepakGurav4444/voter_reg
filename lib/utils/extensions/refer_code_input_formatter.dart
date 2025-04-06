import 'package:flutter/services.dart';

class ReferCodeInputFormatter extends TextInputFormatter {
  final RegExp _alphanumericRegex =
      RegExp(r'^[A-Z0-9]{0,8}$'); // Max 8 chars, only A-Z, 0-9

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String upperText = newValue.text.toUpperCase();

    if (_alphanumericRegex.hasMatch(upperText)) {
      return newValue.copyWith(
        text: upperText,
        selection: newValue.selection, // Maintain cursor position
      );
    }

    return oldValue; // Reject invalid input
  }
}
