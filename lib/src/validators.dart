import 'dart:ui';
import 'package:best_form_validator/best_form_validator.dart';
import 'package:intl/intl.dart';

/// Main validator class providing static methods for all validation types.
///
/// This class serves as the primary API for the best_form_validator package.
/// All validation methods are static and can be used directly without
/// instantiation. No initialization is required — validators are ready
/// immediately after import.
///
/// ## Quick start
/// ```dart
/// import 'package:best_form_validator/best_form_validator.dart';
///
/// // Use directly inside TextFormField.validator — no setup needed
/// TextFormField(validator: (v) => Validators.validateEmail(v));
/// ```
///
/// ## Available validators
/// - [validateEmail] — standard email format
/// - [validateUrl] — HTTP/HTTPS URL format
/// - [validatePhone] — 52 countries, auto-normalizes local formats
/// - [validatePassword] — configurable strength rules
/// - [validateName] — Unicode-aware name validation
/// - [validateAge] — minimum age from birth date
/// - [validateDate] — parseable date string
/// - [validateTime] — strict HH:mm / HH:mm:ss (00–23 h, 00–59 m/s)
/// - [validateCreditCard] — Luhn algorithm (Mod-10)
/// - [validateIBAN] — ISO 13616 MOD-97
///
/// ## Localization
/// Call [setLocale] once in your `MaterialApp` builder to return error
/// messages in the user's language (25 languages supported).
class Validators {
  /// Sets the locale for validation messages.
  ///
  /// This allows the validators to return error messages in the appropriate language
  /// without needing BuildContext.
  ///
  /// Example:
  /// ```dart
  /// Validators.setLocale(Locale('es'));
  /// ```
  static void setLocale(Locale locale) {
    FormLocalizations.setGlobal(FormLocalizations.getByLocale(locale));
  }

  /// Validates an email address.
  ///
  /// Returns `null` if the email is valid, otherwise returns an error message.
  ///
  /// Parameters:
  /// - [value]: The email address to validate
  /// - [requiredError]: Custom error message when email is empty (default: localized "Email is required")
  /// - [invalidError]: Custom error message when email format is invalid (default: localized "Enter a valid email")
  ///
  /// Example:
  /// ```dart
  /// String? error = Validators.validateEmail('user@example.com');
  /// if (error != null) {
  ///   print(error); // null if valid
  /// }
  /// ```
  static String? validateEmail(
    String? value, {
    String? requiredError,
    String? invalidError,
  }) {
    if (value == null || value.isEmpty) {
      return requiredError ?? FormLocalizations.global.emailRequired;
    }
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return invalidError ?? FormLocalizations.global.invalidEmail;
    }

