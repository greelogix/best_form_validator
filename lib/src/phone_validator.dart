import 'dart:convert';

import 'package:flutter/services.dart';

class PhoneValidator {
  static late Map<String, String> _regexMap;

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
