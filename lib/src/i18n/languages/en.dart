import '../form_localizations.dart';

class EnFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'Email is required';
  @override
  String get invalidEmail => 'Enter a valid email';
  @override
  String get phoneRequired => 'Phone number is required';
  @override
  String invalidPhone(String country) =>
      'Enter a valid phone number for $country';
  @override
  String get countryCodeNotSupported => 'Country code not supported';
  @override
  String get passwordRequired => 'Password is required';
  @override
  String passwordMinLength(int length) =>
      'Password must be at least $length characters long';
  @override
  String get passwordNumberAndLetter =>
      'Password must contain both letters and numbers';
  @override
  String get passwordSpecialCharacter =>
      'Password must contain at least one special character';
  @override
  String get passwordLowerCase =>
      'Password must contain at least one lowercase letter';
  @override
  String get passwordUpperCase =>
      'Password must contain at least one uppercase letter';
  @override
  String get passwordNoSpaces => 'Password must not contain spaces';
  @override
  String get nameRequired => 'Name is required';
  @override
  String get nameInvalid => 'Name is invalid';
  @override
  String get dateRequired => 'Date is required';
  @override
  String get invalidDate => 'Invalid date format';
  @override
  String ageMin(int age) => 'Age must be at least $age years old';
  @override
  String get timeRequired => 'Time is required';
  @override
  String get invalidTime => 'Invalid time format';
}
