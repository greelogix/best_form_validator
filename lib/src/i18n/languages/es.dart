import '../form_localizations.dart';

class EsFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'El correo electrónico es obligatorio';
  @override
  String get invalidEmail => 'Ingrese un correo electrónico válido';
  @override
  String get urlRequired => 'La URL es obligatoria';
  @override
  String get invalidUrl => 'Ingrese una URL válida';
  @override
  String get phoneRequired => 'El número de teléfono es obligatorio';
  @override
  String invalidPhone(String country) =>
      'Ingrese un número válido para $country';
  @override
  String get countryCodeNotSupported => 'Código de país no compatible';
  @override
  String get passwordRequired => 'La contraseña es obligatoria';
  @override
  String passwordMinLength(int length) =>
      'La contraseña debe tener al menos $length caracteres';
  @override
  String get passwordNumberAndLetter =>
      'La contraseña debe contener letras y números';
  @override
  String get passwordSpecialChar =>
      'Debe contener al menos un carácter especial';
  @override
  String get passwordLowercase => 'Debe contener al menos una letra minúscula';
  @override
  String get passwordUppercase => 'Debe contener al menos una letra mayúscula';
  @override
  String get passwordNoSpaces => 'La contraseña no debe contener espacios';
  @override
  String get nameRequired => 'El nombre es obligatorio';
  @override
  String get nameInvalid => 'El nombre no es válido';
  @override
  String get dateRequired => 'La fecha es obligatoria';
  @override
  String get invalidDate => 'Formato de fecha inválido';
  @override
  String ageMin(int age) => 'Debe tener al menos $age años';
  @override
  String get timeRequired => 'La hora es obligatoria';
  @override
  String get invalidTime => 'Formato de hora inválido';
  @override
  String get creditCardRequired =>
      'El número de tarjeta de crédito es obligatorio';
  @override
  String get invalidCreditCard => 'Número de tarjeta de crédito inválido';
  @override
  String get ibanRequired => 'El IBAN es obligatorio';
  @override
  String get invalidIban => 'Número de IBAN inválido';
}
