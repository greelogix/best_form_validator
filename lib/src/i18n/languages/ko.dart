import '../form_localizations.dart';

class KoFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => '이메일은 필수입니다';
  @override
  String get invalidEmail => '유효한 이메일을 입력하세요';
  @override
  String get phoneRequired => '전화번호는 필수입니다';
  @override
  String invalidPhone(String country) => '$country 에 대한 유효한 전화번호를 입력하세요';
  @override
  String get countryCodeNotSupported => '지원되지 않는 국가 코드';
  @override
  String get passwordRequired => '비밀번호는 필수입니다';
  @override
  String passwordMinLength(int length) => '비밀번호는 최소 $length 자 이상이어야 합니다';
  @override
  String get passwordNumberAndLetter => '비밀번호는 문자와 숫자를 모두 포함해야 합니다';
  @override
  String get passwordSpecialChar => '최소 하나의 특수 문자를 포함해야 합니다';
  @override
  String get passwordLowercase => '최소 하나의 소문자를 포함해야 합니다';
  @override
  String get passwordUppercase => '최소 하나의 대문자를 포함해야 합니다';
  @override
  String get passwordNoSpaces => '비밀번호에는 공백이 없어야 합니다';
  @override
  String get nameRequired => '이름은 필수입니다';
  @override
  String get nameInvalid => '이름이 유효하지 않습니다';
  @override
  String get dateRequired => '날짜는 필수입니다';
  @override
  String get invalidDate => '유효하지 않은 날짜 형식';
  @override
  String ageMin(int age) => '나이는 최소 $age 세 이상이어야 합니다';
  @override
  String get timeRequired => '시간은 필수입니다';
  @override
  String get invalidTime => '유효하지 않은 시간 형식';
}
