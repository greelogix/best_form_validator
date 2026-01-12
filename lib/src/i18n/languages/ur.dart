import '../form_localizations.dart';

class UrFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'ای میل درکار ہے';
  @override
  String get invalidEmail => 'درست ای میل درج کریں';
  @override
  String get phoneRequired => 'فون نمبر درکار ہے';
  @override
  String invalidPhone(String country) => '$country کے لیے درست فون نمبر درج کریں';
  @override
  String get countryCodeNotSupported => 'ملک کا کوڈ سپورٹڈ نہیں ہے';
  @override
  String get passwordRequired => 'پاس ورڈ درکار ہے';
  @override
  String passwordMinLength(int length) => 'پاس ورڈ کم از کم $length حروف کا ہونا چاہیے';
  @override
  String get passwordNumberAndLetter => 'پاس ورڈ میں حروف اور نمبر دونوں ہونے چاہئیں';
  @override
  String get passwordSpecialCharacter => 'کم از کم ایک خاص کردار ہونا چاہیے';
  @override
  String get passwordLowerCase => 'کم از کم ایک چھوٹا حرف ہونا چاہیے';
  @override
  String get passwordUpperCase => 'کم از کم ایک بڑا حرف ہونا چاہیے';
  @override
  String get passwordNoSpaces => 'پاس ورڈ میں خالی جگہ نہیں ہونی چاہیے';
  @override
  String get nameRequired => 'نام درکار ہے';
  @override
  String get nameInvalid => 'نام غلط ہے';
  @override
  String get dateRequired => 'تاریخ درکار ہے';
  @override
  String get invalidDate => 'غلط تاریخ کا فارمیٹ';
  @override
  String ageMin(int age) => 'عمر کم از کم $age سال ہونی چاہیے';
  @override
  String get timeRequired => 'وقت درکار ہے';
  @override
  String get invalidTime => 'غلط وقت کا فارمیٹ';
}
