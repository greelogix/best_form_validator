import '../form_localizations.dart';

class PtFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'E-mail é obrigatório';
  @override
  String get invalidEmail => 'Digite um e-mail válido';
  @override
  String get phoneRequired => 'Número de telefone é obrigatório';
  @override
  String invalidPhone(String country) =>
      'Digite um número válido para $country';
  @override
  String get countryCodeNotSupported => 'Código do país não suportado';
  @override
  String get passwordRequired => 'Senha é obrigatória';
  @override
  String passwordMinLength(int length) =>
      'A senha deve ter pelo menos $length caracteres';
  @override
  String get passwordNumberAndLetter => 'A senha deve conter letras e números';
  @override
  String get passwordSpecialChar =>
      'Deve conter pelo menos um caractere especial';
  @override
  String get passwordLowercase => 'Deve conter pelo menos uma letra minúscula';
  @override
  String get passwordUppercase => 'Deve conter pelo menos uma letra maiúscula';
  @override
  String get passwordNoSpaces => 'A senha não deve conter espaços';
  @override
  String get nameRequired => 'Nome é obrigatório';
  @override
  String get nameInvalid => 'Nome inválido';
  @override
  String get dateRequired => 'Data é obrigatória';
  @override
  String get invalidDate => 'Formato de data inválido';
  @override
  String ageMin(int age) => 'A idade deve ser de pelo menos $age anos';
  @override
  String get timeRequired => 'Hora é obrigatória';
  @override
  String get invalidTime => 'Formato de hora inválido';
  @override
  String get creditCardRequired => 'Número do cartão de crédito é obrigatório';
  @override
  String get invalidCreditCard => 'Número de cartão de crédito inválido';
  @override
  String get ibanRequired => 'IBAN é obrigatório';
  @override
  String get invalidIban => 'Número IBAN inválido';
}
