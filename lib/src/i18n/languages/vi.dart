import '../form_localizations.dart';

class ViFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'Email là bắt buộc';
  @override
  String get invalidEmail => 'Nhập email hợp lệ';
  @override
  String get phoneRequired => 'Số điện thoại là bắt buộc';
  @override
  String invalidPhone(String country) =>
      'Nhập số điện thoại hợp lệ cho $country';
  @override
  String get countryCodeNotSupported => 'Mã quốc gia không được hỗ trợ';
  @override
  String get passwordRequired => 'Mật khẩu là bắt buộc';
  @override
  String passwordMinLength(int length) =>
      'Mật khẩu phải có ít nhất $length ký tự';
  @override
  String get passwordNumberAndLetter => 'Mật khẩu phải chứa cả chữ cái và số';
  @override
  String get passwordSpecialChar => 'Phải chứa ít nhất một ký tự đặc biệt';
  @override
  String get passwordLowercase => 'Phải chứa ít nhất một chữ cái thường';
  @override
  String get passwordUppercase => 'Phải chứa ít nhất một chữ cái hoa';
  @override
  String get passwordNoSpaces => 'Mật khẩu không được chứa khoảng trắng';
  @override
  String get nameRequired => 'Tên là bắt buộc';
  @override
  String get nameInvalid => 'Tên không hợp lệ';
  @override
  String get dateRequired => 'Ngày là bắt buộc';
  @override
  String get invalidDate => 'Định dạng ngày không hợp lệ';
  @override
  String ageMin(int age) => 'Tuổi phải ít nhất $age tuổi';
  @override
  String get timeRequired => 'Thời gian là bắt buộc';
  @override
  String get invalidTime => 'Định dạng thời gian không hợp lệ';
  @override
  String get creditCardRequired => 'Số thẻ tín dụng là bắt buộc';
  @override
  String get invalidCreditCard => 'Số thẻ tín dụng không hợp lệ';
  @override
  String get ibanRequired => 'IBAN là bắt buộc';
  @override
  String get invalidIban => 'Số IBAN không hợp lệ';
}
