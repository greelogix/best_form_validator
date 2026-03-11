import '../form_localizations.dart';

class NoFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'E-post er påkrevd';
  @override
  String get invalidEmail => 'Skriv inn en gyldig e-postadresse';
  @override
  String get phoneRequired => 'Telefonnummer er påkrevd';
  @override
  String invalidPhone(String country) =>
      'Skriv inn et gyldig nummer for $country';
  @override
  String get countryCodeNotSupported => 'Landskode støttes ikke';
  @override
  String get passwordRequired => 'Passord er påkrevd';
  @override
  String passwordMinLength(int length) =>
      'Passordet må være minst $length tegn langt';
  @override
  String get passwordNumberAndLetter =>
      'Passordet må inneholde bokstaver og tall';
  @override
  String get passwordSpecialChar => 'Må inneholde minst ett spesialtegn';
  @override
  String get passwordLowercase => 'Må inneholde minst en liten bokstav';
  @override
  String get passwordUppercase => 'Må inneholde minst en stor bokstav';
  @override
  String get passwordNoSpaces => 'Passordet må ikke inneholde mellomrom';
  @override
  String get nameRequired => 'Navn er påkrevd';
  @override
  String get nameInvalid => 'Navnet er ugyldig';
  @override
  String get dateRequired => 'Dato er påkrevd';
  @override
  String get invalidDate => 'Ugyldig datoformat';
  @override
  String ageMin(int age) => 'Du må være minst $age år gammel';
  @override
  String get timeRequired => 'Tid er påkrevd';
  @override
  String get invalidTime => 'Ugyldig tidsformat';
}
