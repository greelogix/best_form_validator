import '../form_localizations.dart';

class FiFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'Sähköposti vaaditaan';
  @override
  String get invalidEmail => 'Anna kelvollinen sähköpostiosoite';
  @override
  String get phoneRequired => 'Puhelinnumero vaaditaan';
  @override
  String invalidPhone(String country) =>
      'Anna kelvollinen numero maahan $country';
  @override
  String get countryCodeNotSupported => 'Maakoodia ei tueta';
  @override
  String get passwordRequired => 'Salasana vaaditaan';
  @override
  String passwordMinLength(int length) =>
      'Salasanan on oltava vähintään $length merkkiä pitkä';
  @override
  String get passwordNumberAndLetter =>
      'Salasanan on sisällettävä kirjaimia ja numeroita';
  @override
  String get passwordSpecialCharacter =>
      'On sisällettävä vähintään yksi erikoismerkki';
  @override
  String get passwordLowerCase =>
      'On sisällettävä vähintään yksi pieni kirjain';
  @override
  String get passwordUpperCase => 'On sisällettävä vähintään yksi iso kirjain';
  @override
  String get passwordNoSpaces => 'Salasana ei saa sisältää välilyöntejä';
  @override
  String get nameRequired => 'Nimi vaaditaan';
  @override
  String get nameInvalid => 'Nimi on virheellinen';
  @override
  String get dateRequired => 'Päivämäärä vaaditaan';
  @override
  String get invalidDate => 'Virheellinen päivämäärämuoto';
  @override
  String ageMin(int age) => 'Sinun on oltava vähintään $age vuotta vanha';
  @override
  String get timeRequired => 'Aika vaaditaan';
  @override
  String get invalidTime => 'Virheellinen aikamuoto';
}
