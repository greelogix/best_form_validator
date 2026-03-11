import 'package:intl/intl.dart';
import 'i18n/form_localizations.dart';

/// Age validator with minimum age requirement checking.
///
/// Validates that a person's age meets a minimum requirement based on
/// their birth date. Accepts both DateTime objects and date strings.
class AgeValidator {
  /// Validates age meets a minimum requirement.
  ///
  /// Returns `null` if the age meets the minimum requirement,
  /// otherwise returns an error message.
  ///
  /// Accepts either a [DateTime] object or a date string in 'yyyy-MM-dd' format.
  /// Correctly calculates age accounting for whether the birthday has occurred
  /// this year.
  ///
  /// Parameters:
  /// - [birthDate]: Birth date as DateTime or String (yyyy-MM-dd)
  /// - [minimumAge]: Minimum age requirement in years
  /// - [requiredError]: Custom error when value is invalid
  /// - [invalidError]: Custom error when age doesn't meet minimum
  ///
  /// Example:
  /// ```dart
  /// // With string
  /// String? error = AgeValidator.validateAge('2000-01-15', 18);
  ///
  /// // With DateTime
  /// String? error = AgeValidator.validateAge(DateTime(2000, 1, 15), 18);
  /// ```
  static String? validateAge(
    dynamic birthDate,
    int minimumAge, {
    String? requiredError,
    String? invalidError,
  }) {
    DateTime? parsedDate;
    if (birthDate is String) {
      try {
        parsedDate = DateFormat('yyyy-MM-dd').parseStrict(birthDate);
      } catch (e) {
        return invalidError ?? FormLocalizations.global.invalidDate;
      }
    } else if (birthDate is DateTime) {
      parsedDate = birthDate;
    } else {
      return invalidError ?? FormLocalizations.global.invalidDate;
    }

    final today = DateTime.now();
    final age = today.year - parsedDate.year;
    final hasHadBirthdayThisYear = (today.month > parsedDate.month) ||
        (today.month == parsedDate.month && today.day >= parsedDate.day);

    if (age < minimumAge || (age == minimumAge && !hasHadBirthdayThisYear)) {
      return invalidError ?? FormLocalizations.global.ageMin(minimumAge);
    }

    return null;
  }
}
