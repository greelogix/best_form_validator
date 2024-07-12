class NameValidator {
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
