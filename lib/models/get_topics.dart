// To parse this JSON data, do
//
//     final getTopicModel = getTopicModelFromMap(jsonString);

import 'dart:convert';

GetTopicModel getTopicModelFromMap(String str) =>
    GetTopicModel.fromMap(json.decode(str));

String getTopicModelToMap(GetTopicModel data) => json.encode(data.toMap());

class GetTopicModel {
  GetTopicModel({
    this.status,
    this.data,
  });

  bool? status;
  List<GetTopicsList>? data;

  factory GetTopicModel.fromMap(Map<String, dynamic> json) => GetTopicModel(
        status: json["Status"],
        data: json["Data"] == null
            ? null
            : List<GetTopicsList>.from(
                json["Data"].map((x) => GetTopicsList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Status": status,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetTopicsList {
  GetTopicsList({
    this.id,
    this.subjectId,
    this.name,
    this.file,
    this.pages,
    this.size,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? subjectId;
  String? name;
  String? file;
  int? pages;
  String? size;
  int? type;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GetTopicsList.fromMap(Map<String, dynamic> json) => GetTopicsList(
        id: json["id"],
        subjectId: json["subject_id"],
        name: json["name"],
        file: json["file"],
        pages: json["pages"],
        size: json["size"],
        type: json["type"],
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
        "subject_id": subjectId,
        "name": name,
        "file": file,
        "pages": pages,
        "size": size,
        "type": type,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
