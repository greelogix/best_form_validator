import '../form_localizations.dart';

class ItFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'L\'email è richiesta';
  @override
  String get invalidEmail => 'Inserisci un\'email valida';
  @override
  String get phoneRequired => 'Il numero di telefono è richiesto';
  @override
  String invalidPhone(String country) =>
      'Inserisci un numero valido per $country';
  @override
  String get countryCodeNotSupported => 'Codice paese non supportato';
  @override
  String get passwordRequired => 'La password è richiesta';
  @override
  String passwordMinLength(int length) =>
      'La password deve contenere almeno $length caratteri';
  @override
  String get passwordNumberAndLetter =>
      'La password deve contenere lettere e numeri';
  @override
  String get passwordSpecialChar =>
      'Deve contenere almeno un carattere speciale';
  @override
  String get passwordLowercase => 'Deve contenere almeno una lettera minuscola';
  @override
  String get passwordUppercase => 'Deve contenere almeno una lettera maiuscola';
  @override
  String get passwordNoSpaces => 'La password non deve contenere spazi';
  @override
  String get nameRequired => 'Il nome è richiesto';
  @override
  String get nameInvalid => 'Il nome non è valido';
  @override
  String get dateRequired => 'La data è richiesta';
  @override
  String get invalidDate => 'Formato data non valido';
  @override
  String ageMin(int age) => 'Devi avere almeno $age anni';
  @override
  String get timeRequired => 'L\'ora è richiesta';
  @override
  String get invalidTime => 'Formato ora non valido';
}
