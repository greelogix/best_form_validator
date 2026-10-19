import 'i18n/form_localizations.dart';

/// Password validator with checking and strength rules.
class PasswordValidator {
  /// Validates a password with customizable criteria.
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

    // Default flags if not provided
    final checkLen = checkLength ?? true;
    final checkNumAlpha = checkNumberAndLetter ?? false;
    final checkSpecial = checkSpecialCharacter ?? false;
    final checkLower = checkLowerCase ?? false;
    final checkUpper = checkUpperCase ?? false;

    // Minimum Length Check
    if (checkLen && value.length < minLength) {
      return FormLocalizations.global.passwordMinLength(minLength);
    }

    // Number & Letter Check
    if (checkNumAlpha) {
      final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(value);
      final hasNumber = RegExp(r'[0-9]').hasMatch(value);
      if (!hasLetter || !hasNumber) {
        return FormLocalizations.global.passwordNumberAndLetter;
      }
    }

    // Special Character Check
    if (checkSpecial) {
      // Common special characters constraint
      final hasSpecial =
          RegExp(r'[!@#\$%\^&\*\(\),\.\?":\{\}\|<>]').hasMatch(value);
      if (!hasSpecial) {
        return FormLocalizations.global.passwordSpecialChar;
      }
    }

    // Lowercase Check
    if (checkLower && !RegExp(r'[a-z]').hasMatch(value)) {
      return FormLocalizations.global.passwordLowercase;
    }

    // Uppercase Check
    if (checkUpper && !RegExp(r'[A-Z]').hasMatch(value)) {
      return FormLocalizations.global.passwordUppercase;
    }

    // No Spaces Allowed
    if (value.contains(' ')) {
      return FormLocalizations.global.passwordNoSpaces;
    }

    return null;
  }

  /// Evaluates the strength of a password, returning a score from 0 to 5.
  ///
  /// Criteria:
  /// - +1 for length >= 8
  /// - +1 for containing lowercase letters
  /// - +1 for containing uppercase letters
  /// - +1 for containing numbers
  /// - +1 for containing special characters
  ///
  /// Returns `0` if empty or null.
  static int getPasswordStrength(String? password) {
    if (password == null || password.isEmpty) return 0;

    int score = 0;
    if (password.length >= 8) score++;
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#\$%\^&\*\(\),\.\?":\{\}\|<>]').hasMatch(password)) score++;

    return score;
  }
}
