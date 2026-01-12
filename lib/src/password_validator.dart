import 'i18n/form_localizations.dart';

/// Password validator with customizable validation criteria.
///
/// Supports multiple validation rules including length, character types,
/// and special character requirements.
class PasswordValidator {
  /// Validates a password against specified criteria.
  ///
  /// Returns `null` if the password meets all criteria, otherwise returns
  /// an error message describing the first failed criterion.
  ///
  /// Parameters:
  /// - [value]: The password to validate
  /// - [checkLength]: Whether to check minimum length (default: true)
  /// - [minLength]: Minimum password length (default: 6)
  /// - [checkNumberAndLetter]: Require both numbers and letters (default: false)
  /// - [checkSpecialCharacter]: Require special characters (default: false)
  /// - [checkLowerCase]: Require lowercase letters (default: false)
  /// - [checkUpperCase]: Require uppercase letters (default: false)
  ///
  /// Example:
  /// ```dart
  /// String? error = PasswordValidator.validate(
  ///   'MyP@ssw0rd',
  ///   checkLength: true,
  ///   minLength: 8,
  ///   checkNumberAndLetter: true,
  ///   checkSpecialCharacter: true,
  ///   checkLowerCase: true,
  ///   checkUpperCase: true,
  /// );
  /// ```
  static String? validate(String? value,
      {bool? checkLength = true,
      int minLength = 6,
      bool? checkNumberAndLetter = false,
      bool? checkSpecialCharacter = false,
      bool? checkLowerCase = false,
      bool? checkUpperCase = false}) {
    if (value == null || value.isEmpty) {
      return FormLocalizations.global.passwordRequired;
    }

    if (checkLength! && value.length < minLength) {
      return FormLocalizations.global.passwordMinLength(minLength);
    }

    if (checkNumberAndLetter!) {
      bool hasLetter = value.contains(RegExp(r'[A-Za-z]'));
      bool hasDigit = value.contains(RegExp(r'\d'));
      if (!hasLetter || !hasDigit) {
        return FormLocalizations.global.passwordNumberAndLetter;
      }
    }

    if (checkSpecialCharacter! &&
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return FormLocalizations.global.passwordSpecialCharacter;
    }

    if (checkLowerCase! && !value.contains(RegExp(r'[a-z]'))) {
      return FormLocalizations.global.passwordLowerCase;
    }

    if (checkUpperCase! && !value.contains(RegExp(r'[A-Z]'))) {
      return FormLocalizations.global.passwordUpperCase;
    }
    if (value.contains(" ")) {
      return FormLocalizations.global.passwordNoSpaces;
    }
    return null;
  }
}
