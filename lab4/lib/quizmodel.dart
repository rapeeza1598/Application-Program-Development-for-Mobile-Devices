import 'dart:convert';

import 'package:lab4/choice.dart';

List<QuizModel> quizModelFromJson(String str) => List<QuizModel>.from(json.decode(str).map((x)=>QuizModel.fromJson(x)));
class QuizModel {
  String title;
  List<Choice> choice;
  int answerId;

  QuizModel(
      {required String this.title,
      required List<Choice> this.choice,
      required int this.answerId});

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
      title: json["title"],
      choice: List<Choice>.from(json["choice"].map((x)=>Choice.fromJson(x))),
      answerId: json["answerID"]);

  Map<String, dynamic> toJson() => {
    "title" :title,
    "choice" :List<dynamic>.from(choice.map((x) => x.toJson())),
    "answerID" :answerId,
  };
}
