import 'i18n/form_localizations.dart';

/// Name validator with full Unicode support.
///
/// Accepts Latin names (`John Doe`), accented characters (`José`), hyphenated
/// names (`Mary-Jane`), apostrophe names (`O'Brien`), and names written in
/// Arabic, Urdu, Hindi, Chinese, Japanese, Korean, and other scripts — in line
/// with the package's 25-language localisation support.
///
/// ### Accepted characters
/// | Category | Examples |
/// |----------|---------|
/// | Latin / extended Latin | A–Z, a–z, À–ÖØ–öø–ÿ, etc. |
/// | Arabic / Urdu scripts | محمد, فاطمہ |
/// | Devanagari (Hindi) | राज, प्रिया |
/// | CJK (Chinese, Japanese, Korean) | 王芳, 田中, 김민준 |
/// | Hyphens | Mary-Jane |
/// | Apostrophes | O'Brien |
/// | Spaces | John Doe |
///
/// ### Rejected
/// - Digits (`0–9`)
/// - Leading / trailing spaces
/// - Multiple consecutive spaces
/// - Other punctuation / symbols
class NameValidator {
  // Matches any Unicode letter plus combining marks, with apostrophes or
  // hyphens allowed only inside a token. Unicode property escapes keep this
  // correct for scripts such as Cyrillic, Greek, Thai, Arabic, CJK, and more.
  static final RegExp _tokenRegex = RegExp(
    r"^\p{L}[\p{L}\p{M}]*(?:['’-]\p{L}[\p{L}\p{M}]*)*$",
    unicode: true,
  );

  /// Validates a name string.
  ///
  /// Returns `null` if the name is valid, otherwise returns a localized error
  /// message.
  ///
  /// ### Validation rules
  /// - Must not be empty / whitespace-only
  /// - No leading or trailing spaces
  /// - No multiple consecutive spaces
  /// - No digits or punctuation other than hyphens and apostrophes
  /// - Each word (space-separated token) must be a valid name segment
  ///
  /// Parameters:
  /// - [value]: The name to validate
  /// - [requiredError]: Custom message when the name is empty
  /// - [invalidError]: Custom message when the format is invalid
  ///
  /// Example:
  /// ```dart
  /// NameValidator.validate('John Doe');        // null – valid
  /// NameValidator.validate('José García');     // null – valid
  /// NameValidator.validate('محمد علي');        // null – valid
  /// NameValidator.validate('王芳');             // null – valid
  /// NameValidator.validate('Mary-Jane');       // null – valid
  /// NameValidator.validate("O'Brien");         // null – valid
  /// NameValidator.validate('John123');         // error – digits not allowed
  /// NameValidator.validate(' John');           // error – leading space
  /// ```
  static String? validate(
    String? value, {
    String? requiredError,
    String? invalidError,
  }) {
    if (value == null || value.trim().isEmpty) {
      return requiredError ?? FormLocalizations.global.nameRequired;
    }

    // No leading or trailing spaces
    if (value.startsWith(' ') || value.endsWith(' ')) {
      return invalidError ?? FormLocalizations.global.nameInvalid;
    }

    // No multiple consecutive spaces
    if (value.contains(RegExp(r'\s{2,}'))) {
      return invalidError ?? FormLocalizations.global.nameInvalid;
    }

    // Validate every space-separated token individually
    final tokens = value.split(' ');
    for (final token in tokens) {
      if (token.isEmpty || !_tokenRegex.hasMatch(token)) {
        return invalidError ?? FormLocalizations.global.nameInvalid;
      }
    }

    return null;
  }
}
