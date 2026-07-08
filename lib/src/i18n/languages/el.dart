import '../form_localizations.dart';

class ElFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'Απαιτείται email';
  @override
  String get invalidEmail => 'Εισάγετε έγκυρο email';
  @override
  String get phoneRequired => 'Απαιτείται αριθμός τηλεφώνου';
  @override
  String invalidPhone(String country) => 'Εισάγετε έγκυρο αριθμό για $country';
  @override
  String get countryCodeNotSupported => 'Ο κωδικός χώρας δεν υποστηρίζεται';
  @override
  String get passwordRequired => 'Απαιτείται κωδικός πρόσβασης';
  @override
  String passwordMinLength(int length) =>
      'Ο κωδικός πρέπει να έχει τουλάχιστον $length χαρακτήρες';
  @override
  String get passwordNumberAndLetter =>
      'Ο κωδικός πρέπει να περιέχει γράμματα και αριθμούς';
  @override
  String get passwordSpecialChar =>
      'Πρέπει να περιέχει τουλάχιστον έναν ειδικό χαρακτήρα';
  @override
  String get passwordLowercase =>
      'Πρέπει να περιέχει τουλάχιστον ένα πεζό γράμμα';
  @override
  String get passwordUppercase =>
      'Πρέπει να περιέχει τουλάχιστον ένα κεφαλαίο γράμμα';
  @override
  String get passwordNoSpaces => 'Ο κωδικός δεν πρέπει να περιέχει κενά';
  @override
  String get nameRequired => 'Απαιτείται όνομα';
  @override
  String get nameInvalid => 'Το όνομα δεν είναι έγκυρο';
  @override
  String get dateRequired => 'Απαιτείται ημερομηνία';
  @override
  String get invalidDate => 'Μη έγκυρη μορφή ημερομηνίας';
  @override
  String ageMin(int age) => 'Πρέπει να είστε τουλάχιστον $age ετών';
  @override
  String get timeRequired => 'Απαιτείται ώρα';
  @override
  String get invalidTime => 'Μη έγκυρη μορφή ώρας';
  @override
  String get creditCardRequired => 'Απαιτείται αριθμός πιστωτικής κάρτας';
  @override
  String get invalidCreditCard => 'Μη έγκυρος αριθμός πιστωτικής κάρτας';
  @override
  String get ibanRequired => 'Απαιτείται IBAN';
  @override
  String get invalidIban => 'Μη έγκυρος αριθμός IBAN';
}
