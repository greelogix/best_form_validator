## 1.4.1

### Bug Fixes
- Phone validation now requires a full-string match, preventing valid numbers with junk prefixes or suffixes from being accepted.
- Phone formatting characters are stripped for every supported country; US/CA local numbers and country codes without `+` are normalized, and Italian geographic leading zeroes are preserved.
- Age validation now returns the required-field message for null, empty, and whitespace-only values, rejects future dates consistently, and rejects negative `minimumAge` configuration.
- Credit-card validation now enforces a practical payment-card length range (12–19 digits) and rejects trivial all-zero values before applying Luhn.
- IBAN validation now enforces registered country codes and country-specific lengths from the SWIFT IBAN Registry release 103 before applying MOD-97.
- Name validation now uses Unicode letter and combining-mark properties, adding complete script coverage including Cyrillic, Greek, Thai, and decomposed accented names.

### Maintenance
- Added regression tests for all fixes.
- Added `.pubignore` to remove IDE metadata, generated platform scaffolding, and the duplicate demo GIF from the published archive.
- Added the generated `build/` exclusion to static analysis configuration.

## 1.4.0

### New Features
- **`Validators.validateUrl()`** — validates HTTP/HTTPS URLs with a proper scheme and host. Supports optional fields (`isRequired: false`), custom schemes, and `allowMissingScheme` to accept bare domains like `example.com`.
- **`UrlValidator`** — exported publicly for direct use alongside the `Validators` façade.

### Localization
- URL validator error messages are fully localized in all 25 supported languages (`urlRequired`, `invalidUrl`).

### Documentation
- README updated with URL validation usage and API reference.
- Example app updated with a URL Validation showcase case.

### Test Coverage
- Added URL validator tests covering required/optional fields, scheme checks, localhost, IPv4, paths, whitespace trimming, and custom error messages.

## 1.3.0

### Bug Fixes
- **`validateTime` (HIGH)** — replaced `DateTime.parse` with a strict regex (`^([01]\d|2[0-3]):([0-5]\d)(?::([0-5]\d))?$`). Invalid times like `25:99:99` now correctly return an error. Accepts `HH:mm` and `HH:mm:ss`.
- **`validatePhone` local formats (HIGH)** — phone numbers in national/local format (e.g. `03001234567` for Pakistan, `07911123456` for UK) are now automatically normalized to international format before validation. No extra developer code needed.
- **`validatePhone` GB/UK alias (MEDIUM)** — both `'GB'` (ISO 3166-1 standard) and `'UK'` (legacy alias) are now accepted for the United Kingdom. Integrating any standard country-picker package no longer requires manual mapping.
- **`validateName` Unicode support (MEDIUM)** — the name validator now accepts any Unicode letter script: Latin, Arabic, Urdu, Hindi (Devanagari), Chinese (CJK), Japanese (Hiragana/Katakana), Korean (Hangul), and accented characters. Hyphens and apostrophes are allowed within tokens (e.g. `Mary-Jane`, `O'Brien`).

### New Public API
- **`FinancialValidators`** — `validateCreditCard()` and `validateIBAN()` are now exported from the public barrel (`best_form_validator.dart`). Previously only accessible via internal imports.
- **`MultiValidator`** — exported publicly. Chain any number of validators; returns the first error.
- **`PhoneInputFormatter`** — exported publicly. Auto-spaces phone numbers as the user types.
- **`Validators.validateCreditCard()`** — convenience façade for `FinancialValidators.validateCreditCard()`.
- **`Validators.validateIBAN()`** — convenience façade for `FinancialValidators.validateIBAN()`.
- **`Validators.normalizePhone()`** — converts a local phone number string to international format for a given ISO code.

### Localization
- Financial validator error messages are now fully localized in all 25 supported languages (`creditCardRequired`, `invalidCreditCard`, `ibanRequired`, `invalidIban`).

