/// A comprehensive Flutter package for form validation.
///
/// This package provides robust validation functions for various form fields including:
/// - Email validation
/// - Phone number validation (50+ countries)
/// - Password validation with customizable criteria
/// - Name validation
/// - Age validation
/// - Date and time validation
///
/// ## Usage
///
/// ### Email Validation
/// ```dart
/// String? error = Validators.validateEmail('user@example.com');
/// ```
///
/// ### Phone Validation
/// ```dart
/// // Initialize first (at app startup)
/// await Validators.loadPhoneRegex();
///
/// // Then validate
/// String? error = Validators.validatePhone('+12025551234', 'US');
/// ```
///
/// ### Password Validation
/// ```dart
/// String? error = Validators.validatePassword(
///   'MyP@ssw0rd',
///   checkLength: true,
///   minLength: 8,
///   checkNumberAndLetter: true,
///   checkSpecialCharacter: true,
///   checkLowerCase: true,
///   checkUpperCase: true,
/// );
/// ```
///
/// See individual validator classes for more details.
library;

export 'src/age_validator.dart';
export 'src/i18n/form_localizations.dart';
export 'src/name_validator.dart';
export 'src/password_validator.dart';
export 'src/phone_validator.dart';
export 'src/validators.dart';
