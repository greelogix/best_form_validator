import 'dart:convert';

import 'package:flutter/services.dart';

/// Phone number validator with support for 50+ countries.
///
/// This class handles phone number validation based on country-specific
/// regex patterns loaded from a JSON asset file.
///
/// **Important:** Call [loadRegexMap] at app startup before validation.
class PhoneValidator {
  static late Map<String, String> _regexMap;

  /// Loads phone number regex patterns from the bundled asset file.
  ///
  /// This method must be called at app startup before using [validatePhoneNumber].
  /// It loads country-specific regex patterns from the package's asset file.
  ///
  /// Returns a status message indicating success or failure.
  ///
  /// Example:
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await PhoneValidator.loadRegexMap();
  ///   runApp(MyApp());
  /// }
  /// ```
  static Future<String?> loadRegexMap() async {
    try {
      String jsonString = await rootBundle.loadString(
          'packages/best_form_validator/assets/countries_phone_regex.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _regexMap = jsonMap.map((key, value) => MapEntry(key, value as String));
      if (jsonMap.isNotEmpty) {
        return "regex is loaded";
      } else {
        return "regex is not loaded";
      }
    } catch (e) {
      return "Regex not loaded: ${e.toString()}";
    }
  }

  /// Loads phone number regex patterns for testing purposes.
  ///
  /// This is an alternative loading method used in test environments
  /// where the asset path differs from the package path.
  ///
  /// Returns a status message indicating success or failure.
  static Future<String?> loadRegexMapTest() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/countries_phone_regex.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _regexMap = jsonMap.map((key, value) => MapEntry(key, value as String));
      if (jsonMap.isNotEmpty) {
        return "regex is loaded";
      } else {
        return "regex is not loaded";
      }
    } catch (e) {
      return "Regex not loaded: ${e.toString()}";
    }
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
  static String? validatePhoneNumber(String? value, String isoCode) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Lookup regex pattern based on ISO code
    final regexPattern = _regexMap[isoCode];
    if (regexPattern == null) {
      return 'Country code not supported';
    }

    final regExp = RegExp(regexPattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid phone number for $isoCode';
    }
    return null;
  }
}
