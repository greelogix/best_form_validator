import 'package:flutter/cupertino.dart';
import 'package:flutter_form_validator/flutter_form_validator.dart';
import 'package:test/test.dart';

void main() {
  group('Validators', () {
    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await PhoneValidator.loadRegexMap();
    });
    test('validateEmail returns error when email is empty', () {
      final result = Validators.validateEmail('');
      expect(result, 'Email is required');
    });

    test('validateEmail returns error when email is invalid', () {
      final result = Validators.validateEmail('invalid_email');
      expect(result, 'Enter a valid email');
    });

    test('validateEmail returns null when email is valid', () {
      final result = Validators.validateEmail('test@example.com');
      expect(result, null);
    });

    test('validatePhone returns error when phone is empty', () {
      final result = Validators.validatePhone('', "US");
      expect(result, 'Phone number is required');
    });

    test('validatePhone returns error when phone is invalid', () {
      final result = Validators.validatePhone('123', "UK");
      expect(result, 'Enter a valid phone number for UK');
    });

    test('validatePhone returns null when phone is valid', () {
      final result = Validators.validatePhone('+921234567890', "PK");
      expect(result, null);
    });

    ///password validation tests
    ///
    test('Valid password with all criteria', () {
      expect(
        Validators.validatePassword('Password1!',
            checkUpperCase: true,
            checkLowerCase: true,
            checkSpecialCharacter: true,
            checkLength: true,
            checkNumberAndLetter: true),
        isNull,
      );
    });

    test('Invalid password - too short', () {
      expect(
          Validators.validatePassword('Pwd1!',
              checkUpperCase: true,
              checkLowerCase: true,
              checkSpecialCharacter: true,
              checkLength: true,
              checkNumberAndLetter: true),
          'Password must be at least 6 characters long');
    });

    test('Invalid password - missing special character', () {
      expect(
          Validators.validatePassword('Password1',
              checkUpperCase: true,
              checkLowerCase: true,
              checkSpecialCharacter: true,
              checkLength: true,
              checkNumberAndLetter: true),
          'Password must contain at least one special character');
    });

    test('Invalid password - missing lowercase letter', () {
      expect(
          Validators.validatePassword('PASSWORD1!',
              checkUpperCase: true,
              checkLowerCase: true,
              checkSpecialCharacter: true,
              checkLength: true,
              checkNumberAndLetter: true),
          'Password must contain at least one lowercase letter');
    });

    test('Invalid password - missing uppercase letter', () {
      expect(
          Validators.validatePassword('password1!',
              checkUpperCase: true,
              checkLowerCase: true,
              checkSpecialCharacter: true,
              checkLength: true,
              checkNumberAndLetter: true),
          'Password must contain at least one uppercase letter');
    });

    test('Invalid password - missing number', () {
      expect(
          Validators.validatePassword('Password!',
              checkUpperCase: true,
              checkLowerCase: true,
              checkSpecialCharacter: true,
              checkLength: true,
              checkNumberAndLetter: true),
          'Password must contain both letters and numbers');
    });

    test('Invalid password - contains spaces', () {
      expect(
          Validators.validatePassword('Password1 !',
              checkUpperCase: true,
              checkLowerCase: true,
              checkSpecialCharacter: true,
              checkLength: true,
              checkNumberAndLetter: true),
          'Password must not contain spaces');
    });

    test('Invalid password - empty string', () {
      expect(
          Validators.validatePassword('',
              checkUpperCase: true,
              checkLowerCase: true,
              checkSpecialCharacter: true,
              checkLength: true,
              checkNumberAndLetter: true),
          'Password is required');
    });
  });
}
