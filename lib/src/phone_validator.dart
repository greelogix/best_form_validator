import 'i18n/form_localizations.dart';
import 'phone_regex_map.dart';

/// Phone number validator with support for 52 countries.
///
/// Validates phone numbers in international format (`+countryCode…`).
/// Local formats (e.g. `03001234567` for Pakistan) are automatically
/// normalised to international format when [localPrefix] and [countryCode]
/// are provided via [normalizePhone].
///
/// ### Supported ISO codes
/// Both `'GB'` (ISO 3166-1) and `'UK'` (legacy alias) are accepted for the
/// United Kingdom, so any country-picker package works without manual mapping.
///
/// Full list: US, CA, GB/UK, FR, DE, IN, AU, BR, CN, JP, MX, RU, ZA, NG, EG,
/// KE, GH, SA, AE, IT, ES, SE, NO, FI, DK, NL, BE, CH, AT, PT, GR, TR, IR,
/// PK, BD, LK, TH, MY, SG, ID, PH, VN, KR, HK, TW, NZ, AF, AL, DZ, AR, AZ, BH
class PhoneValidator {
  // ---------------------------------------------------------------------------
  // Local-to-international normalization table
  // Maps an ISO code to its (localPrefix, dialCode) pair so that local-format
  // numbers can be converted before validation.
  // ---------------------------------------------------------------------------
  static const Map<String, _LocalFormat> _localFormats = {
    'PK': _LocalFormat(localPrefix: '0', dialCode: '+92'),
    'IN': _LocalFormat(localPrefix: '0', dialCode: '+91'),
    'BD': _LocalFormat(localPrefix: '0', dialCode: '+880'),
    'GB': _LocalFormat(localPrefix: '0', dialCode: '+44'),
    'UK': _LocalFormat(localPrefix: '0', dialCode: '+44'),
    'DE': _LocalFormat(localPrefix: '0', dialCode: '+49'),
    'FR': _LocalFormat(localPrefix: '0', dialCode: '+33'),
    'IT': _LocalFormat(localPrefix: '0', dialCode: '+39'),
    'AU': _LocalFormat(localPrefix: '0', dialCode: '+61'),
    'NZ': _LocalFormat(localPrefix: '0', dialCode: '+64'),
    'ZA': _LocalFormat(localPrefix: '0', dialCode: '+27'),
    'NG': _LocalFormat(localPrefix: '0', dialCode: '+234'),
    'EG': _LocalFormat(localPrefix: '0', dialCode: '+20'),
    'KE': _LocalFormat(localPrefix: '0', dialCode: '+254'),
    'GH': _LocalFormat(localPrefix: '0', dialCode: '+233'),
    'TR': _LocalFormat(localPrefix: '0', dialCode: '+90'),
    'IR': _LocalFormat(localPrefix: '0', dialCode: '+98'),
    'LK': _LocalFormat(localPrefix: '0', dialCode: '+94'),
    'MY': _LocalFormat(localPrefix: '0', dialCode: '+60'),
    'NL': _LocalFormat(localPrefix: '0', dialCode: '+31'),
    'BE': _LocalFormat(localPrefix: '0', dialCode: '+32'),
    'AT': _LocalFormat(localPrefix: '0', dialCode: '+43'),
    'PT': _LocalFormat(localPrefix: '351', dialCode: '+351'),
    'GR': _LocalFormat(localPrefix: '0', dialCode: '+30'),
    'SE': _LocalFormat(localPrefix: '0', dialCode: '+46'),
    'NO': _LocalFormat(localPrefix: '0', dialCode: '+47'),
    'FI': _LocalFormat(localPrefix: '0', dialCode: '+358'),
    'DK': _LocalFormat(localPrefix: '0', dialCode: '+45'),
    'CH': _LocalFormat(localPrefix: '0', dialCode: '+41'),
    'ID': _LocalFormat(localPrefix: '0', dialCode: '+62'),
    'TH': _LocalFormat(localPrefix: '0', dialCode: '+66'),
    'VN': _LocalFormat(localPrefix: '0', dialCode: '+84'),
    'AF': _LocalFormat(localPrefix: '0', dialCode: '+93'),
    'AL': _LocalFormat(localPrefix: '0', dialCode: '+355'),
    'DZ': _LocalFormat(localPrefix: '0', dialCode: '+213'),
  };

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Attempts to normalise a locally-formatted phone number to international
  /// format for the given [isoCode].
  ///
  /// Returns the normalised string (e.g. `+923001234567`) when successful, or
  /// the original [value] unchanged when normalisation is not possible.
  ///
  /// Example:
  /// ```dart
  /// final intl = PhoneValidator.normalizePhone('03001234567', 'PK');
  /// // → '+923001234567'
  /// ```
  static String normalizePhone(String value, String isoCode) {
    final fmt = _localFormats[isoCode.toUpperCase()];
    if (fmt == null) return value;

    final stripped = value.replaceAll(RegExp(r'[\s\-()]'), '');

    // Already international
    if (stripped.startsWith('+')) return stripped;

    // Strip local trunk prefix (e.g. leading 0) and prepend dial code
    if (fmt.localPrefix.isNotEmpty && stripped.startsWith(fmt.localPrefix)) {
      return '${fmt.dialCode}${stripped.substring(fmt.localPrefix.length)}';
    }

    // No recognised prefix – prepend dial code as-is
    return '${fmt.dialCode}$stripped';
  }

