// To parse this JSON data, do
//
//     final geStreamsModel = geStreamsModelFromMap(jsonString);

import 'dart:convert';

GetStreamsModel geStreamsModelFromMap(String str) =>
    GetStreamsModel.fromMap(json.decode(str));

String geStreamsModelToMap(GetStreamsModel data) => json.encode(data.toMap());

class GetStreamsModel {
  GetStreamsModel({
    this.status,
    this.data,
  });

  bool? status;
  List<GetStreamsList>? data;

  factory GetStreamsModel.fromMap(Map<String, dynamic> json) => GetStreamsModel(
        status: json["Status"],
        data: json["Data"] == null
            ? null
            : List<GetStreamsList>.from(
                json["Data"].map((x) => GetStreamsList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Status": status,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetStreamsList {
  GetStreamsList({
    this.id,
    this.classId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? classId;
  String? name;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GetStreamsList.fromMap(Map<String, dynamic> json) => GetStreamsList(
        id: json["id"],
        classId: json["class_id"],
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
        "class_id": classId,
        "name": name,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
