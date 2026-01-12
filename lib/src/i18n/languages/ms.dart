import '../form_localizations.dart';

class MsFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'Emel diperlukan';
  @override
  String get invalidEmail => 'Masukkan emel yang sah';
  @override
  String get phoneRequired => 'Nombor telefon diperlukan';
  @override
  String invalidPhone(String country) =>
      'Masukkan nombor telefon yang sah untuk $country';
  @override
  String get countryCodeNotSupported => 'Kod negara tidak disokong';
  @override
  String get passwordRequired => 'Kata laluan diperlukan';
  @override
  String passwordMinLength(int length) =>
      'Kata laluan mesti sekurang-kurangnya $length aksara';
  @override
  String get passwordNumberAndLetter =>
      'Kata laluan mesti mengandungi huruf dan nombor';
  @override
  String get passwordSpecialCharacter =>
      'Mesti mengandungi sekurang-kurangnya satu aksara khas';
  @override
  String get passwordLowerCase =>
      'Mesti mengandungi sekurang-kurangnya satu huruf kecil';
  @override
  String get passwordUpperCase =>
      'Mesti mengandungi sekurang-kurangnya satu huruf besar';
  @override
  String get passwordNoSpaces => 'Kata laluan tidak boleh mengandungi ruang';
  @override
  String get nameRequired => 'Nama diperlukan';
  @override
  String get nameInvalid => 'Nama tidak sah';
  @override
  String get dateRequired => 'Tarikh diperlukan';
  @override
  String get invalidDate => 'Format tarikh tidak sah';
  @override
  String ageMin(int age) => 'Umur mesti sekurang-kurangnya $age tahun';
  @override
  String get timeRequired => 'Masa diperlukan';
  @override
  String get invalidTime => 'Format masa tidak sah';
}
