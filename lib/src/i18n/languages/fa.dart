import '../form_localizations.dart';

class FaFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'ایمیل مورد نیاز است';
  @override
  String get invalidEmail => 'ایمیل معتبر وارد کنید';
  @override
  String get phoneRequired => 'شماره تلفن مورد نیاز است';
  @override
  String invalidPhone(String country) => 'شماره معتبر برای $country وارد کنید';
  @override
  String get countryCodeNotSupported => 'کد کشور پشتیبانی نمی‌شود';
  @override
  String get passwordRequired => 'رمز عبور مورد نیاز است';
  @override
  String passwordMinLength(int length) =>
      'رمز عبور باید حداقل $length کاراکتر باشد';
  @override
  String get passwordNumberAndLetter => 'رمز عبور باید شامل حروف و اعداد باشد';
  @override
  String get passwordSpecialCharacter => 'باید حداقل یک کاراکتر خاص داشته باشد';
  @override
  String get passwordLowerCase => 'باید حداقل یک حرف کوچک داشته باشد';
  @override
  String get passwordUpperCase => 'باید حداقل یک حرف بزرگ داشته باشد';
  @override
  String get passwordNoSpaces => 'رمز عبور نباید شامل فاصله باشد';
  @override
  String get nameRequired => 'نام مورد نیاز است';
  @override
  String get nameInvalid => 'نام نامعتبر است';
  @override
  String get dateRequired => 'تاریخ مورد نیاز است';
  @override
  String get invalidDate => 'فرمت تاریخ نامعتبر است';
  @override
  String ageMin(int age) => 'سن باید حداقل $age سال باشد';
  @override
  String get timeRequired => 'زمان مورد نیاز است';
  @override
  String get invalidTime => 'فرمت زمان نامعتبر است';
}
