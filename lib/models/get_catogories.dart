
import 'dart:convert';

// To parse this JSON data, do
//
//     final getCategories = getCategoriesFromMap(jsonString);


GetCategories getCategoriesFromMap(String str) =>
    GetCategories.fromJson(json.decode(str));

String getCategoriesToMap(GetCategories data) => json.encode(data.toMap());

class GetCategories {
  GetCategories({
    this.status,
    this.data,
  });

  bool? status;
  List<GetCategoriesList>? data;

  factory GetCategories.fromJson(Map<String, dynamic> json) => GetCategories(
        status: json["Status"],
        data: json["Data"] == null
            ? []
            : List<GetCategoriesList>.from(
                json["Data"]!.map((x) => GetCategoriesList.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "Status": status,
        "Data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetCategoriesList {
  GetCategoriesList({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GetCategoriesList.fromJson(Map<String, dynamic> json) =>
      GetCategoriesList(
        id: json["id"],
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
        "name": name,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
