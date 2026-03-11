import '../form_localizations.dart';

class NlFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'E-mail is verplicht';
  @override
  String get invalidEmail => 'Voer een geldig e-mailadres in';
  @override
  String get phoneRequired => 'Telefoonnummer is verplicht';
  @override
  String invalidPhone(String country) =>
      'Voer een geldig nummer in voor $country';
  @override
  String get countryCodeNotSupported => 'Landcode niet ondersteund';
  @override
  String get passwordRequired => 'Wachtwoord is verplicht';
  @override
  String passwordMinLength(int length) =>
      'Wachtwoord moet minimaal $length tekens lang zijn';
  @override
  String get passwordNumberAndLetter =>
      'Wachtwoord moet letters en cijfers bevatten';
  @override
  String get passwordSpecialChar => 'Moet minimaal één speciaal teken bevatten';
  @override
  String get passwordLowercase => 'Moet minimaal één kleine letter bevatten';
  @override
  String get passwordUppercase => 'Moet minimaal één hoofdletter bevatten';
  @override
  String get passwordNoSpaces => 'Wachtwoord mag geen spaties bevatten';
  @override
  String get nameRequired => 'Naam is verplicht';
  @override
  String get nameInvalid => 'Naam is ongeldig';
  @override
  String get dateRequired => 'Datum is verplicht';
  @override
  String get invalidDate => 'Ongeldige datumindeling';
  @override
  String ageMin(int age) => 'U moet minimaal $age jaar oud zijn';
  @override
  String get timeRequired => 'Tijd is verplicht';
  @override
  String get invalidTime => 'Ongeldige tijdsindeling';
}
