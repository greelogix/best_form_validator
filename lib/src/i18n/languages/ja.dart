import '../form_localizations.dart';

class JaFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'メールアドレスは必須です';
  @override
  String get invalidEmail => '有効なメールアドレスを入力してください';
  @override
  String get phoneRequired => '電話番号は必須です';
  @override
  String invalidPhone(String country) => '$country の有効な電話番号を入力してください';
  @override
  String get countryCodeNotSupported => 'サポートされていない国コード';
  @override
  String get passwordRequired => 'パスワードは必須です';
  @override
  String passwordMinLength(int length) => 'パスワードは少なくとも $length 文字である必要があります';
  @override
  String get passwordNumberAndLetter => 'パスワードには文字と数字の両方を含める必要があります';
  @override
  String get passwordSpecialChar => '少なくとも1つの特殊文字を含める必要があります';
  @override
  String get passwordLowercase => '少なくとも1つの小文字を含める必要があります';
  @override
  String get passwordUppercase => '少なくとも1つの大文字を含める必要があります';
  @override
  String get passwordNoSpaces => 'パスワードにスペースを含めることはできません';
  @override
  String get nameRequired => '名前は必須です';
  @override
  String get nameInvalid => '名前が無効です';
  @override
  String get dateRequired => '日付は必須です';
  @override
  String get invalidDate => '無効な日付形式';
  @override
  String ageMin(int age) => '年齢は少なくとも $age 歳である必要があります';
  @override
  String get timeRequired => '時間は必須です';
  @override
  String get invalidTime => '無効な時間形式';
}
