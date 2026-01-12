import '../form_localizations.dart';

class RuFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'Электронная почта обязательна';
  @override
  String get invalidEmail => 'Введите действительный адрес электронной почты';
  @override
  String get phoneRequired => 'Номер телефона обязателен';
  @override
  String invalidPhone(String country) => 'Введите действительный номер для $country';
  @override
  String get countryCodeNotSupported => 'Код страны не поддерживается';
  @override
  String get passwordRequired => 'Пароль обязателен';
  @override
  String passwordMinLength(int length) => 'Пароль должен содержать не менее $length символов';
  @override
  String get passwordNumberAndLetter => 'Пароль должен содержать буквы и цифры';
  @override
  String get passwordSpecialCharacter => 'Должен содержать хотя бы один специальный символ';
  @override
  String get passwordLowerCase => 'Должен содержать хотя бы одну строчную букву';
  @override
  String get passwordUpperCase => 'Должен содержать хотя бы одну заглавную букву';
  @override
  String get passwordNoSpaces => 'Пароль не должен содержать пробелов';
  @override
  String get nameRequired => 'Имя обязательно';
  @override
  String get nameInvalid => 'Имя недействительно';
  @override
  String get dateRequired => 'Дата обязательна';
  @override
  String get invalidDate => 'Неверный формат даты';
  @override
  String ageMin(int age) => 'Возраст должен быть не менее $age лет';
  @override
  String get timeRequired => 'Время обязательно';
  @override
  String get invalidTime => 'Неверный формат времени';
}
