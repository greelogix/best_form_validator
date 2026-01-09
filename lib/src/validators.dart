import 'package:best_form_validator/best_form_validator.dart';

/// Main validator class providing static methods for all validation types.
///
/// This class serves as the primary API for the best_form_validator package.
/// All validation methods are static and can be used directly without instantiation.
///
/// **Important:** For phone validation, you must call [loadPhoneRegex] at app startup.
///
/// Example:
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await Validators.loadPhoneRegex();
///   runApp(MyApp());
/// }
/// ```
class Validators {
  /// Validates an email address.
  ///
  /// Returns `null` if the email is valid, otherwise returns an error message.
  ///
  /// Parameters:
  /// - [value]: The email address to validate
  /// - [requiredError]: Custom error message when email is empty (default: "Email is required")
  /// - [invalidError]: Custom error message when email format is invalid (default: "Enter a valid email")
  ///
  /// Example:
  /// ```dart
  /// String? error = Validators.validateEmail('user@example.com');
  /// if (error != null) {
  ///   print(error); // null if valid
  /// }
  /// ```
  static String? validateEmail(String? value,
      {String? requiredError, String? invalidError}) {
    if (value == null || value.isEmpty) {
      return requiredError ?? 'Email is required';
    }
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return invalidError ?? 'Enter a valid email';
    }

    return null;
  }

  /// Loads phone number regex patterns for validation.
  ///
  /// **Must be called at app startup before using [validatePhone].**
  ///
  /// This method loads country-specific phone number validation patterns
  /// from the bundled JSON asset file.
  ///
  /// Example:
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await Validators.loadPhoneRegex();
  ///   runApp(MyApp());
  /// }
  /// ```
  static Future<void> loadPhoneRegex() async {
    await PhoneValidator.loadRegexMap();
  }

  /// Validates a phone number for a specific country.
  ///
  /// Returns `null` if the phone number is valid for the given country,
  /// otherwise returns an error message.
  ///
  /// **Important:** You must call [loadPhoneRegex] before using this method.
  ///
  /// Parameters:
  /// - [value]: The phone number to validate (should include country code)
  /// - [isoCode]: The ISO country code (e.g., 'US', 'UK', 'PK')
  ///
  /// Supported countries: US, CA, UK, FR, DE, IN, AU, BR, CN, JP, MX, RU, ZA,
  /// NG, EG, KE, GH, SA, AE, IT, ES, SE, NO, FI, DK, NL, BE, CH, AT, PT, GR,
  /// TR, IR, PK, BD, LK, TH, MY, SG, ID, PH, VN, KR, HK, TW, NZ, AF, AL, DZ,
  /// AR, AZ, BH
  ///
  /// Example:
  /// ```dart
  /// String? error = Validators.validatePhone('+12025551234', 'US');
  /// ```
  static String? validatePhone(String? value, String isoCode,
      {String? requiredError, bool isRequired = true, String? invalidError}) {
    return PhoneValidator.validatePhoneNumber(value, isoCode,
        requiredError: requiredError,
        isRequired: isRequired,
        invalidError: invalidError);
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
  static String? validatePassword(String? value,
      {bool? checkLength = true,
      int minLength = 6,
      bool? checkNumberAndLetter = false,
      bool? checkSpecialCharacter = false,
      bool? checkLowerCase = false,
      bool? checkUpperCase = false}) {
    return PasswordValidator.validate(value,
        checkLength: checkLength,
        minLength: minLength,
        checkNumberAndLetter: checkNumberAndLetter,
        checkSpecialCharacter: checkSpecialCharacter,
        checkLowerCase: checkLowerCase,
        checkUpperCase: checkUpperCase);
  }

  /// Validates a name to ensure proper formatting.
  ///
  /// Returns `null` if the name is valid, otherwise returns an error message.
  ///
  /// Name validation rules:
  /// - Only alphabetic characters and spaces allowed
  /// - No leading or trailing spaces
  /// - No multiple consecutive spaces
  /// - No special characters or numbers
  ///
  /// Parameters:
  /// - [value]: The name to validate
  /// - [requiredError]: Custom error message when name is empty (default: "Name is required")
  /// - [invalidError]: Custom error message when name format is invalid (default: "Name is invalid")
  ///
  /// Example:
  /// ```dart
  /// String? error = Validators.validateName('John Doe');
  /// ```
  static String? validateName(String? value,
      {String? requiredError, String? invalidError}) {
    return NameValidator.validate(value,
        requiredError: requiredError, invalidError: invalidError);
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
  static String? validateAge(dynamic value, int minimumAge,
      {String? requiredError, String? invalidError}) {
    return AgeValidator.validateAge(value, minimumAge,
        requiredError: requiredError, invalidError: invalidError);
  }

  /// Validates a date string can be properly parsed.
  ///
  /// Returns `null` if the date is valid, otherwise returns an error message.
  ///
  /// Parameters:
  /// - [value]: The date string to validate
  /// - [requiredError]: Custom error message when date is empty (default: "Date is required")
  /// - [invalidError]: Custom error message when date format is invalid (default: "Enter a valid date")
  ///
  /// Example:
  /// ```dart
  /// String? error = Validators.validateDate('2024-01-15');
  /// ```
  static String? validateDate(String? value,
      {String? requiredError, String? invalidError}) {
    if (value == null || value.isEmpty) {
      return requiredError ?? 'Date is required';
    }
    try {
      DateTime.parse(value);
    } catch (_) {
      return invalidError ?? 'Enter a valid date';
    }
    return null;
  }

  /// Validates a time string format.
  ///
  /// Returns `null` if the time is valid, otherwise returns an error message.
  ///
  /// Parameters:
  /// - [value]: The time string to validate
  /// - [requiredError]: Custom error message when time is empty (default: "Time is required")
  /// - [invalidError]: Custom error message when time format is invalid (default: "Enter a valid time")
  ///
  /// Example:
  /// ```dart
  /// String? error = Validators.validateTime('14:30:00');
  /// ```
  static String? validateTime(String? value,
      {String? requiredError, String? invalidError}) {
    if (value == null || value.isEmpty) {
      return requiredError ?? 'Time is required';
    }
    try {
      DateTime.parse('1970-01-01 $value');
    } catch (_) {
      return invalidError ?? 'Enter a valid time';
    }
    return null;
  }
}