  /// Validates a phone number for a specific country.
  ///
  /// The [value] may be in international format (`+923001234567`) **or** in a
  /// local/national format (`03001234567`). Local formats are automatically
  /// converted to international format before validation so developers do not
  /// need extra normalisation logic.
  ///
  /// [isoCode] accepts both `'GB'` and `'UK'` for the United Kingdom.
  ///
  /// Returns `null` when valid, or a localized error message when invalid.
  ///
  /// Supported ISO codes: US, CA, GB, UK, FR, DE, IN, AU, BR, CN, JP, MX, RU,
  /// ZA, NG, EG, KE, GH, SA, AE, IT, ES, SE, NO, FI, DK, NL, BE, CH, AT, PT,
  /// GR, TR, IR, PK, BD, LK, TH, MY, SG, ID, PH, VN, KR, HK, TW, NZ, AF, AL,
  /// DZ, AR, AZ, BH
  ///
  /// Example:
  /// ```dart
  /// // International format
  /// PhoneValidator.validatePhoneNumber('+12025551234', 'US'); // null (valid)
  ///
  /// // Local format – auto-normalised before validation
  /// PhoneValidator.validatePhoneNumber('03001234567', 'PK');  // null (valid)
  ///
  /// // Both GB and UK are accepted
  /// PhoneValidator.validatePhoneNumber('+447911123456', 'GB'); // null (valid)
  /// PhoneValidator.validatePhoneNumber('+447911123456', 'UK'); // null (valid)
  /// ```
  static String? validatePhoneNumber(
    String? value,
    String isoCode, {
    String? requiredError,
    bool isRequired = true,
    String? invalidError,
  }) {
    if (value == null || value.isEmpty) {
      if (isRequired) {
        return requiredError ?? FormLocalizations.global.phoneRequired;
      }
      return null;
    }

    final normalizedIso = isoCode.toUpperCase();

    // Lookup regex – check the exact code first, then GB↔UK alias
    String? regexPattern = phoneRegexMap[normalizedIso];
    if (regexPattern == null) {
      // Transparent alias: GB → UK and UK → GB
      if (normalizedIso == 'GB') {
        regexPattern = phoneRegexMap['UK'];
      } else if (normalizedIso == 'UK') {
        regexPattern = phoneRegexMap['GB'];
      }
    }

    if (regexPattern == null) {
      return FormLocalizations.global.countryCodeNotSupported;
    }

    // Auto-normalise local format to international before regex check
    final normalized = normalizePhone(value, normalizedIso);

    final regExp = RegExp(regexPattern);
    if (!regExp.hasMatch(normalized)) {
      return invalidError ??
          FormLocalizations.global.invalidPhone(normalizedIso);
    }
    return null;
  }

  // ---------------------------------------------------------------------------
  // Deprecated stubs kept for backwards compatibility
  // ---------------------------------------------------------------------------

  /// [DEPRECATED] No longer required to be called.
  /// Phone regex patterns are now statically loaded for instant, synchronous validation.
  ///
  /// Safe to remove from your `main()` function:
  /// ```dart
  /// // Remove this line – it is now a no-op
  /// await Validators.loadPhoneRegex();
  /// ```
  @Deprecated(
    'No longer needed. Phone regex is statically loaded. Safe to remove.',
  )
  static Future<String?> loadRegexMap() async {
    return 'regex is loaded statically';
  }

  /// [DEPRECATED] No longer required to be called.
  @Deprecated(
    'No longer needed. Phone regex is statically loaded. Safe to remove.',
  )
  static Future<String?> loadRegexMapTest() async {
    return 'regex is loaded statically';
  }
}

// ---------------------------------------------------------------------------
// Internal helper
// ---------------------------------------------------------------------------

class _LocalFormat {
  final String localPrefix;
  final String dialCode;
  const _LocalFormat({required this.localPrefix, required this.dialCode});
}
