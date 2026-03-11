import 'package:flutter/services.dart';

/// A `TextInputFormatter` that auto-formats a phone number based on a generic pattern.
///
/// Note: Since exact formatting rules vary wildly by country, this applies a standardized
/// spacing strategy (e.g. `+XXX XXX XXX XXX`) which improves readability generically.
/// To use strict country-based formats, an external library like `libphonenumber` is recommended.
///
/// Example:
/// ```dart
/// TextFormField(
///   inputFormatters: [PhoneInputFormatter()],
///   keyboardType: TextInputType.phone,
/// )
/// ```
class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove any non-digit/non-plus characters.
    final sanitizedText = newValue.text.replaceAll(RegExp(r'[^\d+]'), '');

    // Basic spacing logic: "+XXX XXX XXX XXX"
    final buffer = StringBuffer();
    int digitCount = 0;

    for (int i = 0; i < sanitizedText.length; i++) {
      final char = sanitizedText[i];
      if (char == '+') {
        buffer.write(char);
      } else {
        buffer.write(char);
        digitCount++;

        // Apply generic groups of 3 or 4 digits
        if ((digitCount == 3 || digitCount == 6 || digitCount == 9) &&
            i != sanitizedText.length - 1) {
          buffer.write(' ');
        }
      }
    }

    final formattedStr = buffer.toString();
    return TextEditingValue(
      text: formattedStr,
      selection: TextSelection.collapsed(offset: formattedStr.length),
    );
  }
}
