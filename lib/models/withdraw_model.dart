// To parse this JSON data, do
//
//     final withdawModel = withdawModelFromMap(jsonString);

import 'dart:convert';

WithdawModel withdawModelFromMap(String str) =>
    WithdawModel.fromMap(json.decode(str));

String withdawModelToMap(WithdawModel data) => json.encode(data.toMap());

class WithdawModel {
  WithdawModel({
    this.status,
    this.data,
  });

  bool? status;
  WithdawModelData? data;

  factory WithdawModel.fromMap(Map<String, dynamic> json) => WithdawModel(
        status: json["Status"],
        data: json["WithdawModelData"] == null
            ? null
            : WithdawModelData.fromMap(json["WithdawModelData"]),
      );

  Map<String, dynamic> toMap() => {
        "Status": status,
        "WithdawModelData": data?.toMap(),
      };
}

class WithdawModelData {
  WithdawModelData({
    this.message,
    this.balance,
  });

  String? message;
  int? balance;

  factory WithdawModelData.fromMap(Map<String, dynamic> json) =>
      WithdawModelData(
        message: json["message"],
        balance: json["Balance"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "Balance": balance,
      };
}
