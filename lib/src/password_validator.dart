class PasswordValidator {
  static String? validate(String? value,
      {bool? checkLength = true,
      int minLength = 6,
      bool? checkNumberAndLetter = false,
      bool? checkSpecialCharacter = false,
      bool? checkLowerCase = false,
      bool? checkUpperCase = false}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (checkLength! && value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }

    if (checkNumberAndLetter!) {
      bool hasLetter = value.contains(RegExp(r'[A-Za-z]'));
      bool hasDigit = value.contains(RegExp(r'\d'));
      if (!hasLetter || !hasDigit) {
        return 'Password must contain both letters and numbers';
      }
    }

    if (checkSpecialCharacter! &&
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    if (checkLowerCase! && !value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (checkUpperCase! && !value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (value.contains(" ")) {
      return 'Password must not contain spaces';
    }
    return null;
  }
}
