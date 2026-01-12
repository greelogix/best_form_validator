import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'languages/en.dart';
import 'languages/es.dart';
import 'languages/fr.dart';
import 'languages/de.dart';
import 'languages/ar.dart';
import 'languages/ur.dart';
import 'languages/hi.dart';
import 'languages/zh.dart';
import 'languages/pt.dart';
import 'languages/ru.dart';
import 'languages/it.dart';
import 'languages/tr.dart';
import 'languages/ja.dart';
import 'languages/ko.dart';
import 'languages/id.dart';
import 'languages/ms.dart';
import 'languages/th.dart';
import 'languages/vi.dart';
import 'languages/nl.dart';
import 'languages/sv.dart';
import 'languages/no.dart';
import 'languages/fi.dart';
import 'languages/da.dart';
import 'languages/el.dart';
import 'languages/fa.dart';

/// Defines the localized strings used by the form validators.
abstract class FormLocalizations {
  static FormLocalizations of(BuildContext context) {
    return Localizations.of<FormLocalizations>(context, FormLocalizations) ??
        EnFormLocalizations();
  }

  /// Global instance for static access
  static FormLocalizations _global = EnFormLocalizations();

  /// Sets the global localization instance
  static void setGlobal(FormLocalizations l) => _global = l;

  /// Gets the global localization instance
  static FormLocalizations get global => _global;

  /// Gets the localization instance for a specific locale
  static FormLocalizations getByLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return EnFormLocalizations();
      case 'es':
        return EsFormLocalizations();
      case 'fr':
        return FrFormLocalizations();
      case 'de':
        return DeFormLocalizations();
      case 'ar':
        return ArFormLocalizations();
      case 'ur':
        return UrFormLocalizations();
      case 'hi':
        return HiFormLocalizations();
      case 'zh':
        return ZhFormLocalizations();
      case 'pt':
        return PtFormLocalizations();
      case 'ru':
        return RuFormLocalizations();
      case 'it':
        return ItFormLocalizations();
      case 'tr':
        return TrFormLocalizations();
      case 'ja':
        return JaFormLocalizations();
      case 'ko':
        return KoFormLocalizations();
      case 'id':
        return IdFormLocalizations();
      case 'ms':
        return MsFormLocalizations();
      case 'th':
        return ThFormLocalizations();
      case 'vi':
        return ViFormLocalizations();
      case 'nl':
        return NlFormLocalizations();
      case 'sv':
        return SvFormLocalizations();
      case 'no':
        return NoFormLocalizations();
      case 'fi':
        return FiFormLocalizations();
      case 'da':
        return DaFormLocalizations();
      case 'el':
        return ElFormLocalizations();
      case 'fa':
        return FaFormLocalizations();
      default:
        return EnFormLocalizations();
    }
  }

  static const LocalizationsDelegate<FormLocalizations> delegate =
      _FormLocalizationsDelegate();

  /// Email validation messages
  String get emailRequired;
  String get invalidEmail;

  /// Phone validation messages
  String get phoneRequired;
  String invalidPhone(String country);
  String get countryCodeNotSupported;

  /// Password validation messages
  String get passwordRequired;
  String passwordMinLength(int length);
  String get passwordNumberAndLetter;
  String get passwordSpecialCharacter;
  String get passwordLowerCase;
  String get passwordUpperCase;
  String get passwordNoSpaces;

  /// Name validation messages
  String get nameRequired;
  String get nameInvalid;

  /// Age validation messages
  String get dateRequired;
  String get invalidDate;
  String ageMin(int age);

  /// Time validation messages
  String get timeRequired;
  String get invalidTime;
}

class _FormLocalizationsDelegate
    extends LocalizationsDelegate<FormLocalizations> {
  const _FormLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'es',
      'fr',
      'de',
      'ar',
      'ur',
      'hi',
      'zh',
      'pt',
      'ru',
      'it',
      'tr',
      'ja',
      'ko',
      'id',
      'ms',
      'th',
      'vi',
      'nl',
      'sv',
      'no',
      'fi',
      'da',
      'el',
      'fa'
    ].contains(locale.languageCode);
  }

  @override
  Future<FormLocalizations> load(Locale locale) {
    return SynchronousFuture(FormLocalizations.getByLocale(locale));
  }

  @override
  bool shouldReload(_FormLocalizationsDelegate old) => false;
}
