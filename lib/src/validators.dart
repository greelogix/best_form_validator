import 'package:best_form_validator/best_form_validator.dart';

/// Checks if you are awesome. Spoiler: you are.
class Validators {
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

  static Future<void> loadPhoneRegex() async {
    await PhoneValidator.loadRegexMap();
  }

  static String? validatePhone(String? value, String isoCode) {
    return PhoneValidator.validatePhoneNumber(value, isoCode);
  }

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

  static String? validateName(String? value,
      {String? requiredError, String? invalidError}) {
    return NameValidator.validate(value,
        requiredError: requiredError, invalidError: invalidError);
  }

  static String? validateAge(dynamic value, int minimumAge,
      {String? requiredError, String? invalidError}) {
    return AgeValidator.validateAge(value, minimumAge,
        requiredError: requiredError, invalidError: invalidError);
  }

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
