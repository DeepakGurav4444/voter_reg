import 'package:flutter/services.dart';

class VoterIdInputFormatter extends TextInputFormatter {
  final RegExp _voterIdRegex = RegExp(r'^[A-Z]{0,3}[0-9]{0,7}$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (_voterIdRegex.hasMatch(newValue.text.toUpperCase())) {
      return newValue.copyWith(text: newValue.text.toUpperCase());
    } else {
      return oldValue;
    }
  }
}
