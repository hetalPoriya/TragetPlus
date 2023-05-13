// To parse this JSON data, do
//
//     final errorModel = errorModelFromMap(jsonString);

import 'dart:convert';

ErrorModel errorModelFromMap(String str) =>
    ErrorModel.fromMap(json.decode(str));

String errorModelToMap(ErrorModel data) => json.encode(data.toMap());

class ErrorModel {
  ErrorModel({
    this.email,
    this.mobile,
    this.referralCode,
  });

  List<String>? email;
  List<String>? mobile;
  List<String>? referralCode;

  factory ErrorModel.fromMap(Map<String, dynamic> json) => ErrorModel(
        email: json["email"] == null
            ? null
            : List<String>.from(json["email"].map((x) => x)),
        mobile: json["mobile"] == null
            ? null
            : List<String>.from(json["mobile"].map((x) => x)),
    referralCode: json["referral_code"] == null
            ? null
            : List<String>.from(json["referral_code"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "email":
            email == null ? null : List<dynamic>.from(email!.map((x) => x)),
        "mobile":
            mobile == null ? null : List<dynamic>.from(mobile!.map((x) => x)),
        "referral_code": referralCode == null
            ? null
            : List<dynamic>.from(referralCode!.map((x) => x)),
      };
}
