import 'i18n/form_localizations.dart';

/// Financial validation functions — Credit Card (Luhn) and IBAN (MOD-97).
///
/// Both validators return `null` on success and a localized error string on
/// failure, matching the `String? Function(String?)` contract expected by
/// Flutter's `TextFormField.validator`.
///
/// ### Credit card
/// Strips spaces and dashes, requires 12–19 digits, then applies the
/// [Luhn algorithm (Mod-10)](https://en.wikipedia.org/wiki/Luhn_algorithm).
///
/// ### IBAN
/// Strips spaces, upper-cases the input, verifies the registered country and
/// country-specific length, then applies ISO 13616 MOD-97.
///
/// Example:
/// ```dart
/// // Credit card
/// FinancialValidators.validateCreditCard('4111 1111 1111 1111'); // null (valid Visa test number)
/// FinancialValidators.validateCreditCard('1234 5678 9012 3456'); // error
///
/// // IBAN
/// FinancialValidators.validateIBAN('GB82 WEST 1234 5698 7654 32'); // null (valid)
/// FinancialValidators.validateIBAN('INVALID');                      // error
/// ```
class FinancialValidators {
  /// ISO 13616 country lengths from the SWIFT IBAN Registry, release 103
  /// (September 2026).
  static const Map<String, int> _ibanLengths = {
    'AD': 24,
    'AE': 23,
    'AL': 28,
    'AT': 20,
    'AZ': 28,
    'BA': 20,
    'BE': 16,
    'BG': 22,
    'BH': 22,
    'BI': 27,
    'BR': 29,
    'BY': 28,
    'CH': 21,
    'CR': 22,
    'CY': 28,
    'CZ': 24,
    'DE': 22,
    'DJ': 27,
    'DK': 18,
    'DO': 28,
    'EE': 20,
    'EG': 29,
    'ES': 24,
    'FI': 18,
    'FK': 18,
    'FO': 18,
    'FR': 27,
    'GB': 22,
    'GE': 22,
    'GI': 23,
    'GL': 18,
    'GR': 27,
    'GT': 28,
    'HN': 28,
    'HR': 21,
    'HU': 28,
    'IE': 22,
    'IL': 23,
    'IQ': 23,
    'IS': 26,
    'IT': 27,
    'JO': 30,
    'KW': 30,
    'KZ': 20,
    'LB': 28,
    'LC': 32,
    'LI': 21,
    'LT': 20,
    'LU': 20,
    'LV': 21,
    'LY': 25,
    'MC': 27,
    'MD': 24,
    'ME': 22,
    'MK': 19,
    'MN': 20,
    'MR': 27,
    'MT': 31,
    'MU': 30,
    'NI': 28,
    'NL': 18,
    'NO': 15,
    'OM': 23,
    'PK': 24,
    'PL': 28,
    'PS': 29,
    'PT': 25,
    'QA': 29,
    'RO': 24,
    'RS': 22,
    'RU': 33,
    'SA': 24,
    'SC': 31,
    'SD': 18,
    'SE': 24,
    'SI': 19,
    'SK': 24,
    'SM': 27,
    'SO': 23,
    'ST': 25,
    'SV': 28,
    'TL': 23,
    'TN': 24,
    'TR': 26,
    'UA': 29,
    'VA': 22,
    'VG': 24,
    'XK': 20,
    'YE': 30,
  };

  /// Validates a credit card number using the Luhn Algorithm (Mod-10).
  ///
  /// Spaces and dashes in [value] are stripped before validation. The result
  /// must contain 12–19 digits and pass Luhn, so both `4111111111111111` and
  /// `4111 1111 1111 1111` are accepted.
  ///
  /// Returns `null` if valid, otherwise returns a localized error message.
  ///
  /// Parameters:
  /// - [value]: The credit card number to validate
  /// - [requiredError]: Custom message when the field is empty
  /// - [invalidError]: Custom message when the number fails the Luhn check
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: (v) => FinancialValidators.validateCreditCard(v),
  /// )
  /// ```
  static String? validateCreditCard(
    String? value, {
    String? requiredError,
    String? invalidError,
  }) {
    if (value == null || value.trim().isEmpty) {
      return requiredError ?? FormLocalizations.global.creditCardRequired;
    }

    final sanitized = value.replaceAll(RegExp(r'[\s\-]'), '');
    if (!RegExp(r'^\d{12,19}$').hasMatch(sanitized) ||
        RegExp(r'^0+$').hasMatch(sanitized)) {
      return invalidError ?? FormLocalizations.global.invalidCreditCard;
    }

    // Luhn algorithm
    int sum = 0;
    bool alternate = false;
    for (int i = sanitized.length - 1; i >= 0; i--) {
      int n = int.parse(sanitized[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }

    if (sum % 10 != 0) {
      return invalidError ?? FormLocalizations.global.invalidCreditCard;
    }
    return null;
  }

  /// Validates an International Bank Account Number (IBAN) using MOD-97.
  ///
  /// [value] is automatically upper-cased and stripped of spaces before
  /// validation. Its country code and exact length must be registered in the
  /// SWIFT IBAN Registry before the MOD-97 checksum is evaluated.
  ///
  /// Returns `null` if valid, otherwise returns a localized error message.
  ///
  /// Parameters:
  /// - [value]: The IBAN string to validate
  /// - [requiredError]: Custom message when the field is empty
  /// - [invalidError]: Custom message when the IBAN fails the MOD-97 check
  ///
  /// Example:
  /// ```dart
  /// TextFormField(
  ///   validator: (v) => FinancialValidators.validateIBAN(v),
  /// )
  /// ```
  static String? validateIBAN(
    String? value, {
    String? requiredError,
    String? invalidError,
  }) {
    if (value == null || value.trim().isEmpty) {
      return requiredError ?? FormLocalizations.global.ibanRequired;
    }

    final sanitized = value.replaceAll(RegExp(r'\s+'), '').toUpperCase();

    // Basic format check: 2-letter country code, 2 check digits, and BBAN.
    if (!RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$').hasMatch(sanitized) ||
        sanitized.length > 34) {
      return invalidError ?? FormLocalizations.global.invalidIban;
    }

    final expectedLength = _ibanLengths[sanitized.substring(0, 2)];
    if (expectedLength == null || sanitized.length != expectedLength) {
      return invalidError ?? FormLocalizations.global.invalidIban;
    }

    // Rearrange: move first 4 chars to end
    final rearranged = sanitized.substring(4) + sanitized.substring(0, 4);

    // Convert letters → numbers (A=10 … Z=35)
    final sb = StringBuffer();
    for (int i = 0; i < rearranged.length; i++) {
      final code = rearranged.codeUnitAt(i);
      if (code >= 65 && code <= 90) {
        sb.write('${code - 55}');
      } else {
        sb.write(String.fromCharCode(code));
      }
    }

    // MOD-97 on large number via sequential processing
    int remainder = 0;
    final numericString = sb.toString();
    for (int i = 0; i < numericString.length; i++) {
      remainder = (remainder * 10 + int.parse(numericString[i])) % 97;
    }

    if (remainder != 1) {
      return invalidError ?? FormLocalizations.global.invalidIban;
    }
    return null;
  }
}
