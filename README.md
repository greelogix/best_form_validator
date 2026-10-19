# best_form_validator

[![pub package](https://img.shields.io/pub/v/best_form_validator.svg)](https://pub.dev/packages/best_form_validator)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/greelogix/best_form_validator/blob/main/LICENSE)
[![pub points](https://img.shields.io/pub/points/best_form_validator)](https://pub.dev/packages/best_form_validator/score)

## Demo

![Best Form Validator Demo](https://raw.githubusercontent.com/greelogix/quick_popup_manager-video/main/best_form_validator_video_demo.gif)

A high-performance, zero-initialization form validation package for Flutter and Dart.

**Instant. Context-free. No async setup.**  
Drop validators directly into `TextFormField.validator` — no `BuildContext`, no `await`, no boilerplate.

### Why `best_form_validator`?

| Feature | Standard Flutter | `best_form_validator` |
|---------|------------------|-----------------------|
| Phone regex | Write your own | Built-in 52 countries 🌍 |
| Local number formats | Manual conversion | Auto-normalized ✅ |
| Async startup | N/A | Zero-init (synchronous) 🚀 |
| Translations | Manual `if-else` | 25 languages built-in |
| Chaining validators | Nested callbacks | `MultiValidator([...])` |
| URL validation | Write your own | Built-in HTTP/HTTPS ✅ |
| Financial validation | External packages | Native Luhn / IBAN 💳 |
| Unicode names | ASCII regex only | All Unicode letter scripts ✅ |

---

## Features

- **Zero-Initialization** — synchronous, no startup code required
- **Phone Validation** — 52 countries; accepts international, commonly formatted, and supported local numbering plans with full-input matching
- **GB / UK alias** — both `'GB'` (ISO 3166-1) and `'UK'` work interchangeably
- **Email & Password** — battle-tested regex + configurable strength rules
- **URL Validation** — HTTP/HTTPS URLs with proper scheme and host checks
- **Password Strength** — `PasswordValidator.getPasswordStrength()` returns a 0–5 score
- **Unicode Names** — all Unicode letter scripts and combining marks, including Cyrillic, Greek, Thai, Arabic, CJK, and more
- **Age Validation** — handles the birthday-not-yet-occurred edge case correctly
- **Time Validation** — strict HH:mm / HH:mm:ss (rejects 25:99:99)
- **Financial Checks** — 12–19 digit credit cards with Luhn, plus country-length-aware IBAN MOD-97 validation
- **MultiValidator** — chain validators, returns the first error
- **Localization** — 25 language error messages, runtime-switchable
- **PhoneInputFormatter** — `TextInputFormatter` for auto-spacing phone numbers

---

## Installation

```yaml
dependencies:
  best_form_validator: ^1.4.2
```

```bash
flutter pub get
```

---

## Quick Start

```dart
import 'package:best_form_validator/best_form_validator.dart';

TextFormField(
  validator: (value) => Validators.validateEmail(value),
)
```

No initialization needed. Works immediately.

---

## Localization Setup

Add `FormLocalizations.delegate` to your `MaterialApp` and call `Validators.setLocale` in the `builder`:

```dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:best_form_validator/best_form_validator.dart';

MaterialApp(
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    FormLocalizations.delegate,
  ],
  supportedLocales: const [
    Locale('en'), Locale('es'), Locale('fr'), Locale('de'),
    Locale('ar'), Locale('ur'), Locale('hi'), Locale('zh'),
    Locale('pt'), Locale('ru'), Locale('it'), Locale('tr'),
    Locale('ja'), Locale('ko'), Locale('id'), Locale('ms'),
    Locale('th'), Locale('vi'), Locale('nl'), Locale('sv'),
    Locale('no'), Locale('fi'), Locale('da'), Locale('el'),
    Locale('fa'),
  ],
  builder: (context, child) {
    Validators.setLocale(Localizations.localeOf(context));
    return child!;
  },
)
```

---

## Usage

### Email

```dart
Validators.validateEmail('user@example.com');  // null (valid)
Validators.validateEmail('');                  // 'Email is required'
Validators.validateEmail('bad-email');         // 'Enter a valid email'

// Custom messages
Validators.validateEmail(
  'bad',
  requiredError: 'Please enter your email',
  invalidError: 'That email looks wrong',
);
```

### URL

```dart
Validators.validateUrl('https://example.com');   // null (valid)
Validators.validateUrl('http://localhost:8080'); // null (valid)
Validators.validateUrl('example.com');           // error (missing scheme)
Validators.validateUrl('');                      // 'URL is required'

// Accept bare domains (prepends https://)
Validators.validateUrl('example.com', allowMissingScheme: true); // null (valid)

// Optional field
Validators.validateUrl('', isRequired: false);  // null (valid)

// Custom messages
Validators.validateUrl(
  'bad',
  requiredError: 'Please enter your website',
  invalidError: 'That URL looks wrong',
);
```

### Phone — international & local formats

Both `+923001234567` and `03001234567` are accepted for Pakistan:

```dart
// International format
Validators.validatePhone('+12025551234', 'US');      // null (valid)
Validators.validatePhone('+923001234567', 'PK');     // null (valid)

// Local format — auto-normalized before validation
Validators.validatePhone('2025551234', 'US');        // null (valid)
Validators.validatePhone('03001234567', 'PK');       // null (valid)
Validators.validatePhone('07911123456', 'GB');       // null (valid)

// Both GB and UK are accepted for the United Kingdom
Validators.validatePhone('+447911123456', 'GB');     // null (valid)
Validators.validatePhone('+447911123456', 'UK');     // null (valid)
```

Normalize a local number to international format independently:

```dart
String intl = Validators.normalizePhone('03001234567', 'PK');
// → '+923001234567'
```

**Supported countries (52):** US, CA, GB, UK, FR, DE, IN, AU, BR, CN, JP, MX, RU, ZA, NG, EG, KE, GH, SA, AE, IT, ES, SE, NO, FI, DK, NL, BE, CH, AT, PT, GR, TR, IR, PK, BD, LK, TH, MY, SG, ID, PH, VN, KR, HK, TW, NZ, AF, AL, DZ, AR, AZ, BH

```dart
TextFormField(
  decoration: InputDecoration(labelText: 'Phone', hintText: '+1 234 567 8900'),
  inputFormatters: [PhoneInputFormatter()],       // auto-formats as user types
  validator: (v) => Validators.validatePhone(v, 'US'),
  keyboardType: TextInputType.phone,
)
```

### Password

```dart
// Basic (min 6 chars)
Validators.validatePassword('secret');

// Full strength check
Validators.validatePassword(
  'MyP@ssw0rd',
  checkLength: true,
  minLength: 8,
  checkNumberAndLetter: true,
  checkSpecialCharacter: true,
  checkLowerCase: true,
  checkUpperCase: true,
);

// Password strength score (0–5)
int score = PasswordValidator.getPasswordStrength('MyP@ssw0rd'); // 5
```

### Name — Unicode aware

```dart
Validators.validateName('John Doe');      // null – Latin
Validators.validateName('José García');   // null – accented
Validators.validateName('محمد علي');     // null – Arabic
Validators.validateName('王芳');          // null – Chinese
Validators.validateName('राज कुमार');    // null – Hindi (Devanagari)
Validators.validateName('Иван Петров'); // null – Cyrillic
Validators.validateName('Γεώργιος');    // null – Greek
Validators.validateName('สมชาย ใจดี');  // null – Thai
Validators.validateName('Mary-Jane');    // null – hyphenated
Validators.validateName("O'Brien");      // null – apostrophe
Validators.validateName('John123');      // error – digits not allowed
```

### Age

```dart
Validators.validateAge('2000-01-15', 18);          // null if ≥18
Validators.validateAge(DateTime(2000, 1, 15), 18); // DateTime also accepted

Validators.validateAge(
  '2010-06-01',
  18,
  requiredError: 'Please enter your birth date',
  invalidError: 'You must be at least 18 years old',
);
```

### Date

```dart
Validators.validateDate('2024-01-15'); // null (valid)
Validators.validateDate('not-a-date'); // error
```

### Time

```dart
Validators.validateTime('14:30');      // null – HH:mm
Validators.validateTime('14:30:00');   // null – HH:mm:ss
Validators.validateTime('25:99:99');   // error – out of range (fixed in v1.3.0)
Validators.validateTime('00:00:00');   // null – midnight
```

### Financial — Credit Card & IBAN

```dart
// Credit card — 12–19 digits, then Luhn Mod-10
// Spaces and dashes are stripped automatically.
Validators.validateCreditCard('4111 1111 1111 1111'); // null (valid Visa test)
Validators.validateCreditCard('1234 5678 9012 3456'); // error

// Direct class usage
FinancialValidators.validateCreditCard('4111111111111111');

// IBAN — registered country/length plus MOD-97; spaces are ignored
Validators.validateIBAN('GB82 WEST 1234 5698 7654 32'); // null (valid)
Validators.validateIBAN('INVALID');                      // error

// In a TextFormField
TextFormField(
  validator: (v) => Validators.validateCreditCard(v),
  keyboardType: TextInputType.number,
)
```

### MultiValidator — chain validators

```dart
TextFormField(
  validator: MultiValidator([
    (v) => Validators.validateName(v),
    (v) => (v != null && v.length < 2) ? 'Too short' : null,
  ]),
)
```

---

## Complete Form Example

```dart
import 'package:flutter/material.dart';
import 'package:best_form_validator/best_form_validator.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Success!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Full Name'),
            validator: (v) => Validators.validateName(v),
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (v) => Validators.validateEmail(v),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Phone',
              hintText: '+1 555 000 0000 or local format',
            ),
            inputFormatters: [PhoneInputFormatter()],
            validator: (v) => Validators.validatePhone(v, 'US'),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
              helperText: 'Min 8 chars, upper, lower, number, special',
            ),
            obscureText: true,
            validator: (v) => Validators.validatePassword(
              v,
              checkLength: true,
              minLength: 8,
              checkNumberAndLetter: true,
              checkSpecialCharacter: true,
              checkLowerCase: true,
              checkUpperCase: true,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Birth Date',
              hintText: 'yyyy-MM-dd',
            ),
            validator: (v) => Validators.validateAge(v, 18,
                invalidError: 'Must be at least 18 years old'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
```

---

## API Reference

### `Validators` (convenience façade)

| Method | Description |
|--------|-------------|
| `validateEmail(value)` | Standard email format |
| `validateUrl(value, {...})` | HTTP/HTTPS URL with scheme and host checks |
| `validatePhone(value, isoCode)` | 52 countries, formatting cleanup and supported local normalization |
| `normalizePhone(value, isoCode)` | Convert local to international format |
| `validatePassword(value, {...})` | Configurable password rules |
| `validateName(value)` | Unicode-aware name validation |
| `validateAge(value, minimumAge)` | Minimum age from birth date |
| `validateDate(value)` | Parseable date string |
| `validateTime(value)` | Strict HH:mm or HH:mm:ss |
| `validateCreditCard(value)` | 12–19 digits plus Luhn algorithm (Mod-10) |
| `validateIBAN(value)` | Registered country length plus ISO 13616 MOD-97 |
| `setLocale(locale)` | Set global error message language |

### `PasswordValidator`

| Method | Description |
|--------|-------------|
| `validate(value, {...})` | Same as `Validators.validatePassword` |
| `getPasswordStrength(value)` | Returns int 0–5 entropy score |

### `PhoneValidator`

| Method | Description |
|--------|-------------|
| `validatePhoneNumber(value, isoCode)` | Direct phone validation |
| `normalizePhone(value, isoCode)` | Local → international conversion |

### `UrlValidator`

| Method | Description |
|--------|-------------|
| `validate(value, {...})` | Same as `Validators.validateUrl` |

### `FinancialValidators`

| Method | Description |
|--------|-------------|
| `validateCreditCard(value)` | 12–19 digits, Luhn check, strips spaces/dashes |
| `validateIBAN(value)` | Country-length and MOD-97 checks, strips spaces |

### `MultiValidator`

```dart
MultiValidator([validator1, validator2, ...])
```

Calls each validator in order and returns the first non-null error.

### `PhoneInputFormatter`

A `TextInputFormatter` that auto-spaces phone numbers as the user types (`+XXX XXX XXX XXX`).

---

## Supported Languages (25)

`en` `es` `fr` `de` `ar` `ur` `hi` `zh` `pt` `ru` `it` `tr` `ja` `ko` `id` `ms` `th` `vi` `nl` `sv` `no` `fi` `da` `el` `fa`

---

## Platform Support

| Android | iOS | Web | Windows | macOS | Linux |
|:-------:|:---:|:---:|:-------:|:-----:|:-----:|
| ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

---

## Requirements

- Dart SDK: `>=3.0.0 <4.0.0`
- Flutter: `>=3.0.0`
- Dependencies: `intl ^0.20.2` (only direct dependency)

---

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -m 'Add my feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a Pull Request

Please file bugs and feature requests in our [issue tracker](https://github.com/greelogix/best_form_validator/issues).

---

## License

MIT — see [LICENSE](LICENSE).

---

## Maintained By

**GreeLogix** — Flutter, Laravel & AI Development Agency  
🌐 https://greelogix.com  
📩 hello@greelogix.com

---

## Other Flutter Packages by GreeLogix

| Package | Description |
|---------|-------------|
| [quick_popup_manager](https://pub.dev/packages/quick_popup_manager) | Smart popup, dialog & overlay management |
| [smart_form_toolkit](https://pub.dev/packages/smart_form_toolkit) | Advanced form toolkit with ready-to-use widgets |
| [safe_json_mapper](https://pub.dev/packages/safe_json_mapper) | Type-safe JSON parsing and mapping |
| [flutter_telescope](https://pub.dev/packages/flutter_telescope) | Debugging, logging & app insights toolkit |

---

See [CHANGELOG.md](CHANGELOG.md) for a full history of changes.
