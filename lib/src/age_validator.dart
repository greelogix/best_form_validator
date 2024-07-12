import 'package:intl/intl.dart';

class AgeValidator {
  static String? validateAge(dynamic birthDate, int minimumAge,
      {String? requiredError, String? invalidError}) {
    DateTime? parsedDate;
    if (birthDate is String) {
      try {
        parsedDate = DateFormat('yyyy-MM-dd').parseStrict(birthDate);
      } catch (e) {
        return invalidError ?? 'Invalid date format. Use yyyy-MM-dd.';
      }
    } else if (birthDate is DateTime) {
      parsedDate = birthDate;
    } else {
      return invalidError ?? 'Invalid birth date type.';
    }

    final today = DateTime.now();
    final age = today.year - parsedDate.year;
    final hasHadBirthdayThisYear = (today.month > parsedDate.month) ||
        (today.month == parsedDate.month && today.day >= parsedDate.day);

    if (age < minimumAge || (age == minimumAge && !hasHadBirthdayThisYear)) {
      return invalidError ?? 'Age must be at least $minimumAge years old.';
    }

    return null;
  }
}
