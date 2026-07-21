import '../form_localizations.dart';

class IdFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'Email wajib diisi';
  @override
  String get invalidEmail => 'Masukkan email yang valid';
  @override
  String get urlRequired => 'URL wajib diisi';
  @override
  String get invalidUrl => 'Masukkan URL yang valid';
  @override
  String get phoneRequired => 'Nomor telepon wajib diisi';
  @override
  String invalidPhone(String country) =>
      'Masukkan nomor telepon yang valid untuk $country';
  @override
  String get countryCodeNotSupported => 'Kode negara tidak didukung';
  @override
  String get passwordRequired => 'Kata sandi wajib diisi';
  @override
  String passwordMinLength(int length) =>
      'Kata sandi harus terdiri dari minimal $length karakter';
  @override
  String get passwordNumberAndLetter =>
      'Kata sandi harus mengandung huruf dan angka';
  @override
  String get passwordSpecialChar =>
      'Harus mengandung setidaknya satu karakter khusus';
  @override
  String get passwordLowercase =>
      'Harus mengandung setidaknya satu huruf kecil';
  @override
  String get passwordUppercase =>
      'Harus mengandung setidaknya satu huruf besar';
  @override
  String get passwordNoSpaces => 'Kata sandi tidak boleh mengandung spasi';
  @override
  String get nameRequired => 'Nama wajib diisi';
  @override
  String get nameInvalid => 'Nama tidak valid';
  @override
  String get dateRequired => 'Tanggal wajib diisi';
  @override
  String get invalidDate => 'Format tanggal tidak valid';
  @override
  String ageMin(int age) => 'Usia harus minimal $age tahun';
  @override
  String get timeRequired => 'Waktu wajib diisi';
  @override
  String get invalidTime => 'Format waktu tidak valid';
  @override
  String get creditCardRequired => 'Nomor kartu kredit wajib diisi';
  @override
  String get invalidCreditCard => 'Nomor kartu kredit tidak valid';
  @override
  String get ibanRequired => 'IBAN wajib diisi';
  @override
  String get invalidIban => 'Nomor IBAN tidak valid';
}
