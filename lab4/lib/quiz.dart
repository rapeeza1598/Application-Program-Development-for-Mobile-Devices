import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab4/quizmodel.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String out = "";
  int selChoice = 0;
  late List<QuizModel> quiz = [];

  void loadJson() async {
    final String response =
        await rootBundle.loadString("assets/json/data.json");
    final jsdata = quizModelFromJson(response);
    setState(() {
      // out = response;
      // out = "${jsdata[0].title}";
      quiz = jsdata;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz State"),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Column(children: [
        Text(out),
        ElevatedButton(onPressed: () => loadJson(), child: Text("Load Json")),
        quiz.isNotEmpty
            ? Expanded(
                child: Column(
                children: [
                  Text("โจทย์ : ${quiz[0].title}"),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Radio(
                            value: quiz[0].choice[index].id,
                            groupValue: selChoice,
                            onChanged: (int? value) {
                              setState(() {
                                selChoice = value!;
                              });
                            }),
                        title: Text(quiz[0].choice[index].title),
                      );
                    },
                    itemCount: quiz[0].choice.length,
                  )
                ],
              ))
            : Container()
      ]),
    );
  }
}
