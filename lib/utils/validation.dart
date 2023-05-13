import 'package:get/get_utils/src/get_utils/get_utils.dart';

class FormValidation {
  static String? Function(String?)? emailValidation({String? value}) =>
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter email address';
        } else if (!GetUtils.isEmail(value)) {
          return 'Please enter valid email';
        }
        return null;
      };

  static String? Function(String?)? passwordValidation({String? value}) =>
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      };

  static String? Function(String?)? nameValidation({String? value}) => (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      };

  static String? Function(String?)? mobileNumberValidation({String? value}) =>
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your mobile number';
        } else if (value.length != 10) {
          return 'Please enter 10 digit mobile number';
        }
        return null;
      };

  static String? Function(String?)? addressValidation({String? value}) =>
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your address';
        }
        return null;
      };

  static String? Function(String?)? classValidation({String? value}) =>
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please select any one';
        }
        return null;
      };

  static String? Function(String?)? emptyValidation({String? value}) =>
      (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter valid value';
        }
        return null;
      };

  static String? Function(String?)? referralValidation({String? value}) =>
      (value) {
        RegExp regExp = RegExp(r"^[A-Za-z]{3}[0-9]{5}$");
        if (value == null || value.isEmpty) {
          return 'Please enter referral code';
        } else if (!regExp.hasMatch(value)) {
          return 'Enter a valid referral code(3 char & 5 digits)';
        }
        return null;
      };
}
