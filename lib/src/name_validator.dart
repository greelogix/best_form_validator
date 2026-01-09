/// Name validator ensuring proper name formatting.
///
/// Validates that names contain only alphabetic characters and spaces,
/// with no leading/trailing spaces or special characters.
class NameValidator {
  /// Validates a name string.
  ///
  /// Returns `null` if the name is valid, otherwise returns an error message.
  ///
  /// Validation rules:
  /// - Only alphabetic characters and spaces allowed
  /// - No leading or trailing spaces
  /// - No multiple consecutive spaces
  /// - No special characters or numbers
  ///
  /// Parameters:
  /// - [value]: The name to validate
  /// - [requiredError]: Custom error when name is empty (default: "Name is required")
  /// - [invalidError]: Custom error when format is invalid (default: "Name is invalid")
  ///
  /// Example:
  /// ```dart
  /// String? error = NameValidator.validate('John Doe');
  /// ```
  static String? validate(String? value,
      {String? requiredError, String? invalidError}) {
    if (value == null || value.trim().isEmpty) {
      return requiredError ?? 'Name is required';
    }

    // Check if the name contains any special characters or numbers
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value.replaceAll(' ', ''))) {
      return invalidError ?? "Name is invalid";
    }

    // Check for leading, trailing, or multiple spaces
    if (value.startsWith(' ') ||
        value.endsWith(' ') ||
        value.contains(RegExp(r'\s{2,}'))) {
      return invalidError ?? "Name is invalid";
    }

    return null;
  }
}
