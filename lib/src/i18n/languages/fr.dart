import '../form_localizations.dart';

class FrFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'L\'adresse e-mail est requise';
  @override
  String get invalidEmail => 'Entrez une adresse e-mail valide';
  @override
  String get urlRequired => 'L\'URL est requise';
  @override
  String get invalidUrl => 'Entrez une URL valide';
  @override
  String get phoneRequired => 'Le numéro de téléphone est requis';
  @override
  String invalidPhone(String country) =>
      'Entrez un numéro valide pour $country';
  @override
  String get countryCodeNotSupported => 'Code pays non pris en charge';
  @override
  String get passwordRequired => 'Le mot de passe est requis';
  @override
  String passwordMinLength(int length) =>
      'Le mot de passe doit contenir au moins $length caractères';
  @override
  String get passwordNumberAndLetter =>
      'Le mot de passe doit contenir des lettres et des chiffres';
  @override
  String get passwordSpecialChar =>
      'Doit contenir au moins un caractère spécial';
  @override
  String get passwordLowercase => 'Doit contenir au moins une lettre minuscule';
  @override
  String get passwordUppercase => 'Doit contenir au moins une lettre majuscule';
  @override
  String get passwordNoSpaces =>
      'Le mot de passe ne doit pas contenir d\'espaces';
  @override
  String get nameRequired => 'Le nom est requis';
  @override
  String get nameInvalid => 'Le nom est invalide';
  @override
  String get dateRequired => 'La date est requise';
  @override
  String get invalidDate => 'Format de date invalide';
  @override
  String ageMin(int age) => 'Vous devez avoir au moins $age ans';
  @override
  String get timeRequired => 'L\'heure est requise';
  @override
  String get invalidTime => 'Format d\'heure invalide';
  @override
  String get creditCardRequired => 'Le numéro de carte de crédit est requis';
  @override
  String get invalidCreditCard => 'Numéro de carte de crédit invalide';
  @override
  String get ibanRequired => 'L\'IBAN est requis';
  @override
  String get invalidIban => 'Numéro IBAN invalide';
}
