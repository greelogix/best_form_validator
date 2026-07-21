import '../form_localizations.dart';

class HiFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'ईमेल आवश्यक है';
  @override
  String get invalidEmail => 'एक मान्य ईमेल दर्ज करें';
  @override
  String get urlRequired => 'URL आवश्यक है';
  @override
  String get invalidUrl => 'एक मान्य URL दर्ज करें';
  @override
  String get phoneRequired => 'फ़ोन नंबर आवश्यक है';
  @override
  String invalidPhone(String country) =>
      '$country के लिए एक मान्य फ़ोन नंबर दर्ज करें';
  @override
  String get countryCodeNotSupported => 'देश कोड समर्थित नहीं है';
  @override
  String get passwordRequired => 'पासवर्ड आवश्यक है';
  @override
  String passwordMinLength(int length) =>
      'पासवर्ड कम से कम $length अक्षरों का होना चाहिए';
  @override
  String get passwordNumberAndLetter =>
      'पासवर्ड में अक्षर और संख्या दोनों होने चाहिए';
  @override
  String get passwordSpecialChar => 'कम से कम एक विशेष वर्ण होना चाहिए';
  @override
  String get passwordLowercase => 'कम से कम एक छोटा अक्षर होना चाहिए';
  @override
  String get passwordUppercase => 'कम से कम एक बड़ा अक्षर होना चाहिए';
  @override
  String get passwordNoSpaces => 'पासवर्ड में रिक्त स्थान नहीं होना चाहिए';
  @override
  String get nameRequired => 'नाम आवश्यक है';
  @override
  String get nameInvalid => 'नाम अमान्य है';
  @override
  String get dateRequired => 'दिनांक आवश्यक है';
  @override
  String get invalidDate => 'अमान्य दिनांक प्रारूप';
  @override
  String ageMin(int age) => 'आयु कम से कम $age वर्ष होनी चाहिए';
  @override
  String get timeRequired => 'समय आवश्यक है';
  @override
  String get invalidTime => 'अमान्य समय प्रारूप';
  @override
  String get creditCardRequired => 'क्रेडिट कार्ड नंबर आवश्यक है';
  @override
  String get invalidCreditCard => 'अमान्य क्रेडिट कार्ड नंबर';
  @override
  String get ibanRequired => 'IBAN आवश्यक है';
  @override
  String get invalidIban => 'अमान्य IBAN नंबर';
}
