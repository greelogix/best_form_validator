import 'i18n/form_localizations.dart';

/// Financial validation functions — Credit Card (Luhn) and IBAN (MOD-97).
///
/// Both validators return `null` on success and a localized error string on
/// failure, matching the `String? Function(String?)` contract expected by
/// Flutter's `TextFormField.validator`.
///
/// ### Credit card
/// Strips spaces and dashes, then applies the
/// [Luhn algorithm (Mod-10)](https://en.wikipedia.org/wiki/Luhn_algorithm).
///
/// ### IBAN
/// Strips spaces, upper-cases the input, checks the basic `CC##…` format, then
/// applies the [ISO 13616 MOD-97](https://en.wikipedia.org/wiki/International_Bank_Account_Number)
/// check.
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
  /// Validates a credit card number using the Luhn Algorithm (Mod-10).
  ///
  /// Spaces and dashes in [value] are stripped before validation, so both
  /// `4111111111111111` and `4111 1111 1111 1111` are accepted.
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
    if (value == null || value.isEmpty) {
      return requiredError ?? FormLocalizations.global.creditCardRequired;
    }

    final sanitized = value.replaceAll(RegExp(r'[\s\-]'), '');
    if (!RegExp(r'^\d+$').hasMatch(sanitized)) {
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
  /// validation. Maximum IBAN length is 34 characters.
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
    if (value == null || value.isEmpty) {
      return requiredError ?? FormLocalizations.global.ibanRequired;
    }

    final sanitized = value.replaceAll(RegExp(r'\s+'), '').toUpperCase();

    // Basic format check: 2 letter country code, 2 check digits, up to 30 alphanumeric chars
    if (!RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$').hasMatch(sanitized) ||
        sanitized.length > 34) {
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
