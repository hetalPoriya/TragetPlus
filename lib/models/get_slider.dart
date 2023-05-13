// To parse this JSON data, do
//
//     final getSlider = getSliderFromJson(jsonString);
import 'dart:convert';

GetSlider getSliderFromJson(String str) => GetSlider.fromJson(json.decode(str));

String getSliderToJson(GetSlider data) => json.encode(data.toJson());

class GetSlider {
  GetSlider({
    required this.status,
    required this.data,
  });

  bool status;

  List<GetSliderList> data;

  factory GetSlider.fromJson(Map<String, dynamic> json) => GetSlider(
        status: json["Status"],
        data: List<GetSliderList>.from(
            json["Data"].map((x) => GetSliderList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetSliderList {
  GetSliderList({
    required this.id,
    required this.type,
    required this.slide,
  });

  int id;
  int type;
  String slide;

  factory GetSliderList.fromJson(Map<String, dynamic> json) => GetSliderList(
        id: json["id"],
        type: json["type"],
        slide: json["slide"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "slide": slide,
      };
}
