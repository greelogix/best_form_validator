import '../form_localizations.dart';

class ThFormLocalizations extends FormLocalizations {
  @override
  String get emailRequired => 'จำเป็นต้องใช้อีเมล';
  @override
  String get invalidEmail => 'ป้อนอีเมลที่ถูกต้อง';
  @override
  String get phoneRequired => 'จำเป็นต้องใช้หมายเลขโทรศัพท์';
  @override
  String invalidPhone(String country) => 'ป้อนหมายเลขที่ถูกต้องสำหรับ $country';
  @override
  String get countryCodeNotSupported => 'ไม่รองรับรหัสประเทศ';
  @override
  String get passwordRequired => 'จำเป็นต้องใช้รหัสผ่าน';
  @override
  String passwordMinLength(int length) => 'รหัสผ่านต้องมีความยาวอย่างน้อย $length ตัวอักษร';
  @override
  String get passwordNumberAndLetter => 'รหัสผ่านต้องมีทั้งตัวอักษรและตัวเลข';
  @override
  String get passwordSpecialCharacter => 'ต้องมีอักขระพิเศษอย่างน้อยหนึ่งตัว';
  @override
  String get passwordLowerCase => 'ต้องมีตัวอักษรพิมพ์เล็กอย่างน้อยหนึ่งตัว';
  @override
  String get passwordUpperCase => 'ต้องมีตัวอักษรพิมพ์ใหญ่อย่างน้อยหนึ่งตัว';
  @override
  String get passwordNoSpaces => 'รหัสผ่านต้องไม่มีช่องว่าง';
  @override
  String get nameRequired => 'จำเป็นต้องใช้ชื่อ';
  @override
  String get nameInvalid => 'ชื่อไม่ถูกต้อง';
  @override
  String get dateRequired => 'จำเป็นต้องใช้วันที่';
  @override
  String get invalidDate => 'รูปแบบวันที่ไม่ถูกต้อง';
  @override
  String ageMin(int age) => 'อายุต้องมีอย่างน้อย $age ปี';
  @override
  String get timeRequired => 'จำเป็นต้องใช้เวลา';
  @override
  String get invalidTime => 'รูปแบบเวลาไม่ถูกต้อง';
}
