// To parse this JSON data, do
//
//     final getSubjectModel = getSubjectModelFromMap(jsonString);

import 'dart:convert';

GetSubjectModel getSubjectModelFromMap(String str) =>
    GetSubjectModel.fromMap(json.decode(str));

String getSubjectModelToMap(GetSubjectModel data) => json.encode(data.toMap());

class GetSubjectModel {
  GetSubjectModel({
    this.status,
    this.data,
  });

  bool? status;
  List<GetSubjectList>? data;

  factory GetSubjectModel.fromMap(Map<String, dynamic> json) => GetSubjectModel(
        status: json["Status"],
        data: json["Data"] == null
            ? null
            : List<GetSubjectList>.from(
                json["Data"].map((x) => GetSubjectList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Status": status,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetSubjectList {
  GetSubjectList({
    this.id,
    this.streamId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? streamId;
  String? name;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GetSubjectList.fromMap(Map<String, dynamic> json) => GetSubjectList(
        id: json["id"],
        streamId: json["stream_id"],
        name: json["name"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "stream_id": streamId,
        "name": name,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
