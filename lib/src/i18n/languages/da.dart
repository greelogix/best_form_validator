import '../form_localizations.dart';

class DaFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'E-mail er påkrævet';
  @override
  String get invalidEmail => 'Indtast en gyldig e-mailadresse';
  @override
  String get urlRequired => 'URL er påkrævet';
  @override
  String get invalidUrl => 'Indtast en gyldig URL';
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
  String get passwordSpecialChar => 'Skal indeholde mindst ét specialtegn';
  @override
  String get passwordLowercase => 'Skal indeholde mindst ét lille bogstav';
  @override
  String get passwordUppercase => 'Skal indeholde mindst ét stort bogstav';
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
  @override
  String get creditCardRequired => 'Kreditkortnummer er påkrævet';
  @override
  String get invalidCreditCard => 'Ugyldigt kreditkortnummer';
  @override
  String get ibanRequired => 'IBAN er påkrævet';
  @override
  String get invalidIban => 'Ugyldigt IBAN-nummer';
}
