import '../form_localizations.dart';

class DeFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'E-Mail ist erforderlich';
  @override
  String get invalidEmail => 'Geben Sie eine gültige E-Mail ein';
  @override
  String get phoneRequired => 'Telefonnummer ist erforderlich';
  @override
  String invalidPhone(String country) => 'Geben Sie eine gültige Nummer für $country ein';
  @override
  String get countryCodeNotSupported => 'Ländercode nicht unterstützt';
  @override
  String get passwordRequired => 'Passwort ist erforderlich';
  @override
  String passwordMinLength(int length) => 'Passwort muss mindestens $length Zeichen lang sein';
  @override
  String get passwordNumberAndLetter => 'Passwort muss Buchstaben und Zahlen enthalten';
  @override
  String get passwordSpecialCharacter => 'Muss mindestens ein Sonderzeichen enthalten';
  @override
  String get passwordLowerCase => 'Muss mindestens einen Kleinbuchstaben enthalten';
  @override
  String get passwordUpperCase => 'Muss mindestens einen Großbuchstaben enthalten';
  @override
  String get passwordNoSpaces => 'Passwort darf keine Leerzeichen enthalten';
  @override
  String get nameRequired => 'Name ist erforderlich';
  @override
  String get nameInvalid => 'Name ist ungültig';
  @override
  String get dateRequired => 'Datum ist erforderlich';
  @override
  String get invalidDate => 'Ungültiges Datumsformat';
  @override
  String ageMin(int age) => 'Sie müssen mindestens $age Jahre alt sein';
  @override
  String get timeRequired => 'Zeit ist erforderlich';
  @override
  String get invalidTime => 'Ungültiges Zeitformat';
}
