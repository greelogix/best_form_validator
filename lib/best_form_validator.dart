/// A comprehensive Flutter package for form validation.
///
/// Provides zero-initialization, synchronous validators for all common form
/// fields. Every validator returns `String?` — `null` means valid, a non-null
/// string is the localized error message — so they plug directly into
/// `TextFormField.validator` with no boilerplate.
///
/// ## Quick start
///
/// ```dart
/// import 'package:best_form_validator/best_form_validator.dart';
///
/// TextFormField(
///   validator: (v) => Validators.validateEmail(v),
/// )
/// ```
///
/// ## Validators
///
/// | Class | What it validates |
/// |-------|------------------|
/// | [Validators] | Convenience façade — email, url, phone, password, name, age, date, time |
/// | [EmailValidator] | — delegated by `Validators.validateEmail` |
/// | [UrlValidator] | HTTP/HTTPS URL validation |
/// | [PhoneValidator] | Phone numbers for 52 countries, auto-normalizes local formats |
/// | [PasswordValidator] | Password rules + `getPasswordStrength()` (score 0–5) |
/// | [NameValidator] | Unicode-aware name validation |
/// | [AgeValidator] | Minimum age from birth date |
/// | [FinancialValidators] | Credit card (Luhn) and IBAN (MOD-97) |
/// | [MultiValidator] | Chains multiple validators, returns first error |
///
/// ## Formatting
///
/// | Class | Purpose |
/// |-------|---------|
/// | [PhoneInputFormatter] | `TextInputFormatter` that auto-spaces phone numbers |
///
/// ## Localization
///
/// | Class | Purpose |
/// |-------|---------|
/// | [FormLocalizations] | 25-language error-message delegate |
///
/// Add `FormLocalizations.delegate` to `MaterialApp.localizationsDelegates`
/// and call `Validators.setLocale(locale)` in your app's `builder` to enable
/// translated error messages.
library;

// Core validators
export 'src/validators.dart';
export 'src/url_validator.dart';
export 'src/age_validator.dart';
export 'src/name_validator.dart';
export 'src/password_validator.dart';
export 'src/phone_validator.dart';

// Financial validators (Luhn + IBAN)
export 'src/financial_validators.dart';

// Chaining utility
export 'src/multi_validator.dart';

// Input formatter
export 'src/formatters/phone_formatter.dart';

// Localization
export 'src/i18n/form_localizations.dart';
