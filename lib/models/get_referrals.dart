// To parse this JSON data, do
//
//     final myReferralModel = myReferralModelFromMap(jsonString);

import 'dart:convert';

MyReferralModel myReferralModelFromMap(String str) =>
    MyReferralModel.fromMap(json.decode(str));

String myReferralModelToMap(MyReferralModel data) => json.encode(data.toMap());

class MyReferralModel {
  MyReferralModel({
    this.status,
    this.data,
  });

  bool? status;
  List<MyReferralData>? data;

  factory MyReferralModel.fromMap(Map<String, dynamic> json) => MyReferralModel(
        status: json["Status"],
        data: List<MyReferralData>.from(
            json["Data"].map((x) => MyReferralData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Status": status,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class MyReferralData {
  MyReferralData(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.address,
      this.referralCode,
      this.myReferralCode,
      this.datumClass,
      this.stream,
      this.password,
      this.oPassword,
      this.photo,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.direct});

  int? id;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? referralCode;
  String? myReferralCode;
  int? datumClass;
  int? stream;
  String? password;
  String? oPassword;
  dynamic photo;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? direct;

  factory MyReferralData.fromMap(Map<String, dynamic> json) => MyReferralData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        address: json["address"],
        referralCode: json["referral_code"],
        myReferralCode: json["my_referral_code"],
        datumClass: json["class"],
        stream: json["stream"],
        password: json["password"],
        oPassword: json["o_password"],
        photo: json["photo"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        direct: json["direct"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "address": address,
        "referral_code": referralCode,
        "my_referral_code": myReferralCode,
        "class": datumClass,
        "stream": stream,
        "password": password,
        "o_password": oPassword,
        "photo": photo,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "direct": direct,
      };
}
