// To parse this JSON data, do
//
//     final getEarningModel = getEarningModelFromMap(jsonString);

import 'dart:convert';

GetEarningModel getEarningModelFromMap(String str) =>
    GetEarningModel.fromMap(json.decode(str));

String getEarningModelToMap(GetEarningModel data) => json.encode(data.toMap());

class GetEarningModel {
  GetEarningModel({
    this.status,
    this.data,
  });

  bool? status;
  List<GetEarningList>? data;

  factory GetEarningModel.fromMap(Map<String, dynamic> json) => GetEarningModel(
        status: json["Status"],
        data: json["Data"] == null
            ? null
            : List<GetEarningList>.from(
                json["Data"].map((x) => GetEarningList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Status": status,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetEarningList {
  GetEarningList({
    this.todayCr,
    this.totalCr,
    this.totalDr,
    this.walletBalance,
  });

  int? todayCr;
  int? totalCr;
  int? totalDr;
  int? walletBalance;

  factory GetEarningList.fromMap(Map<String, dynamic> json) => GetEarningList(
        todayCr: json["TodayCR"],
        totalCr: json["TotalCR"],
        totalDr: json["TotalDR"],
        walletBalance: json["WalletBalance"],
      );

  Map<String, dynamic> toMap() => {
        "TodayCR": todayCr,
        "TotalCR": totalCr,
        "TotalDR": totalDr,
        "WalletBalance": walletBalance,
      };
}
