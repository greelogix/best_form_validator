import '../form_localizations.dart';

class DaFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'E-mail er påkrævet';
  @override
  String get invalidEmail => 'Indtast en gyldig e-mailadresse';
  @override
  String get phoneRequired => 'Telefonnummer er påkrævet';
  @override
  String invalidPhone(String country) =>
      'Indtast et gyldigt nummer for $country';
  @override
  String get countryCodeNotSupported => 'Landekode understøttes ikke';
  @override
  String get passwordRequired => 'Adgangskode er påkrævet';
  @override
  String passwordMinLength(int length) =>
      'Adgangskoden skal være mindst $length tegn lang';
  @override
  String get passwordNumberAndLetter =>
      'Adgangskoden skal indeholde bogstaver og tal';
  @override
  String get passwordSpecialCharacter => 'Skal indeholde mindst ét specialtegn';
  @override
  String get passwordLowerCase => 'Skal indeholde mindst ét lille bogstav';
  @override
  String get passwordUpperCase => 'Skal indeholde mindst ét stort bogstav';
  @override
  String get passwordNoSpaces => 'Adgangskoden må ikke indeholde mellemrum';
  @override
  String get nameRequired => 'Navn er påkrævet';
  @override
  String get nameInvalid => 'Navnet er ugyldigt';
  @override
  String get dateRequired => 'Dato er påkrævet';
  @override
  String get invalidDate => 'Ugyldigt datoformat';
  @override
  String ageMin(int age) => 'Du skal være mindst $age år gammel';
  @override
  String get timeRequired => 'Tid er påkrævet';
  @override
  String get invalidTime => 'Ugyldigt tidsformat';
}
