import '../form_localizations.dart';

class SvFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'E-post krävs';
  @override
  String get invalidEmail => 'Ange en giltig e-postadress';
  @override
  String get urlRequired => 'URL krävs';
  @override
  String get invalidUrl => 'Ange en giltig URL';
  @override
  String get phoneRequired => 'Telefonnummer krävs';
  @override
  String invalidPhone(String country) => 'Ange ett giltigt nummer för $country';
  @override
  String get countryCodeNotSupported => 'Landskod stöds inte';
  @override
  String get passwordRequired => 'Lösenord krävs';
  @override
  String passwordMinLength(int length) =>
      'Lösenordet måste vara minst $length tecken långt';
  @override
  String get passwordNumberAndLetter =>
      'Lösenordet måste innehålla bokstäver och siffror';
  @override
  String get passwordSpecialChar => 'Måste innehålla minst ett specialtecken';
  @override
  String get passwordLowercase => 'Måste innehålla minst en liten bokstav';
  @override
  String get passwordUppercase => 'Måste innehålla minst en stor bokstav';
  @override
  String get passwordNoSpaces => 'Lösenordet får inte innehålla mellanslag';
  @override
  String get nameRequired => 'Namn krävs';
  @override
  String get nameInvalid => 'Namnet är ogiltigt';
  @override
  String get dateRequired => 'Datum krävs';
  @override
  String get invalidDate => 'Ogiltigt datumformat';
  @override
  String ageMin(int age) => 'Du måste vara minst $age år gammal';
  @override
  String get timeRequired => 'Tid krävs';
  @override
  String get invalidTime => 'Ogiltigt tidsformat';
  @override
  String get creditCardRequired => 'Kreditkortsnummer krävs';
  @override
  String get invalidCreditCard => 'Ogiltigt kreditkortsnummer';
  @override
  String get ibanRequired => 'IBAN krävs';
  @override
  String get invalidIban => 'Ogiltigt IBAN-nummer';
}
