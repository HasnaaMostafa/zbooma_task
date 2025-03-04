import 'package:flutter/foundation.dart';
import 'package:intl_phone_field/countries.dart';

String? extractPhoneNumber(String phoneNumber) {
  final RegExp regExp = RegExp(r'^(\d{1,2})\s*(.*)$');

  final Match? match = regExp.firstMatch(phoneNumber);
  if (match != null) {
    final String code = match.group(1) ?? '';
    final String number = match.group(2) ?? '';

    if (kDebugMode) {
      print('Country Code: $code');
    }
    if (kDebugMode) {
      print('Phone Number: $number');
    }

    return number;
  }

  return null;
}

String? getCountryCodeFromPhoneNumber(String phoneNumber) {
  for (Country country in countries) {
    if (phoneNumber.startsWith(country.dialCode)) {
      return country.code;
    }
  }
  return null;
}

String? getCountryDialCodeFromPhoneNumber(String phoneNumber) {
  for (Country country in countries) {
    if (phoneNumber.startsWith(country.dialCode)) {
      return country.dialCode;
    }
  }
  return null;
}
