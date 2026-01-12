import '../form_localizations.dart';

class TrFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'E-posta gereklidir';
  @override
  String get invalidEmail => 'Geçerli bir e-posta girin';
  @override
  String get phoneRequired => 'Telefon numarası gereklidir';
  @override
  String invalidPhone(String country) =>
      '$country için geçerli bir numara girin';
  @override
  String get countryCodeNotSupported => 'Ülke kodu desteklenmiyor';
  @override
  String get passwordRequired => 'Şifre gereklidir';
  @override
  String passwordMinLength(int length) =>
      'Şifre en az $length karakter uzunluğunda olmalıdır';
  @override
  String get passwordNumberAndLetter =>
      'Şifre hem harf hem de rakam içermelidir';
  @override
  String get passwordSpecialCharacter => 'En az bir özel karakter içermelidir';
  @override
  String get passwordLowerCase => 'En az bir küçük harf içermelidir';
  @override
  String get passwordUpperCase => 'En az bir büyük harf içermelidir';
  @override
  String get passwordNoSpaces => 'Şifre boşluk içermemelidir';
  @override
  String get nameRequired => 'Ad gereklidir';
  @override
  String get nameInvalid => 'Ad geçersiz';
  @override
  String get dateRequired => 'Tarih gereklidir';
  @override
  String get invalidDate => 'Geçersiz tarih formatı';
  @override
  String ageMin(int age) => 'Yaşınız en az $age olmalıdır';
  @override
  String get timeRequired => 'Zaman gereklidir';
  @override
  String get invalidTime => 'Geçersiz zaman formatı';
}
