import 'package:flutter_form_validator/flutter_form_validator.dart';

void main() {
  String? isValidEmail = Validators.validateEmail("example@gmail.com",requiredError: "Email is required",invalidError: "Email is not valid");
  String? isNameValid = Validators.validateName("example@gmail.com",requiredError: "Email is required",invalidError: "Email is not valid");
}
