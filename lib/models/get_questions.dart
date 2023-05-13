// To parse this JSON data, do
//
//     final getQuestionModel = getQuestionModelFromMap(jsonString);

import 'dart:convert';

GetQuestionModel getQuestionModelFromMap(String str) =>
    GetQuestionModel.fromMap(json.decode(str));

String getQuestionModelToMap(GetQuestionModel data) =>
    json.encode(data.toMap());

class GetQuestionModel {
  GetQuestionModel({
    this.status,
    this.data,
  });

  bool? status;
  List<GetQuestionList>? data;

  factory GetQuestionModel.fromMap(Map<String, dynamic> json) =>
      GetQuestionModel(
        status: json["Status"],
        data: json["Data"] == null
            ? null
            : List<GetQuestionList>.from(
                json["Data"].map((x) => GetQuestionList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Status": status,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetQuestionList {
  GetQuestionList(
      {this.id,
      this.topicId,
      this.question,
      this.questionType,
      this.option1,
      this.option1Type,
      this.option2,
      this.option2Type,
      this.option3,
      this.option3Type,
      this.option4,
      this.option4Type,
      this.answer,
      this.solution,
      this.solutionType,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.answerString = ''});

  int? id;
  int? topicId;
  String? question;
  String? questionType;
  String? option1;
  String? option1Type;
  String? option2;
  String? option2Type;
  String? option3;
  String? option3Type;
  String? option4;
  String? option4Type;
  String? answer;
  dynamic solution;
  String? solutionType;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? answerString;

  factory GetQuestionList.fromMap(Map<String, dynamic> json) => GetQuestionList(
        id: json["id"],
        topicId: json["topic_id"],
        question: json["question"],
        questionType: json["question_type"],
        option1: json["option_1"],
        option1Type: json["option_1_type"],
        option2: json["option_2"],
        option2Type: json["option_2_type"],
        option3: json["option_3"],
        option3Type: json["option_3_type"],
        option4: json["option_4"],
        option4Type: json["option_4_type"],
        answer: json["answer"],
        solution: json["solution"],
        solutionType: json["solution_type"],
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
        "topic_id": topicId,
        "question": question,
        "question_type": questionType,
        "option_1": option1,
        "option_1_type": option1Type,
        "option_2": option2,
        "option_2_type": option2Type,
        "option_3": option3,
        "option_3_type": option3Type,
        "option_4": option4,
        "option_4_type": option4Type,
        "answer": answer,
        "solution": solution,
        "solution_type": solutionType,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
