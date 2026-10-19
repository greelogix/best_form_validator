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
  // URL
  // =========================================================================
  group('Validators.validateUrl', () {
    test('null value returns required error', () {
      expect(Validators.validateUrl(null), 'URL is required');
    });

    test('empty string returns required error', () {
      expect(Validators.validateUrl(''), 'URL is required');
    });

    test('whitespace-only returns required error', () {
      expect(Validators.validateUrl('   '), 'URL is required');
    });

    test('empty value with isRequired=false returns null', () {
      expect(Validators.validateUrl('', isRequired: false), isNull);
    });

    test('missing scheme returns invalid error', () {
      expect(Validators.validateUrl('example.com'), 'Enter a valid URL');
    });

    test('invalid scheme returns invalid error', () {
      expect(Validators.validateUrl('ftp://example.com'), 'Enter a valid URL');
    });

    test('javascript scheme returns invalid error', () {
      expect(
        Validators.validateUrl('javascript:alert(1)'),
        'Enter a valid URL',
      );
    });

    test('host without TLD returns invalid error', () {
      expect(Validators.validateUrl('https://example'), 'Enter a valid URL');
    });

    test('valid https URL returns null', () {
      expect(Validators.validateUrl('https://example.com'), isNull);
    });

    test('valid http URL returns null', () {
      expect(Validators.validateUrl('http://example.com'), isNull);
    });

    test('valid URL with path and query returns null', () {
      expect(
        Validators.validateUrl('https://www.example.com/path?q=1'),
        isNull,
      );
    });

    test('valid URL with port returns null', () {
      expect(Validators.validateUrl('http://localhost:8080'), isNull);
    });

    test('valid IPv4 URL returns null', () {
      expect(Validators.validateUrl('https://192.168.1.1'), isNull);
    });

    test('allowMissingScheme accepts bare domain', () {
      expect(
        Validators.validateUrl('example.com', allowMissingScheme: true),
        isNull,
      );
    });

    test('trims surrounding whitespace', () {
      expect(Validators.validateUrl('  https://example.com  '), isNull);
    });

    test('custom requiredError is returned when empty', () {
      expect(
        Validators.validateUrl('', requiredError: 'My error'),
        'My error',
      );
    });

    test('custom invalidError is returned on bad format', () {
      expect(
        Validators.validateUrl('not-a-url', invalidError: 'Custom invalid'),
        'Custom invalid',
      );
    });
  });

  group('UrlValidator.validate', () {
    test('delegates to same behavior as Validators.validateUrl', () {
      expect(UrlValidator.validate('https://example.com'), isNull);
      expect(UrlValidator.validate('bad'), 'Enter a valid URL');
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

    test('Cyrillic name accepted', () {
      expect(Validators.validateName('Иван Петров'), isNull);
    });

    test('Greek name accepted', () {
      expect(Validators.validateName('Γεώργιος Παπαδόπουλος'), isNull);
    });

    test('Thai name accepted', () {
      expect(Validators.validateName('สมชาย ใจดี'), isNull);
    });

    test('decomposed accented name accepted', () {
      expect(Validators.validateName('Jose\u0301 Garcia'), isNull);
    });
  });

  // =========================================================================
  // AGE
  // =========================================================================
  group('Validators.validateAge', () {
    test('null value returns required date error', () {
      expect(Validators.validateAge(null, 18), 'Date is required');
    });

    test('empty value returns required date error', () {
      expect(Validators.validateAge('', 18), 'Date is required');
    });

    test('whitespace value returns custom required error', () {
      expect(
        Validators.validateAge('   ', 18, requiredError: 'Birth date needed'),
        'Birth date needed',
      );
    });

    test('invalid string format returns invalid date error', () {
      expect(Validators.validateAge('not-a-date', 18), isNotNull);
    });

    test('person exactly 18 today returns null', () {
      final today = DateTime.now();
      final birthDate = DateTime(today.year - 18, today.month, today.day);
      final str =
          '${birthDate.year}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}';
      expect(Validators.validateAge(str, 18), isNull);
    });

    test('person 17 years old returns error', () {
      final today = DateTime.now();
      final birthDate = DateTime(today.year - 17, today.month, today.day);
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

    test('negative minimum age is rejected as a configuration error', () {
      expect(
        () => Validators.validateAge('2000-01-01', -1),
        throwsArgumentError,
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

    test('datetime string with time component is rejected (strict yyyy-MM-dd)',
        () {
      // strict parsing only accepts yyyy-MM-dd, not datetime strings
      expect(Validators.validateDate('2024-01-15T10:30:00'), isNotNull);
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
        (val) => val != null && val.length < 20 ? 'Email too short' : null,
      ]);
      // Valid email but length check fails
      expect(v('a@b.co'), 'Email too short');
    });

    test('can be used as TextFormField validator signature', () {
      final mv = MultiValidator([
        (val) => Validators.validateName(val),
      ]);
      String? Function(String?) validator = mv.call;
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
      expect(loc.urlRequired, 'URL is required');
      expect(loc.invalidUrl, 'Enter a valid URL');
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
        'en',
        'es',
        'fr',
        'de',
        'ar',
        'ur',
        'hi',
        'zh',
        'pt',
        'ru',
        'it',
        'tr',
        'ja',
        'ko',
        'id',
        'ms',
        'th',
        'vi',
        'nl',
        'sv',
        'no',
        'fi',
        'da',
        'el',
        'fa',
      ];
      for (final lang in langs) {
        final loc = FormLocalizations.getByLocale(Locale(lang));
        expect(loc.urlRequired, isNotEmpty,
            reason: '$lang urlRequired is empty');
        expect(loc.invalidUrl, isNotEmpty, reason: '$lang invalidUrl is empty');
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
      final loc = FormLocalizations.getByLocale(const Locale('xx'));
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
      expect(loc.invalidPhone('US'), 'Enter a valid phone number for US');
    });
  });

  // =========================================================================
  // EDGE CASES — validateTime boundary values
  // =========================================================================
  group('validateTime — boundary edge cases', () {
    test('24:00 is rejected (hour out of range)', () {
      expect(Validators.validateTime('24:00'), isNotNull);
    });

    test('24:00:00 is rejected', () {
      expect(Validators.validateTime('24:00:00'), isNotNull);
    });

    test('1:30 without leading zero is rejected', () {
      // Regex requires exactly 2 digits for hours
      expect(Validators.validateTime('1:30'), isNotNull);
    });

    test('00:60 is rejected (minute out of range)', () {
      expect(Validators.validateTime('00:60'), isNotNull);
    });

    test('00:00:60 is rejected (second out of range)', () {
      expect(Validators.validateTime('00:00:60'), isNotNull);
    });

    test('23:59 (HH:mm boundary) returns null', () {
      expect(Validators.validateTime('23:59'), isNull);
    });

    test('trailing whitespace rejected', () {
      expect(Validators.validateTime('14:30 '), isNotNull);
    });
  });

  // =========================================================================
  // EDGE CASES — validateName rejection cases
  // =========================================================================
  group('validateName — rejection edge cases', () {
    test('emoji is rejected', () {
      expect(Validators.validateName('John😀'), isNotNull);
    });

    test('pure punctuation is rejected', () {
      expect(Validators.validateName('---'), isNotNull);
    });

    test('name starting with hyphen is rejected', () {
      expect(Validators.validateName('-Jane'), isNotNull);
    });

    test('name ending with hyphen is rejected', () {
      expect(Validators.validateName('Jane-'), isNotNull);
    });

    test('name starting with apostrophe is rejected', () {
      expect(Validators.validateName("'Brien"), isNotNull);
    });

    test('tab character is rejected', () {
      expect(Validators.validateName('John\tDoe'), isNotNull);
    });

    test('number symbol is rejected', () {
      expect(Validators.validateName('John#Doe'), isNotNull);
    });

    test('three-part hyphenated name accepted', () {
      expect(Validators.validateName('Anne-Marie Doe'), isNull);
    });

    test('mixed script names accepted (Arabic + Latin)', () {
      // Each token is validated independently; mixed tokens within one word
      // are not common but multi-word mixed script should work
      expect(Validators.validateName('محمد Ali'), isNull);
    });
  });

  // =========================================================================
  // EDGE CASES — validatePhone input normalization
  // =========================================================================
  group('validatePhone — input with spaces and dashes', () {
    test('PK number with spaces is normalized and accepted', () {
      // e.g. user typed "0300 123 4567"
      expect(Validators.validatePhone('0300 123 4567', 'PK'), isNull);
    });

    test('PK number with dashes is normalized and accepted', () {
      expect(Validators.validatePhone('0300-123-4567', 'PK'), isNull);
    });

    test('international number with spaces accepted', () {
      expect(Validators.validatePhone('+92 300 1234567', 'PK'), isNull);
    });

    test('CA and US share +1 prefix — CA valid', () {
      expect(Validators.validatePhone('+16135551234', 'CA'), isNull);
    });

    test('formatted US number is normalized and accepted', () {
      expect(Validators.validatePhone('+1 (202) 555-1234', 'US'), isNull);
    });

    test('US local number is normalized and accepted', () {
      expect(Validators.validatePhone('2025551234', 'US'), isNull);
    });

    test('US country code without plus is normalized and accepted', () {
      expect(Validators.validatePhone('12025551234', 'US'), isNull);
    });

    test('Italian geographic leading zero is retained', () {
      expect(Validators.normalizePhone('0212345678', 'IT'), '+390212345678');
      expect(Validators.validatePhone('0212345678', 'IT'), isNull);
    });

    test('PhoneInputFormatter output validates for US', () {
      final formatter = PhoneInputFormatter();
      final formatted = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '+12025551234'),
      );
      expect(Validators.validatePhone(formatted.text, 'US'), isNull);
    });

    test('valid number with junk prefix is rejected', () {
      expect(Validators.validatePhone('junk+12025551234', 'US'), isNotNull);
    });

    test('valid number with junk suffix is rejected', () {
      expect(Validators.validatePhone('+12025551234junk', 'US'), isNotNull);
    });
  });

  // =========================================================================
  // EDGE CASES — normalizePhone
  // =========================================================================
  group('normalizePhone — spaces and dashes stripped', () {
    test('spaces stripped before normalization', () {
      expect(
        Validators.normalizePhone('0300 123 4567', 'PK'),
        '+923001234567',
      );
    });

    test('dashes stripped before normalization', () {
      expect(
        Validators.normalizePhone('0300-123-4567', 'PK'),
        '+923001234567',
      );
    });

    test('unknown ISO returns value unchanged', () {
      expect(Validators.normalizePhone('12345', 'XX'), '12345');
    });

    test('US local number is normalized to international format', () {
      final result = Validators.normalizePhone('2025551234', 'US');
      expect(result, '+12025551234');
    });

    test('US spaces and punctuation are stripped', () {
      expect(
        Validators.normalizePhone('+1 (202) 555-1234', 'US'),
        '+12025551234',
      );
    });
  });

  // =========================================================================
  // EDGE CASES — validateDate
  // =========================================================================
  group('validateDate — edge cases', () {
    test('invalid day 32 returns error', () {
      expect(Validators.validateDate('2024-01-32'), isNotNull);
    });

    test('invalid month 13 returns error', () {
      expect(Validators.validateDate('2024-13-01'), isNotNull);
    });

    test('completely wrong format returns error', () {
      expect(Validators.validateDate('15/01/2024'), isNotNull);
    });

    test('leap year Feb 29 on leap year returns null', () {
      expect(Validators.validateDate('2024-02-29'), isNull);
    });

    test('Feb 29 on non-leap year returns error', () {
      expect(Validators.validateDate('2023-02-29'), isNotNull);
    });
  });

  // =========================================================================
  // EDGE CASES — validateAge
  // =========================================================================
  group('validateAge — edge cases', () {
    test('future birth date returns error', () {
      final future = DateTime.now().add(const Duration(days: 365));
      expect(Validators.validateAge(future, 18), isNotNull);
    });

    test('minimumAge of 0 always passes for valid date', () {
      expect(Validators.validateAge('2000-01-01', 0), isNull);
    });

    test('future birth date fails even when minimumAge is 0', () {
      final future = DateTime.now().add(const Duration(days: 365));
      expect(Validators.validateAge(future, 0), isNotNull);
    });

    test('birthday tomorrow (not yet 18) returns error', () {
      final today = DateTime.now();
      final tomorrow = DateTime(today.year - 18, today.month, today.day + 1);
      expect(Validators.validateAge(tomorrow, 18), isNotNull);
    });
  });

  // =========================================================================
  // EDGE CASES — Credit Card
  // =========================================================================
  group('FinancialValidators.validateCreditCard — edge cases', () {
    test('American Express test number returns null', () {
      // Amex test number: 378282246310005
      expect(
        FinancialValidators.validateCreditCard('378282246310005'),
        isNull,
      );
    });

    test('number with dashes stripped and validated', () {
      expect(
        FinancialValidators.validateCreditCard('4111-1111-1111-1111'),
        isNull,
      );
    });

    test('single digit returns invalid error', () {
      expect(FinancialValidators.validateCreditCard('4'), isNotNull);
    });

    test('single zero is rejected even though it passes Luhn modulo', () {
      expect(FinancialValidators.validateCreditCard('0'), isNotNull);
    });

    test('all-zero card number is rejected', () {
      expect(
        FinancialValidators.validateCreditCard('0000000000000000'),
        isNotNull,
      );
    });

    test('card number shorter than 12 digits is rejected', () {
      expect(FinancialValidators.validateCreditCard('79927398713'), isNotNull);
    });

    test('whitespace-only card value returns required error', () {
      expect(
        FinancialValidators.validateCreditCard('   '),
        'Credit card number is required',
      );
    });

    test('custom requiredError returned', () {
      expect(
        FinancialValidators.validateCreditCard('', requiredError: 'Enter card'),
        'Enter card',
      );
    });

    test('custom invalidError returned', () {
      expect(
        FinancialValidators.validateCreditCard('1234567890123456',
            invalidError: 'Bad card'),
        'Bad card',
      );
    });
  });

  // =========================================================================
  // EDGE CASES — IBAN
  // =========================================================================
  group('FinancialValidators.validateIBAN — edge cases', () {
    test('IBAN longer than 34 chars is rejected', () {
      expect(
        FinancialValidators.validateIBAN(
            'GB82WEST1234569876543212345678901234567'),
        isNotNull,
      );
    });

    test('valid FR IBAN returns null', () {
      // FR76 3000 6000 0112 3456 7890 189
      expect(
        FinancialValidators.validateIBAN('FR7630006000011234567890189'),
        isNull,
      );
    });

    test('only 2 chars (too short) returns invalid', () {
      expect(FinancialValidators.validateIBAN('GB'), isNotNull);
    });

    test('unsupported country code is rejected', () {
      expect(FinancialValidators.validateIBAN('ZZ59TEST12345678901234'),
          isNotNull);
    });

    test('valid country with incorrect national length is rejected', () {
      expect(
        FinancialValidators.validateIBAN('GB82WEST123456987654320'),
        isNotNull,
      );
    });

    test('whitespace-only IBAN returns required error', () {
      expect(FinancialValidators.validateIBAN('   '), 'IBAN is required');
    });

    test('custom requiredError returned', () {
      expect(
        FinancialValidators.validateIBAN('', requiredError: 'Enter IBAN'),
        'Enter IBAN',
      );
    });
  });

  // =========================================================================
  // EDGE CASES — Password
  // =========================================================================
  group('validatePassword — edge cases', () {
    test('space-only password returns required error', () {
      // Trimmed empty → required
      expect(Validators.validatePassword(' '), isNotNull);
    });

    test('minLength 0 always passes length check', () {
      expect(
        Validators.validatePassword('a', checkLength: true, minLength: 0),
        isNull,
      );
    });

    test('checkLength false ignores length', () {
      expect(
        Validators.validatePassword('ab', checkLength: false),
        isNull,
      );
    });

    test('password with only spaces fails no-spaces check', () {
      expect(
        Validators.validatePassword('        ', checkLength: false),
        isNotNull,
      );
    });
  });

  // =========================================================================
  // PUBLIC API — verify no src/ imports needed
  // =========================================================================
  group('Public API — all classes accessible from barrel import', () {
    test('Validators is accessible', () {
      expect(Validators, isNotNull);
    });

    test('PasswordValidator is accessible', () {
      expect(PasswordValidator, isNotNull);
    });

    test('PhoneValidator is accessible', () {
      expect(PhoneValidator, isNotNull);
    });

    test('UrlValidator is accessible', () {
      expect(UrlValidator, isNotNull);
    });

    test('NameValidator is accessible', () {
      expect(NameValidator, isNotNull);
    });

    test('AgeValidator is accessible', () {
      expect(AgeValidator, isNotNull);
    });

    test('FinancialValidators is accessible', () {
      expect(FinancialValidators, isNotNull);
    });

    test('MultiValidator is accessible', () {
      expect(MultiValidator, isNotNull);
    });

    test('PhoneInputFormatter is accessible', () {
      expect(PhoneInputFormatter, isNotNull);
    });

    test('FormLocalizations is accessible', () {
      expect(FormLocalizations, isNotNull);
    });
  });

  // =========================================================================
  // REGRESSION — old bugs must not reappear
  // =========================================================================
  group('Regression — previously broken behavior', () {
    test('[REGRESSION] validateTime 25:99:99 was accepted before fix', () {
      // Old code: DateTime.parse('1970-01-01 25:99:99') would wrap/overflow
      // New code: strict regex must reject it
      expect(Validators.validateTime('25:99:99'), isNotNull);
    });

    test('[REGRESSION] validatePhone PK local rejected before fix', () {
      // Old code had no normalization, 0300... would fail
      expect(Validators.validatePhone('03001234567', 'PK'), isNull);
    });

    test('[REGRESSION] validatePhone GB ISO rejected before fix', () {
      // Old code only had UK key, GB would return countryCodeNotSupported
      expect(Validators.validatePhone('+447911123456', 'GB'), isNull);
    });

    test('[REGRESSION] validateName rejected Arabic before fix', () {
      // Old code: ^[a-zA-Z]+$ would reject Arabic
      expect(Validators.validateName('محمد'), isNull);
    });

    test('[REGRESSION] validateName rejected Chinese before fix', () {
      expect(Validators.validateName('王芳'), isNull);
    });

    test('[REGRESSION] FinancialValidators accessible from public API', () {
      // Was hidden behind src/ import before fix
      expect(
        FinancialValidators.validateCreditCard('4111111111111111'),
        isNull,
      );
    });

    test('[REGRESSION] MultiValidator accessible from public API', () {
      final v = MultiValidator([(val) => null]);
      expect(v('test'), isNull);
    });

    test('[REGRESSION] PhoneInputFormatter accessible from public API', () {
      final f = PhoneInputFormatter();
      expect(f, isNotNull);
    });
  });
}
