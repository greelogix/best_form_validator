import 'i18n/form_localizations.dart';

/// URL validator for HTTP and HTTPS addresses.
///
/// Validates that a value is a well-formed URL with an allowed scheme and a
/// non-empty host. Uses Dart's [Uri.tryParse] for parsing, then applies
/// additional checks to reject malformed or unsafe values.
///
/// Example:
/// ```dart
/// UrlValidator.validate('https://example.com');     // null – valid
/// UrlValidator.validate('http://localhost:3000');   // null – valid
/// UrlValidator.validate('example.com');             // error – missing scheme
/// ```
class UrlValidator {
  static const _defaultSchemes = ['http', 'https'];

  /// Validates a URL string.
  ///
  /// Returns `null` if valid, otherwise a localized error message.
  ///
  /// Parameters:
  /// - [value]: The URL to validate
  /// - [requiredError]: Custom error when the field is empty
  /// - [invalidError]: Custom error when the URL format is invalid
  /// - [isRequired]: Whether an empty value is an error (default: true)
  /// - [allowedSchemes]: Permitted URI schemes (default: `http`, `https`)
  /// - [allowMissingScheme]: When true, prepends `https://` if no scheme is
  ///   present (e.g. `example.com` → `https://example.com`)
  static String? validate(
    String? value, {
    String? requiredError,
    String? invalidError,
    bool isRequired = true,
    List<String> allowedSchemes = _defaultSchemes,
    bool allowMissingScheme = false,
  }) {
    if (value == null || value.trim().isEmpty) {
      if (!isRequired) return null;
      return requiredError ?? FormLocalizations.global.urlRequired;
    }

    final trimmed = value.trim();
    final candidate = _normalizeCandidate(trimmed, allowMissingScheme);

    if (!_isValidUrl(candidate, allowedSchemes)) {
      return invalidError ?? FormLocalizations.global.invalidUrl;
    }

    return null;
  }

  static String _normalizeCandidate(String value, bool allowMissingScheme) {
    if (!allowMissingScheme) return value;

    final uri = Uri.tryParse(value);
    if (uri != null && uri.hasScheme) return value;

    return 'https://$value';
  }

  static bool _isValidUrl(String value, List<String> allowedSchemes) {
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme) return false;

    final scheme = uri.scheme.toLowerCase();
    final normalizedSchemes =
        allowedSchemes.map((s) => s.toLowerCase()).toList(growable: false);
    if (!normalizedSchemes.contains(scheme)) return false;

    final host = uri.host;
    if (host.isEmpty) return false;

    // Reject hosts that are only whitespace or contain invalid characters.
    if (host.contains(' ')) return false;

    // Require a valid host: domain with TLD, localhost, or IP address.
    if (!_isValidHost(host)) return false;

    return true;
  }

  static bool _isValidHost(String host) {
    if (host == 'localhost') return true;

    // IPv4
    final ipv4 = RegExp(
      r'^(?:(?:25[0-5]|2[0-4]\d|[01]?\d?\d)\.){3}'
      r'(?:25[0-5]|2[0-4]\d|[01]?\d?\d)$',
    );
    if (ipv4.hasMatch(host)) return true;

    // IPv6 (basic check — Uri.parse handles brackets in host)
    if (host.startsWith('[') && host.endsWith(']')) return true;

    // Domain names must contain at least one dot (e.g. example.com).
    if (!host.contains('.')) return false;

    // Each label must be non-empty and not start/end with hyphen.
    final labels = host.split('.');
    if (labels.any((label) => label.isEmpty)) return false;

    final labelPattern = RegExp(r'^[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?$');
    return labels.every(labelPattern.hasMatch);
  }
}