    return null;
  }

  /// Validates a URL (HTTP or HTTPS).
  ///
  /// Returns `null` if the URL is valid, otherwise returns an error message.
  ///
  /// Parameters:
  /// - [value]: The URL to validate
  /// - [requiredError]: Custom error message when URL is empty
  /// - [invalidError]: Custom error message when URL format is invalid
  /// - [isRequired]: Whether an empty value is an error (default: true)
  /// - [allowedSchemes]: Permitted URI schemes (default: `http`, `https`)
  /// - [allowMissingScheme]: When true, accepts values like `example.com`
  ///   by prepending `https://` before validation
  ///
  /// Example:
  /// ```dart
  /// Validators.validateUrl('https://example.com');   // null (valid)
  /// Validators.validateUrl('http://localhost:8080'); // null (valid)
  /// Validators.validateUrl('example.com');           // error (no scheme)
  /// Validators.validateUrl('example.com', allowMissingScheme: true); // null
  /// ```
  static String? validateUrl(
    String? value, {
    String? requiredError,
    String? invalidError,
    bool isRequired = true,
    List<String> allowedSchemes = const ['http', 'https'],
    bool allowMissingScheme = false,
  }) {
    return UrlValidator.validate(
      value,
      requiredError: requiredError,
      invalidError: invalidError,
      isRequired: isRequired,
      allowedSchemes: allowedSchemes,
      allowMissingScheme: allowMissingScheme,
    );
  }

  /// [DEPRECATED] Phone number regex patterns are now statically loaded.
  ///
  /// **No longer required to be called.**
  ///
  /// Safe to remove from your app startup:
  /// ```dart
  /// // Remove this line
  /// await Validators.loadPhoneRegex();
  /// ```
  @Deprecated(
      'No longer needed. Phone regex forms are statically loaded. Safe to remove.')
  static Future<void> loadPhoneRegex() async {
    // No-op
  }

  /// Validates a phone number for a specific country.
  ///
  /// Returns `null` if the phone number is valid for the given country,
  /// otherwise returns a localized error message.
  ///
  /// Both international format (`+923001234567`) and local/national format
  /// (`03001234567`) are accepted — local numbers are automatically normalized
  /// to international format before validation. No custom conversion code needed.
  ///
  /// [isoCode] accepts both `'GB'` and `'UK'` for the United Kingdom.
  ///
  /// Supported countries: US, CA, GB/UK, FR, DE, IN, AU, BR, CN, JP, MX, RU,
  /// ZA, NG, EG, KE, GH, SA, AE, IT, ES, SE, NO, FI, DK, NL, BE, CH, AT, PT,
  /// GR, TR, IR, PK, BD, LK, TH, MY, SG, ID, PH, VN, KR, HK, TW, NZ, AF, AL,
  /// DZ, AR, AZ, BH
  ///
  /// Example:
  /// ```dart
  /// // International format
  /// String? error = Validators.validatePhone('+12025551234', 'US');
  ///
  /// // Local format – auto-normalized
  /// String? error = Validators.validatePhone('03001234567', 'PK');
  ///
  /// // Both GB and UK work
  /// String? error = Validators.validatePhone('+447911123456', 'GB');
  /// String? error = Validators.validatePhone('+447911123456', 'UK');
  /// ```
  static String? validatePhone(
    String? value,
    String isoCode, {
    String? requiredError,
    bool isRequired = true,
    String? invalidError,
  }) {
    return PhoneValidator.validatePhoneNumber(
      value,
      isoCode,
      requiredError: requiredError,
      isRequired: isRequired,
      invalidError: invalidError,
    );
  }

  /// Normalizes a locally-formatted phone number to international format.
  ///
  /// Useful when you want to store/display the normalized number separately
  /// from validation.
  ///
  /// Example:
  /// ```dart
  /// String intl = Validators.normalizePhone('03001234567', 'PK');
  /// // → '+923001234567'
  /// ```
  static String normalizePhone(String value, String isoCode) {
    return PhoneValidator.normalizePhone(value, isoCode);
  }

  /// Validates a credit card number using the Luhn algorithm (Mod-10).
  ///
  /// Spaces and dashes are stripped before validation.
  /// Returns `null` if valid, otherwise returns a localized error message.
  ///
  /// Example:
  /// ```dart
  /// String? error = Validators.validateCreditCard('4111 1111 1111 1111');
  /// ```
  static String? validateCreditCard(
    String? value, {
    String? requiredError,
    String? invalidError,
  }) {
    return FinancialValidators.validateCreditCard(
      value,
      requiredError: requiredError,
      invalidError: invalidError,
    );
  }

  /// Validates an International Bank Account Number (IBAN) using MOD-97.
  ///
  /// Spaces are stripped and the value is upper-cased before validation.
  /// Returns `null` if valid, otherwise returns a localized error message.
  ///
  /// Example:
  /// ```dart
  /// String? error = Validators.validateIBAN('GB82 WEST 1234 5698 7654 32');
  /// ```
  static String? validateIBAN(
    String? value, {
    String? requiredError,
    String? invalidError,
  }) {
    return FinancialValidators.validateIBAN(
      value,
      requiredError: requiredError,
      invalidError: invalidError,
    );
  }

  /// Validates a password with customizable criteria.
  ///
  /// Returns `null` if the password meets all specified criteria,
  /// otherwise returns an error message describing the first failed criterion.
  ///
  /// Parameters:
  /// - [value]: The password to validate
  /// - [checkLength]: Whether to check minimum length (default: true)
  /// - [minLength]: Minimum password length (default: 6)
  /// - [checkNumberAndLetter]: Whether to require both numbers and letters (default: false)
  /// - [checkSpecialCharacter]: Whether to require special characters (default: false)
  /// - [checkLowerCase]: Whether to require lowercase letters (default: false)
  /// - [checkUpperCase]: Whether to require uppercase letters (default: false)
  ///
  /// Example:
  /// ```dart
  /// String? error = Validators.validatePassword(
  ///   'MyP@ssw0rd',
  ///   checkLength: true,
  ///   minLength: 8,
  ///   checkNumberAndLetter: true,
  ///   checkSpecialCharacter: true,
  ///   checkLowerCase: true,
  ///   checkUpperCase: true,
  /// );
  /// ```
  static String? validatePassword(
    String? value, {
    bool? checkLength = true,
    int minLength = 6,
    bool? checkNumberAndLetter = false,
    bool? checkSpecialCharacter = false,
    bool? checkLowerCase = false,
    bool? checkUpperCase = false,
  }) {
    return PasswordValidator.validate(
      value,
      checkLength: checkLength,
      minLength: minLength,
      checkNumberAndLetter: checkNumberAndLetter,
      checkSpecialCharacter: checkSpecialCharacter,
      checkLowerCase: checkLowerCase,
      checkUpperCase: checkUpperCase,
    );
  }

  /// Validates a name to ensure proper formatting.
  ///
  /// Returns `null` if the name is valid, otherwise returns a localized error
  /// message.
  ///
  /// Full Unicode support: accepts Latin, accented, Arabic, Urdu, Hindi
  /// (Devanagari), Chinese, Japanese, Korean, and other script names, as well
  /// as hyphenated (`Mary-Jane`) and apostrophe (`O'Brien`) names.
  ///
  /// ### Rules
  /// - Any Unicode letter character is allowed
  /// - Hyphens and apostrophes are allowed within a word token
  /// - Spaces are allowed between tokens
  /// - No leading or trailing spaces
  /// - No multiple consecutive spaces
  /// - No digits or other punctuation
  ///
  /// Parameters:
  /// - [value]: The name to validate
  /// - [requiredError]: Custom error when name is empty (default: localized "Name is required")
  /// - [invalidError]: Custom error when format is invalid (default: localized "Name is invalid")
  ///
  /// Example:
  /// ```dart
  /// Validators.validateName('John Doe');     // null – valid
  /// Validators.validateName('محمد علي');    // null – valid
  /// Validators.validateName('王芳');          // null – valid
  /// Validators.validateName('Mary-Jane');   // null – valid
  /// Validators.validateName('John123');     // error
  /// ```
  static String? validateName(
    String? value, {
    String? requiredError,
    String? invalidError,
  }) {
    return NameValidator.validate(
      value,
      requiredError: requiredError,
      invalidError: invalidError,
    );
  }

  /// Validates age meets a minimum requirement.
  ///
  /// Returns `null` if the age meets the minimum requirement,
  /// otherwise returns an error message.
  ///
  /// Accepts either a [DateTime] object or a date string in 'yyyy-MM-dd' format.
  ///
  /// Parameters:
  /// - [value]: Birth date as DateTime or String (yyyy-MM-dd)
  /// - [minimumAge]: Minimum age requirement in years
  /// - [requiredError]: Custom error message when value is invalid
  /// - [invalidError]: Custom error message when age doesn't meet minimum
  ///
  /// Example:
  /// ```dart
  /// // With string
  /// String? error = Validators.validateAge('2000-01-15', 18);
  ///
  /// // With DateTime
  /// String? error = Validators.validateAge(DateTime(2000, 1, 15), 18);
  /// ```
  static String? validateAge(
    dynamic value,
    int minimumAge, {
    String? requiredError,
    String? invalidError,
  }) {
    return AgeValidator.validateAge(
      value,
      minimumAge,
      requiredError: requiredError,
      invalidError: invalidError,
    );
  }

  /// Validates a date string using strict yyyy-MM-dd parsing.
  ///
  /// Returns `null` if the date is valid, otherwise returns an error message.
  ///
  /// Uses `DateFormat('yyyy-MM-dd').parseStrict()` for strict validation —
  /// invalid values like `2024-01-32`, `2024-13-01`, or `2023-02-29` are
  /// correctly rejected.
  ///
  /// Parameters:
  /// - [value]: The date string to validate (yyyy-MM-dd format)
  /// - [requiredError]: Custom error message when date is empty
  /// - [invalidError]: Custom error message when date format is invalid
  ///
  /// Example:
  /// ```dart
  /// String? error = Validators.validateDate('2024-01-15');  // null (valid)
  /// String? error = Validators.validateDate('2024-01-32');  // error
  /// String? error = Validators.validateDate('2023-02-29');  // error (not a leap year)
  /// ```
  static String? validateDate(
    String? value, {
    String? requiredError,
    String? invalidError,
  }) {
    if (value == null || value.isEmpty) {
      return requiredError ?? FormLocalizations.global.dateRequired;
    }
    try {
      DateFormat('yyyy-MM-dd').parseStrict(value);
    } catch (_) {
      return invalidError ?? FormLocalizations.global.invalidDate;
    }
    return null;
  }

  /// Validates a time string format.
  ///
  /// Returns `null` if the time is valid, otherwise returns an error message.
  ///
  /// Accepts the following formats:
  /// - `HH:mm` (e.g. `14:30`)
  /// - `HH:mm:ss` (e.g. `14:30:00`)
  ///
  /// Hours must be 00–23, minutes and seconds must be 00–59.
  ///
  /// Parameters:
  /// - [value]: The time string to validate
  /// - [requiredError]: Custom error message when time is empty (default: localized "Time is required")
  /// - [invalidError]: Custom error message when time format is invalid (default: localized "Enter a valid time")
  ///
  /// Example:
  /// ```dart
  /// String? error = Validators.validateTime('14:30:00'); // null (valid)
  /// String? error = Validators.validateTime('25:99:99'); // error (invalid)
  /// ```
  static String? validateTime(
    String? value, {
    String? requiredError,
    String? invalidError,
  }) {
    if (value == null || value.isEmpty) {
      return requiredError ?? FormLocalizations.global.timeRequired;
    }
    // Strict regex: HH:mm or HH:mm:ss with proper range enforcement
    final timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)(?::([0-5]\d))?$');
    if (!timeRegex.hasMatch(value)) {
      return invalidError ?? FormLocalizations.global.invalidTime;
    }
    return null;
  }
}
