/// Financial validation functions (Credit Card, IBAN, etc.).
class FinancialValidators {
  /// Validates a credit card number using the Luhn Algorithm.
  ///
  /// The input can contain spaces or dashes (they are stripped before validation).
  ///
  /// Returns `null` if valid, otherwise returns a customizable error.
  static String? validateCreditCard(String? value,
      {String? requiredError = 'Credit card number is required',
      String? invalidError = 'Invalid credit card number'}) {
    if (value == null || value.isEmpty) {
      return requiredError;
    }

    final sanitized = value.replaceAll(RegExp(r'\s+|-'), '');
    if (!RegExp(r'^\d+$').hasMatch(sanitized)) {
      return invalidError;
    }

    int sum = 0;
    bool alternate = false;
    for (int i = sanitized.length - 1; i >= 0; i--) {
      int n = int.parse(sanitized[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) {
          n -= 9;
        }
      }
      sum += n;
      alternate = !alternate;
    }

    if (sum % 10 != 0) {
      return invalidError;
    }

    return null;
  }

  /// Validates an International Bank Account Number (IBAN).
  ///
  /// The input is automatically capitalized and spaces are stripped.
  /// Validates format length (max 34) and standard MOD-97 check.
  ///
  /// Returns `null` if valid, otherwise returns a customizable error.
  static String? validateIBAN(String? value,
      {String? requiredError = 'IBAN is required',
      String? invalidError = 'Invalid IBAN number'}) {
    if (value == null || value.isEmpty) {
      return requiredError;
    }

    final sanitized = value.replaceAll(RegExp(r'\s+'), '').toUpperCase();

    // Basic format check
    if (!RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$').hasMatch(sanitized)) {
      return invalidError;
    }
    if (sanitized.length > 34) {
      return invalidError;
    }

    // Rearrange string for mod 97 check: move first 4 chars to the end
    final rearranged = sanitized.substring(4) + sanitized.substring(0, 4);

    // Convert letters to numbers: A=10, B=11 ... Z=35
    final sb = StringBuffer();
    for (int i = 0; i < rearranged.length; i++) {
      final code = rearranged.codeUnitAt(i);
      if (code >= 65 && code <= 90) {
        // A-Z
        sb.write('${code - 55}');
      } else {
        sb.write(String.fromCharCode(code));
      }
    }

    final numericString = sb.toString();

    // Perform modulo 97 sequentially for large string
    int remainder = 0;
    for (int i = 0; i < numericString.length; i++) {
      remainder = (remainder * 10 + int.parse(numericString[i])) % 97;
    }

    if (remainder != 1) {
      return invalidError;
    }

    return null;
  }
}
