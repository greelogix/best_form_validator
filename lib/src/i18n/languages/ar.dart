import '../form_localizations.dart';

class ArFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';
  @override
  String get invalidEmail => 'أدخل بريداً إلكترونياً صالحاً';
  @override
  String get phoneRequired => 'رقم الهاتف مطلوب';
  @override
  String invalidPhone(String country) => 'أدخل رقم هاتف صالح لـ $country';
  @override
  String get countryCodeNotSupported => 'رمز البلد غير مدعوم';
  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';
  @override
  String passwordMinLength(int length) => 'يجب أن تكون كلمة المرور على الأقل $length أحرف';
  @override
  String get passwordNumberAndLetter => 'يجب أن تحتوي كلمة المرور على حروف وأرقام';
  @override
  String get passwordSpecialCharacter => 'يجب أن تحتوي على رمز خاص واحد على الأقل';
  @override
  String get passwordLowerCase => 'يجب أن تحتوي على حرف صغير واحد على الأقل';
  @override
  String get passwordUpperCase => 'يجب أن تحتوي على حرف كبير واحد على الأقل';
  @override
  String get passwordNoSpaces => 'يجب ألا تحتوي كلمة المرور على مسافات';
  @override
  String get nameRequired => 'الاسم مطلوب';
  @override
  String get nameInvalid => 'الاسم غير صالح';
  @override
  String get dateRequired => 'التاريخ مطلوب';
  @override
  String get invalidDate => 'تنسيق التاريخ غير صالح';
  @override
  String ageMin(int age) => 'يجب أن يكون العمر $age سنوات على الأقل';
  @override
  String get timeRequired => 'الوقت مطلوب';
  @override
  String get invalidTime => 'تنسيق الوقت غير صالح';
}