### Documentation Fixes
- Removed stale `await Validators.loadPhoneRegex()` from all doc comments and examples — this call has been a no-op since v1.2.0.
- Corrected `CHANGELOG` v1.2.0 entry: `getPasswordStrength()` is on `PasswordValidator`, not `Validators`.
- README completely rewritten: accurate examples for all validators, correct install version, local phone format examples, financial and MultiValidator documentation.

### Test Coverage
- Official test suite expanded from 12 tests to 107 tests covering every validator, edge cases, Unicode names, local phone normalization, GB/UK alias, strict time, financial validators, MultiValidator, PhoneInputFormatter, and localization.

### Maintenance
- Removed dead `assets/countries_phone_regex.json` (4 KB, unused since v1.2.0).
- Improved `pubspec.yaml` description to accurately reflect all features.

## 1.2.0

### Huge Performance & Feature Upgrade 🚀
- **Zero-Initialization Hook**: Phone Regex patterns are now statically compiled. You no longer need to `await Validators.loadPhoneRegex()` in your `main()`. Phone validation runs entirely synchronously!
- **Multi Validator**: Added `MultiValidator` to allow chaining multiple validations sequentially.
- **Financial Validation**: Added new `FinancialValidators` to support **Credit Cards** (Luhn Algorithm Mod-10) and **IBAN** checks (MOD-97).
- **Password Strength**: Added `PasswordValidator.getPasswordStrength()` which evaluates text entropy and returns an `int` score ranging from `0` to `5`.
- **Advanced Formatting**: Added `PhoneInputFormatter` which intelligently auto-formats international phone numbers as the user types.
- **Async Validations**: Added `AsyncValidator` utility helper.
- Over 25+ Language Localizations inherently patched to natively handle detailed password checks.

## 1.1.4

### Maintenance

- Minor documentation improvements.
- Updated dependencies.
- Updated the ReadMe.

## 1.1.3

### Maintenance

- Updated pubspec metadata for better pub.dev compliance.
- Fixed repository, homepage, and issue tracker URLs.
- Improved CHANGELOG consistency.
- Standardized Dart file conventions and documentation.

## 1.1.2

### Maintenance

- Package metadata updates.
- Improved pub.dev compliance.

## 1.1.1
    
### Maintenance
- Updated pubspec metadata for better pub.dev compliance.
- Shortened package description.
- Updated license file to standard MIT format.

## 1.1.0

### Features
- 🌍 **Full Localization Support**: Added support for 25+ languages including English, Spanish, French, German, Arabic, Urdu, Hindi, Chinese, Portuguese, Russian, Italian, Turkish, Japanese, Korean, and more.
- Added `Validators.setLocale(Locale)` for dynamic runtime locale switching.
- Added `FormLocalizations` class for accessing localized strings directly.

### Improvements
- Updated all validators (Email, Phone, Password, Name, Age, Date, Time) to automatically use localized error messages.
- Enhanced example app to demonstrate dynamic language switching.

## 1.0.4

### Improvements
- Enhanced package documentation with comprehensive examples
- Added detailed API reference documentation
- Improved README with complete usage examples
- Added support for 50+ countries in phone validation
- Updated dependencies to latest stable versions

### Bug Fixes
- Fixed phone validation initialization issues
- Improved error message consistency across validators

## 1.0.3

### Features
- Added date and time validation methods
- Improved age validation with better date parsing
- Enhanced password validation with configurable criteria

### Improvements
- Better error messages for all validators
- Improved null safety handling

## 1.0.2

### Improvements
- Configuration improvements for better customization
- Enhanced validator flexibility
- Updated documentation

### Bug Fixes
- Fixed minor validation edge cases
- Improved regex patterns for email validation

## 1.0.1

### Bug Fixes
- Fixed asset loading issues for phone validation
- Improved package initialization
- Minor documentation updates

## 1.0.0

### Initial Release
- ✅ Email validation with regex pattern matching
- ✅ Phone number validation for multiple countries
- ✅ Password validation with customizable criteria
- ✅ Name validation with proper formatting rules
- ✅ Age validation from DateTime or string
- ✅ Customizable error messages
- ✅ Null safety support
- ✅ Comprehensive test coverage
- ✅ Example application
- ✅ Full documentation
