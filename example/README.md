# Best Form Validator Example

This example demonstrates all the features of the `best_form_validator` package.

## Features Demonstrated

1. **Registration Form** - Complete registration form with all validators
2. **Login Form** - Simple login form with email and password validation
3. **Individual Validators** - Test each validator separately with live feedback
4. **Programmatic Validation** - Use validators in code without forms

## Running the Example

```bash
cd example
flutter pub get
flutter run
```

## Examples Included

### 1. Registration Form
- Name validation
- Email validation
- Phone validation with country selection
- Password validation with strength requirements
- Confirm password matching
- Age validation (18+)

### 2. Login Form
- Email validation
- Password validation
- Simple and clean UI

### 3. Individual Validators
- Test each validator independently
- Live validation feedback
- See error messages in real-time

### 4. Programmatic Validation
- Use validators without forms
- Test multiple inputs programmatically
- See validation results instantly

## Code Examples

### Basic Email Validation
```dart
String? error = Validators.validateEmail('user@example.com');
```

### Phone Validation with Country
```dart
String? error = Validators.validatePhone('+12025551234', 'US');
```

### Advanced Password Validation
```dart
String? error = Validators.validatePassword(
  'MyP@ssw0rd',
  checkLength: true,
  minLength: 8,
  checkNumberAndLetter: true,
  checkSpecialCharacter: true,
  checkLowerCase: true,
  checkUpperCase: true,
);
```

## Learn More

- [Package Documentation](https://pub.dev/packages/best_form_validator)
- [GitHub Repository](https://github.com/greelogix/best_form_validator)
