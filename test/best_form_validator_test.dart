import 'package:best_form_validator/best_form_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  // =========================================================================
  // EMAIL
  // =========================================================================
  group('Validators.validateEmail', () {
    test('null value returns required error', () {
      expect(Validators.validateEmail(null), 'Email is required');
    });

    test('empty string returns required error', () {
      expect(Validators.validateEmail(''), 'Email is required');
    });

    test('missing @ returns invalid error', () {
      expect(Validators.validateEmail('invalidemail'), 'Enter a valid email');
    });

    test('missing domain returns invalid error', () {
      expect(Validators.validateEmail('user@'), 'Enter a valid email');
    });

    test('missing TLD returns invalid error', () {
      expect(Validators.validateEmail('user@domain'), 'Enter a valid email');
    });

    test('valid simple email returns null', () {
      expect(Validators.validateEmail('user@example.com'), isNull);
    });

    test('valid email with subdomain returns null', () {
      expect(Validators.validateEmail('user@mail.example.co.uk'), isNull);
    });

    test('valid email with plus tag returns null', () {
      expect(Validators.validateEmail('user+tag@example.org'), isNull);
    });

    test('custom requiredError is returned when empty', () {
      expect(
        Validators.validateEmail('', requiredError: 'My error'),
        'My error',
      );
    });

    test('custom invalidError is returned on bad format', () {
      expect(
        Validators.validateEmail('bad', invalidError: 'Custom invalid'),
        'Custom invalid',
      );
    });
  });

  // =========================================================================
  // PHONE — international format
  // =========================================================================
  group('Validators.validatePhone — international format', () {
    test('null value returns required error', () {
      expect(Validators.validatePhone(null, 'US'), 'Phone number is required');
    });

    test('empty string returns required error', () {
      expect(Validators.validatePhone('', 'US'), 'Phone number is required');
    });

    test('empty value with isRequired=false returns null', () {
      expect(
        Validators.validatePhone('', 'US', isRequired: false),
        isNull,
      );
    });

    test('valid US number returns null', () {
      expect(Validators.validatePhone('+12025551234', 'US'), isNull);
    });

    test('valid PK number returns null', () {
      expect(Validators.validatePhone('+923001234567', 'PK'), isNull);
    });

    test('valid UK number with GB code returns null', () {
      expect(Validators.validatePhone('+447911123456', 'GB'), isNull);
    });

    test('valid UK number with UK code returns null', () {
      expect(Validators.validatePhone('+447911123456', 'UK'), isNull);
    });

    test('invalid short number returns error', () {
      expect(Validators.validatePhone('123', 'US'), isNotNull);
    });

    test('unsupported country code returns error', () {
      expect(Validators.validatePhone('+999000000000', 'XX'), isNotNull);
    });

    test('lowercase iso code is normalized', () {
      // Should not throw; treats 'us' same as 'US'
      final result = Validators.validatePhone('+12025551234', 'us');
      expect(result, isNull);
    });
  });

  // =========================================================================
  // PHONE — local format auto-normalization
  // =========================================================================
  group('Validators.validatePhone — local format normalization', () {
    test('PK local number 03001234567 is accepted', () {
      expect(Validators.validatePhone('03001234567', 'PK'), isNull);
    });

    test('GB local number 07911123456 is accepted', () {
      expect(Validators.validatePhone('07911123456', 'GB'), isNull);
    });

    test('UK local number 07911123456 is accepted via UK alias', () {
      expect(Validators.validatePhone('07911123456', 'UK'), isNull);
    });

    test('DE local number 01511234567 is accepted', () {
      expect(Validators.validatePhone('01511234567', 'DE'), isNull);
    });

    test('AU local number 0412345678 is accepted', () {
      expect(Validators.validatePhone('0412345678', 'AU'), isNull);
    });

    test('IN local number 09876543210 is accepted', () {
      expect(Validators.validatePhone('09876543210', 'IN'), isNull);
    });
  });

  // =========================================================================
  // PHONE — normalizePhone helper
  // =========================================================================
  group('Validators.normalizePhone', () {
    test('converts PK local to international', () {
      expect(
        Validators.normalizePhone('03001234567', 'PK'),
        '+923001234567',
      );
    });

    test('leaves already-international number unchanged', () {
      expect(
        Validators.normalizePhone('+923001234567', 'PK'),
        '+923001234567',
      );
    });

    test('converts GB local to international', () {
      expect(
        Validators.normalizePhone('07911123456', 'GB'),
        '+447911123456',
      );
    });

    test('UK alias behaves same as GB for normalization', () {
      expect(
        Validators.normalizePhone('07911123456', 'UK'),
        '+447911123456',
      );
    });
  });

  // =========================================================================
  // PASSWORD
  // =========================================================================
  group('Validators.validatePassword', () {
    test('null returns required error', () {
      expect(Validators.validatePassword(null), 'Password is required');
    });

    test('empty string returns required error', () {
      expect(Validators.validatePassword(''), 'Password is required');
    });

    test('too short returns length error', () {
      expect(
        Validators.validatePassword('Ab1!', checkLength: true, minLength: 6),
        'Password must be at least 6 characters long',
      );
    });

    test('meets length returns null', () {
      expect(
        Validators.validatePassword('abcdef', checkLength: true, minLength: 6),
        isNull,
      );
    });

    test('missing number returns number+letter error', () {
      expect(
        Validators.validatePassword('Password!',
            checkNumberAndLetter: true,
            checkLength: false,
            checkUpperCase: false,
            checkLowerCase: false,
            checkSpecialCharacter: false),
        'Password must contain both letters and numbers',
      );
    });

    test('missing special char returns special char error', () {
      expect(
        Validators.validatePassword('Password1',
            checkSpecialCharacter: true,
            checkLength: false,
            checkUpperCase: false,
            checkLowerCase: false,
            checkNumberAndLetter: false),
        'Password must contain at least one special character',
      );
    });

    test('missing lowercase returns lowercase error', () {
      expect(
        Validators.validatePassword('PASSWORD1!',
            checkLowerCase: true,
            checkLength: false,
            checkUpperCase: false,
            checkNumberAndLetter: false,
            checkSpecialCharacter: false),
        'Password must contain at least one lowercase letter',
      );
    });

    test('missing uppercase returns uppercase error', () {
      expect(
        Validators.validatePassword('password1!',
            checkUpperCase: true,
            checkLength: false,
            checkLowerCase: false,
            checkNumberAndLetter: false,
            checkSpecialCharacter: false),
        'Password must contain at least one uppercase letter',
      );
    });

    test('contains space returns no-spaces error', () {
      expect(
        Validators.validatePassword('Password1 !',
            checkUpperCase: true,
            checkLowerCase: true,
            checkSpecialCharacter: true,
            checkLength: true,
            checkNumberAndLetter: true),
        'Password must not contain spaces',
      );
    });

    test('fully valid password returns null', () {
      expect(
        Validators.validatePassword(
          'MyP@ssw0rd',
          checkLength: true,
          minLength: 8,
          checkNumberAndLetter: true,
          checkSpecialCharacter: true,
          checkLowerCase: true,
          checkUpperCase: true,
        ),
        isNull,
      );
    });
  });

  // =========================================================================
  // PASSWORD STRENGTH
  // =========================================================================
  group('PasswordValidator.getPasswordStrength', () {
    test('null returns 0', () {
      expect(PasswordValidator.getPasswordStrength(null), 0);
    });

    test('empty returns 0', () {
      expect(PasswordValidator.getPasswordStrength(''), 0);
    });

    test('short lowercase only scores 1', () {
      expect(PasswordValidator.getPasswordStrength('abc'), 1);
    });

    test('8 chars lower+upper scores 3', () {
      expect(PasswordValidator.getPasswordStrength('Abcdefgh'), 3);
    });

    test('strong password scores 5', () {
      expect(PasswordValidator.getPasswordStrength('MyP@ssw0rd'), 5);
    });

    test('score never exceeds 5', () {
      expect(
        PasswordValidator.getPasswordStrength('MyP@ssw0rd!!!'),
        lessThanOrEqualTo(5),
      );
    });
  });

  // =========================================================================
  // NAME — Latin
  // =========================================================================
  group('Validators.validateName — Latin', () {
    test('null returns required error', () {
      expect(Validators.validateName(null), 'Name is required');
    });

    test('empty returns required error', () {
      expect(Validators.validateName(''), 'Name is required');
    });

    test('whitespace only returns required error', () {
      expect(Validators.validateName('   '), 'Name is required');
    });

    test('valid single name returns null', () {
      expect(Validators.validateName('John'), isNull);
    });

    test('valid full name with space returns null', () {
      expect(Validators.validateName('John Doe'), isNull);
    });

    test('accented chars accepted', () {
      expect(Validators.validateName('José García'), isNull);
    });

    test('hyphenated name accepted', () {
      expect(Validators.validateName('Mary-Jane'), isNull);
    });

    test("apostrophe name accepted", () {
      expect(Validators.validateName("O'Brien"), isNull);
    });

    test('digits in name returns invalid error', () {
      expect(Validators.validateName('John123'), isNotNull);
    });

    test('leading space returns invalid error', () {
      expect(Validators.validateName(' John'), isNotNull);
    });

    test('trailing space returns invalid error', () {
      expect(Validators.validateName('John '), isNotNull);
    });

    test('double space returns invalid error', () {
      expect(Validators.validateName('John  Doe'), isNotNull);
    });
  });

  // =========================================================================
  // NAME — Unicode / international scripts
  // =========================================================================
  group('Validators.validateName — Unicode scripts', () {
    test('Arabic name accepted', () {
      expect(Validators.validateName('محمد علي'), isNull);
    });

    test('Urdu name accepted', () {
      expect(Validators.validateName('فاطمہ'), isNull);
    });

    test('Hindi (Devanagari) name accepted', () {
      expect(Validators.validateName('राज कुमार'), isNull);
    });

    test('Chinese name accepted', () {
      expect(Validators.validateName('王芳'), isNull);
    });

    test('Japanese name accepted', () {
      expect(Validators.validateName('たなか'), isNull);
    });

    test('Korean name accepted', () {
      expect(Validators.validateName('김민준'), isNull);
    });
  });

  // =========================================================================
  // AGE
  // =========================================================================
  group('Validators.validateAge', () {
    test('null value returns invalid date error', () {
      expect(Validators.validateAge(null, 18), isNotNull);
    });

    test('invalid string format returns invalid date error', () {
      expect(Validators.validateAge('not-a-date', 18), isNotNull);
    });

    test('person exactly 18 today returns null', () {
      final today = DateTime.now();
      final birthDate =
          DateTime(today.year - 18, today.month, today.day);
      final str =
          '${birthDate.year}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}';
      expect(Validators.validateAge(str, 18), isNull);
    });

    test('person 17 years old returns error', () {
      final today = DateTime.now();
      final birthDate =
          DateTime(today.year - 17, today.month, today.day);
      expect(Validators.validateAge(birthDate, 18), isNotNull);
    });

    test('person clearly over 18 (year 2000) returns null', () {
      expect(Validators.validateAge('2000-01-15', 18), isNull);
    });

    test('DateTime object accepted', () {
      expect(Validators.validateAge(DateTime(2000, 1, 15), 18), isNull);
    });

    test('custom invalidError is returned', () {
      expect(
        Validators.validateAge(
          DateTime(2020, 1, 1),
          18,
          invalidError: 'Too young',
        ),
        'Too young',
      );
    });
  });

  // =========================================================================
  // DATE
  // =========================================================================
  group('Validators.validateDate', () {
    test('null returns required error', () {
      expect(Validators.validateDate(null), 'Date is required');
    });

    test('empty returns required error', () {
      expect(Validators.validateDate(''), 'Date is required');
    });

    test('invalid string returns invalid date error', () {
      expect(Validators.validateDate('not-a-date'), isNotNull);
    });

    test('valid ISO date returns null', () {
      expect(Validators.validateDate('2024-01-15'), isNull);
    });

    test('valid datetime string returns null', () {
      expect(Validators.validateDate('2024-01-15T10:30:00'), isNull);
    });

    test('custom requiredError is returned when empty', () {
      expect(
        Validators.validateDate('', requiredError: 'Pick a date'),
        'Pick a date',
      );
    });
  });

  // =========================================================================
  // TIME — strict regex (bug fix verification)
  // =========================================================================
  group('Validators.validateTime', () {
    test('null returns required error', () {
      expect(Validators.validateTime(null), 'Time is required');
    });

    test('empty returns required error', () {
      expect(Validators.validateTime(''), 'Time is required');
    });

    test('valid HH:mm returns null', () {
      expect(Validators.validateTime('14:30'), isNull);
    });

    test('valid HH:mm:ss returns null', () {
      expect(Validators.validateTime('14:30:00'), isNull);
    });

    test('midnight 00:00:00 returns null', () {
      expect(Validators.validateTime('00:00:00'), isNull);
    });

    test('end of day 23:59:59 returns null', () {
      expect(Validators.validateTime('23:59:59'), isNull);
    });

    test('hour 25 returns error (bug fix)', () {
      expect(Validators.validateTime('25:00:00'), isNotNull);
    });

    test('minute 99 returns error (bug fix)', () {
      expect(Validators.validateTime('12:99:00'), isNotNull);
    });

    test('second 99 returns error (bug fix)', () {
      expect(Validators.validateTime('12:00:99'), isNotNull);
    });

    test('25:99:99 returns error (original bug scenario)', () {
      expect(Validators.validateTime('25:99:99'), isNotNull);
    });

    test('gibberish returns error', () {
      expect(Validators.validateTime('abc'), isNotNull);
    });

    test('custom invalidError returned on bad format', () {
      expect(
        Validators.validateTime('25:00', invalidError: 'Bad time'),
        'Bad time',
      );
    });
  });

  // =========================================================================
  // FINANCIAL — Credit Card
  // =========================================================================
  group('FinancialValidators.validateCreditCard', () {
    test('null returns required error', () {
      expect(
        FinancialValidators.validateCreditCard(null),
        'Credit card number is required',
      );
    });

    test('empty returns required error', () {
      expect(
        FinancialValidators.validateCreditCard(''),
        'Credit card number is required',
      );
    });

    test('valid Visa test number with spaces returns null', () {
      expect(
        FinancialValidators.validateCreditCard('4111 1111 1111 1111'),
        isNull,
      );
    });

    test('valid Visa test number without spaces returns null', () {
      expect(
        FinancialValidators.validateCreditCard('4111111111111111'),
        isNull,
      );
    });

    test('valid Mastercard test number returns null', () {
      expect(
        FinancialValidators.validateCreditCard('5500005555555559'),
        isNull,
      );
    });

    test('invalid number fails Luhn check', () {
      expect(
        FinancialValidators.validateCreditCard('1234567890123456'),
        'Invalid credit card number',
      );
    });

    test('non-numeric input returns invalid error', () {
      expect(
        FinancialValidators.validateCreditCard('abcd-efgh-ijkl-mnop'),
        isNotNull,
      );
    });

    test('Validators.validateCreditCard facade works', () {
      expect(
        Validators.validateCreditCard('4111 1111 1111 1111'),
        isNull,
      );
    });
  });

  // =========================================================================
  // FINANCIAL — IBAN
  // =========================================================================
  group('FinancialValidators.validateIBAN', () {
    test('null returns required error', () {
      expect(
        FinancialValidators.validateIBAN(null),
        'IBAN is required',
      );
    });

    test('empty returns required error', () {
      expect(
        FinancialValidators.validateIBAN(''),
        'IBAN is required',
      );
    });

    test('valid GB IBAN returns null', () {
      expect(
        FinancialValidators.validateIBAN('GB82WEST12345698765432'),
        isNull,
      );
    });

    test('valid GB IBAN with spaces returns null', () {
      expect(
        FinancialValidators.validateIBAN('GB82 WEST 1234 5698 7654 32'),
        isNull,
      );
    });

    test('valid DE IBAN returns null', () {
      expect(
        FinancialValidators.validateIBAN('DE89370400440532013000'),
        isNull,
      );
    });

    test('invalid IBAN returns error', () {
      expect(
        FinancialValidators.validateIBAN('INVALID'),
        'Invalid IBAN number',
      );
    });

    test('wrong checksum returns error', () {
      expect(
        FinancialValidators.validateIBAN('GB00WEST12345698765432'),
        isNotNull,
      );
    });

    test('lowercase IBAN is accepted (auto uppercased)', () {
      expect(
        FinancialValidators.validateIBAN('gb82west12345698765432'),
        isNull,
      );
    });

    test('Validators.validateIBAN facade works', () {
      expect(
        Validators.validateIBAN('GB82 WEST 1234 5698 7654 32'),
        isNull,
      );
    });
  });

  // =========================================================================
  // MULTI VALIDATOR
  // =========================================================================
  group('MultiValidator', () {
    test('returns null when all validators pass', () {
      final v = MultiValidator([
        (val) => Validators.validateEmail(val),
      ]);
      expect(v('user@example.com'), isNull);
    });

    test('returns first error when first validator fails', () {
      final v = MultiValidator([
        (val) => val == null || val.isEmpty ? 'Required' : null,
        (val) => Validators.validateEmail(val),
      ]);
      expect(v(''), 'Required');
    });

    test('returns second error when first passes but second fails', () {
      final v = MultiValidator([
        (val) => null, // always passes
        (val) => 'Second error',
      ]);
      expect(v('anything'), 'Second error');
    });

    test('chaining email + min length works', () {
      final v = MultiValidator([
        (val) => Validators.validateEmail(val),
        (val) =>
            val != null && val.length < 20 ? 'Email too short' : null,
      ]);
      // Valid email but length check fails
      expect(v('a@b.co'), 'Email too short');
    });

    test('can be used as TextFormField validator signature', () {
      String? Function(String?) validator = MultiValidator([
        (val) => Validators.validateName(val),
      ]);
      expect(validator('John'), isNull);
      expect(validator(''), isNotNull);
    });
  });

  // =========================================================================
  // PHONE INPUT FORMATTER
  // =========================================================================
  group('PhoneInputFormatter', () {
    final formatter = PhoneInputFormatter();

    TextEditingValue format(String text) => formatter.formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: text),
        );

    test('empty string returns empty', () {
      expect(format('').text, '');
    });

    test('strips non-digit non-plus characters', () {
      // Dashes and spaces are stripped, then re-grouped
      final result = format('+1-202-555-1234');
      expect(result.text, contains('+'));
    });

    test('preserves leading plus', () {
      final result = format('+12025551234');
      expect(result.text.startsWith('+'), isTrue);
    });

    test('adds spaces at digit group boundaries', () {
      final result = format('+12025551234');
      expect(result.text.contains(' '), isTrue);
    });

    test('cursor is placed at end', () {
      final result = format('+12025551234');
      expect(result.selection.baseOffset, result.text.length);
    });
  });

  // =========================================================================
  // LOCALIZATION
  // =========================================================================
  group('FormLocalizations', () {
    test('English locale returns English strings', () {
      final loc = FormLocalizations.getByLocale(const Locale('en'));
      expect(loc.emailRequired, 'Email is required');
      expect(loc.phoneRequired, 'Phone number is required');
      expect(loc.creditCardRequired, 'Credit card number is required');
      expect(loc.ibanRequired, 'IBAN is required');
    });

    test('Spanish locale returns Spanish strings', () {
      final loc = FormLocalizations.getByLocale(const Locale('es'));
      expect(loc.emailRequired, isNot('Email is required'));
      expect(loc.emailRequired, isNotEmpty);
    });

    test('Arabic locale returns Arabic strings', () {
      final loc = FormLocalizations.getByLocale(const Locale('ar'));
      expect(loc.emailRequired, 'البريد الإلكتروني مطلوب');
    });

    test('financial strings localized in Arabic', () {
      final loc = FormLocalizations.getByLocale(const Locale('ar'));
      expect(loc.creditCardRequired, isNotEmpty);
      expect(loc.invalidCreditCard, isNotEmpty);
      expect(loc.ibanRequired, isNotEmpty);
      expect(loc.invalidIban, isNotEmpty);
    });

    test('financial strings localized in all 25 languages', () {
      const langs = [
        'en', 'es', 'fr', 'de', 'ar', 'ur', 'hi', 'zh', 'pt', 'ru',
        'it', 'tr', 'ja', 'ko', 'id', 'ms', 'th', 'vi', 'nl', 'sv',
        'no', 'fi', 'da', 'el', 'fa',
      ];
      for (final lang in langs) {
        final loc = FormLocalizations.getByLocale(Locale(lang));
        expect(loc.creditCardRequired, isNotEmpty,
            reason: '$lang creditCardRequired is empty');
        expect(loc.invalidCreditCard, isNotEmpty,
            reason: '$lang invalidCreditCard is empty');
        expect(loc.ibanRequired, isNotEmpty,
            reason: '$lang ibanRequired is empty');
        expect(loc.invalidIban, isNotEmpty,
            reason: '$lang invalidIban is empty');
      }
    });

    test('unknown locale falls back to English', () {
      final loc =
          FormLocalizations.getByLocale(const Locale('xx'));
      expect(loc.emailRequired, 'Email is required');
    });

    test('setLocale changes global instance', () {
      Validators.setLocale(const Locale('es'));
      final global = FormLocalizations.global;
      expect(global.emailRequired, isNot('Email is required'));
      // Reset to English for subsequent tests
      Validators.setLocale(const Locale('en'));
    });

    test('ageMin interpolates age', () {
      final loc = FormLocalizations.getByLocale(const Locale('en'));
      expect(loc.ageMin(18), 'Age must be at least 18 years old');
    });

    test('passwordMinLength interpolates length', () {
      final loc = FormLocalizations.getByLocale(const Locale('en'));
      expect(loc.passwordMinLength(8),
          'Password must be at least 8 characters long');
    });

    test('invalidPhone interpolates country code', () {
      final loc = FormLocalizations.getByLocale(const Locale('en'));
      expect(
          loc.invalidPhone('US'), 'Enter a valid phone number for US');
    });
  });
}
