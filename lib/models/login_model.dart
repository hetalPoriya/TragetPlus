// To parse this JSON data, do
//
//     final loginModel = loginModelFromMap(jsonString);

import 'dart:convert';

LoginModel loginModelFromMap(String str) =>
    LoginModel.fromMap(json.decode(str));

String loginModelToMap(LoginModel data) => json.encode(data.toMap());

class LoginModel {
  LoginModel(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.address,
      this.referralCode,
      this.myReferralCode,
      this.loginModelClass,
      this.stream,
      this.password,
      this.oPassword,
      this.upi,
      this.photo,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.isPremium,
      this.className,
      this.streamName});

  int? id;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? referralCode;
  String? myReferralCode;
  int? loginModelClass;
  int? stream;
  String? password;
  String? oPassword;
  String? upi;
  dynamic photo;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isPremium;
  String? className;
  String? streamName;

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        address: json["address"],
        referralCode: json["referral_code"],
        myReferralCode: json["my_referral_code"],
        loginModelClass: json["class"],
        stream: json["stream"],
        password: json["password"],
        oPassword: json["o_password"],
        upi: json["upi"],
        photo: json["photo"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isPremium: json["is_premium"],
        className: json["class_name"],
        streamName: json["stream_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "address": address,
        "referral_code": referralCode,
        "my_referral_code": myReferralCode,
        "class": loginModelClass,
        "stream": stream,
        "password": password,
        "o_password": oPassword,
        "upi": upi,
        "photo": photo,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_premium": isPremium,
        "class_name": className,
        "stream_name": streamName,
      };
}
