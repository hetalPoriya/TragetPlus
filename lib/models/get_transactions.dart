// To parse this JSON data, do
//
//     final getTransactionModel = getTransactionModelFromMap(jsonString);

import 'dart:convert';

GetTransactionModel getTransactionModelFromMap(String str) =>
    GetTransactionModel.fromMap(json.decode(str));

String getTransactionModelToMap(GetTransactionModel data) =>
    json.encode(data.toMap());

class GetTransactionModel {
  GetTransactionModel({
    this.status,
    this.data,
  });

  bool? status;
  List<GetTransactionList>? data;

  factory GetTransactionModel.fromMap(Map<String, dynamic> json) =>
      GetTransactionModel(
        status: json["Status"],
        data: json["Data"] == null
            ? null
            : List<GetTransactionList>.from(
                json["Data"].map((x) => GetTransactionList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Status": status,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetTransactionList {
  GetTransactionList({
    this.id,
    this.parentCode,
    this.amountFor,
    this.notes,
    this.amount,
    this.txnDate,
    this.txnType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.amountForName,
  });

  int? id;
  String? parentCode;
  String? amountFor;
  String? notes;
  int? amount;
  DateTime? txnDate;
  String? txnType;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? amountForName;

  factory GetTransactionList.fromMap(Map<String, dynamic> json) =>
      GetTransactionList(
        id: json["id"],
        parentCode: json["parent_code"],
        amountFor: json["amount_for"],
        notes: json["notes"],
        amount: json["amount"],
        txnDate:
            json["txn_date"] == null ? null : DateTime.parse(json["txn_date"]),
        txnType: json["txn_type"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        amountForName: json["amount_for_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "parent_code": parentCode,
        "amount_for": amountFor,
        "notes": notes,
        "amount": amount,
        "txn_date": txnDate == null
            ? null
            : "${txnDate?.year.toString().padLeft(4, '0')}-${txnDate?.month.toString().padLeft(2, '0')}-${txnDate?.day.toString().padLeft(2, '0')}",
        "txn_type": txnType,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "amount_for_name": amountForName,
      };
}
