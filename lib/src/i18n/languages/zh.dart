import '../form_localizations.dart';

class ZhFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => '需要电子邮件';
  @override
  String get invalidEmail => '请输入有效的电子邮件';
  @override
  String get phoneRequired => '需要电话号码';
  @override
  String invalidPhone(String country) => '请输入有效的 $country 电话号码';
  @override
  String get countryCodeNotSupported => '不支持的国家代码';
  @override
  String get passwordRequired => '需要密码';
  @override
  String passwordMinLength(int length) => '密码必须至少包含 $length 个字符';
  @override
  String get passwordNumberAndLetter => '密码必须包含字母和数字';
  @override
  String get passwordSpecialChar => '必须包含至少一个特殊字符';
  @override
  String get passwordLowercase => '必须包含至少一个小写字母';
  @override
  String get passwordUppercase => '必须包含至少一个大写字母';
  @override
  String get passwordNoSpaces => '密码不能包含空格';
  @override
  String get nameRequired => '需要姓名';
  @override
  String get nameInvalid => '姓名无效';
  @override
  String get dateRequired => '需要日期';
  @override
  String get invalidDate => '无效的日期格式';
  @override
  String ageMin(int age) => '年龄必须至少为 $age 岁';
  @override
  String get timeRequired => '需要时间';
  @override
  String get invalidTime => '无效的时间格式';
  @override
  String get creditCardRequired => '需要信用卡号码';
  @override
  String get invalidCreditCard => '无效的信用卡号码';
  @override
  String get ibanRequired => '需要IBAN';
  @override
  String get invalidIban => '无效的IBAN号码';
}
