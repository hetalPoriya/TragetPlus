// To parse this JSON data, do
//
//     final getClassesModel = getClassesModelFromMap(jsonString);

import 'dart:convert';

GetClassesModel getClassesModelFromMap(String str) =>
    GetClassesModel.fromMap(json.decode(str));

String getClassesModelToMap(GetClassesModel data) => json.encode(data.toMap());

class GetClassesModel {
  GetClassesModel({
    this.status,
    this.data,
  });

  bool? status;
  List<GetClassesList>? data;

  factory GetClassesModel.fromMap(Map<String, dynamic> json) => GetClassesModel(
        status: json["Status"],
        data: json["Data"] == null
            ? null
            : List<GetClassesList>.from(
                json["Data"].map((x) => GetClassesList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Status": status,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetClassesList {
  GetClassesList(
      {this.id,
      this.name,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.streams});

  int? id;
  String? name;
  int? status;
  String? streams;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GetClassesList.fromMap(Map<String, dynamic> json) => GetClassesList(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        streams: json["status"] == null ? null : json["streams"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "status": status,
        "streams": streams,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
