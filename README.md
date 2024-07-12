<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

best_form_validator is a comprehensive Flutter package designed to simplify form validation. It provides a robust set of validation functions for various form fields, including email, phone, password, name, and age. The package supports phone number validation according to different countries' phone number formats, making it versatile for international applications.

## Features

Email Validation: Ensure that email addresses are in the correct format.
Phone Number Validation: Validate phone numbers based on different countries' formats.
Password Validation: Flexible password validation with criteria such as length, inclusion of numbers, letters, special characters, lowercase, and uppercase letters.
Name Validation: Validate names to ensure they do not contain special characters, numbers, or leading/trailing spaces.
Age Validation: Validate age from a DateTime or string input, with a configurable minimum age limit.

## Getting started

Installation
Add the following to your pubspec.yaml:

dependencies:
best_form_validator: ^1.0.0
Run flutter pub get to install the package.

## Usage

Email Validation

import 'package:best_form_validator/email_validator.dart';

String? emailError = EmailValidator.validate('example@domain.com');

Phone Number Validation

import 'package:best_form_validator/phone_validator.dart';

 Load phone regex map (should be done at app initialization) if you will not call this function
 before utilizing any function then phone verification will not work
 await Validators.loadPhoneRegex();

PhoneValidator phoneValidator = PhoneValidator('US');
String? phoneError = phoneValidator.validate('+12345678901');
to `/example` folder. 

```dart
import 'package:best_form_validator/password_validator.dart';

///Password validation
PasswordValidator passwordValidator = PasswordValidator(
  checkLength: true,
  checkNumberAndLetter: true,
  checkSpecialCharacter: true,
  checkLowerCase: true,
  checkUpperCase: true,
  minLength: 8,
);

String? passwordError = passwordValidator.validate('Password1!');

//Name Validation
String? nameError = NameValidator.validate('John Doe');

```

## Additional information
