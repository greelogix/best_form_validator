
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
      'en', 'es', 'fr', 'de', 'ar', 'ur', 'hi', 'zh', 'pt', 'ru',
      'it', 'tr', 'ja', 'ko', 'id', 'ms', 'th', 'vi', 'nl', 'sv',
      'no', 'fi', 'da', 'el', 'fa'
    ].contains(locale.languageCode);
  }

  @override
  Future<FormLocalizations> load(Locale locale) {
    switch (locale.languageCode) {
      case 'en': return SynchronousFuture(EnFormLocalizations());
      case 'es': return SynchronousFuture(EsFormLocalizations());
      case 'fr': return SynchronousFuture(FrFormLocalizations());
      case 'de': return SynchronousFuture(DeFormLocalizations());
      case 'ar': return SynchronousFuture(ArFormLocalizations());
      case 'ur': return SynchronousFuture(UrFormLocalizations());
      case 'hi': return SynchronousFuture(HiFormLocalizations());
      case 'zh': return SynchronousFuture(ZhFormLocalizations());
      case 'pt': return SynchronousFuture(PtFormLocalizations());
      case 'ru': return SynchronousFuture(RuFormLocalizations());
      case 'it': return SynchronousFuture(ItFormLocalizations());
      case 'tr': return SynchronousFuture(TrFormLocalizations());
      case 'ja': return SynchronousFuture(JaFormLocalizations());
      case 'ko': return SynchronousFuture(KoFormLocalizations());
      case 'id': return SynchronousFuture(IdFormLocalizations());
      case 'ms': return SynchronousFuture(MsFormLocalizations());
      case 'th': return SynchronousFuture(ThFormLocalizations());
      case 'vi': return SynchronousFuture(ViFormLocalizations());
      case 'nl': return SynchronousFuture(NlFormLocalizations());
      case 'sv': return SynchronousFuture(SvFormLocalizations());
      case 'no': return SynchronousFuture(NoFormLocalizations());
      case 'fi': return SynchronousFuture(FiFormLocalizations());
      case 'da': return SynchronousFuture(DaFormLocalizations());
      case 'el': return SynchronousFuture(ElFormLocalizations());
      case 'fa': return SynchronousFuture(FaFormLocalizations());
      default: return SynchronousFuture(EnFormLocalizations());
    }
  }

  @override
  bool shouldReload(_FormLocalizationsDelegate old) => false;
}
