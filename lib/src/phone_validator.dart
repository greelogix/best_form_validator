import 'i18n/form_localizations.dart';
import 'phone_regex_map.dart';

/// Phone number validator with support for 50+ countries.
///
/// This class handles phone number validation based on country-specific
/// regex patterns. It now uses a statically linked map for synchronous
/// (zero-initialization) validation.
class PhoneValidator {
  /// [DEPRECATED] No longer required to be called.
  /// Phone regex patterns are now statically loaded for instant, synchronous validation.
  ///
  /// Safe to remove from your `main()` function:
  /// ```dart
  /// // Remove this line
  /// await Validators.loadPhoneRegex();
  /// ```
  @Deprecated(
    'No longer needed. Phone regex forms are statically loaded. Safe to remove.',
  )
  static Future<String?> loadRegexMap() async {
    return "regex is loaded statically";
  }

  /// [DEPRECATED] No longer required to be called.
  @Deprecated(
    'No longer needed. Phone regex forms are statically loaded. Safe to remove.',
  )
  static Future<String?> loadRegexMapTest() async {
    return "regex is loaded statically";
  }

  /// Validates a phone number for a specific country.
  ///
  /// Returns `null` if the phone number is valid for the given country,
  /// otherwise returns an error message.
  ///
  /// Parameters:
  /// - [value]: The phone number to validate (should include country code)
  /// - [isoCode]: The ISO country code (e.g., 'US', 'UK', 'PK')
  ///
  /// Supported countries: US, CA, UK, FR, DE, IN, AU, BR, CN, JP, MX, RU, ZA,
  /// NG, EG, KE, GH, SA, AE, IT, ES, SE, NO, FI, DK, NL, BE, CH, AT, PT, GR,
  /// TR, IR, PK, BD, LK, TH, MY, SG, ID, PH, VN, KR, HK, TW, NZ, AF, AL, DZ,
  /// AR, AZ, BH
  ///
  /// Example:
  /// ```dart
  /// String? error = PhoneValidator.validatePhoneNumber('+12025551234', 'US');
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

    // Lookup regex pattern based on ISO code
    final regexPattern = phoneRegexMap[isoCode];
    if (regexPattern == null) {
      return FormLocalizations.global.countryCodeNotSupported;
    }

    final regExp = RegExp(regexPattern);
    if (!regExp.hasMatch(value)) {
      return invalidError ?? FormLocalizations.global.invalidPhone(isoCode);
    }
    return null;
  }
}
