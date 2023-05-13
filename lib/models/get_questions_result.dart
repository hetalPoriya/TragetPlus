// To parse this JSON data, do
//
//     final getQuestionResultModel = getQuestionResultModelFromMap(jsonString);

import 'dart:convert';

GetQuestionResultModel getQuestionResultModelFromMap(String str) =>
    GetQuestionResultModel.fromMap(json.decode(str));

String getQuestionResultModelToMap(GetQuestionResultModel data) =>
    json.encode(data.toMap());

class GetQuestionResultModel {
  GetQuestionResultModel({
    this.status,
    this.data,
  });

  bool? status;
  List<GetQuestionResultList>? data;

  factory GetQuestionResultModel.fromMap(Map<String, dynamic> json) =>
      GetQuestionResultModel(
        status: json["Status"],
        data: json["Data"] == null
            ? null
            : List<GetQuestionResultList>.from(
                json["Data"].map((x) => GetQuestionResultList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Status": status,
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetQuestionResultList {
  GetQuestionResultList({
    this.id,
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
    this.studentId,
    this.studentAnswer,
    this.time,
    this.result,
  });

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
  int? studentId;
  String? studentAnswer;
  DateTime? time;
  int? result;

  factory GetQuestionResultList.fromMap(Map<String, dynamic> json) =>
      GetQuestionResultList(
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
        studentId: json["student_id"],
        studentAnswer: json["student_answer"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        result: json["result"],
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
        "student_id": studentId,
        "student_answer": studentAnswer,
        "time": time?.toIso8601String(),
        "result": result,
      };
}
