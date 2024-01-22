import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homework3/quizModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<QuizModel> quiz;
  late List<int> correctAnswers;
  late Future<List<QuizModel>> quizFuture;

  int _currentIndex = 0;
  int score = 0;
  late List<int?> userAnswers;

  @override
  void initState() {
    quizFuture = loadJson();
    userAnswers = []; // Initialize userAnswers without 'late'
    super.initState();
  }

  Future<List<QuizModel>> loadJson() async {
    final String response =
        await rootBundle.loadString("assets/json/quiz.json");
    final data = quizModelFromJson(response);
    correctAnswers = List<int>.filled(data.length, 0);
    userAnswers = List<int?>.filled(data.length, null);
    quiz = data..shuffle();
    correctAnswers.setAll(0, data.map((quiz) => quiz.answerId));
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuizModel>>(
      future: quizFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return Text(snapshot.hasError ? 'Error: ${snapshot.error}' : 'No quiz data available.');
        }

        return _buildQuizScreen(snapshot.data!);
      },
    );
  }

  Widget _buildQuizScreen(List<QuizModel> quiz) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Select Question Index:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  quiz.length,
                  (index) => ElevatedButton(
                    onPressed: () => _goToQuestion(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentIndex == index ? Colors.blue : null,
                    ),
                    child: Text('${index + 1}'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              quiz[_currentIndex].title,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                quiz[_currentIndex].choices.length,
                (index) => RadioListTile<int>(
                  value: index,
                  groupValue: userAnswers[_currentIndex],
                  onChanged: userAnswers[_currentIndex] == null
                      ? (int? value) => _answerQuestion(value)
                      : null,
                  title: Text(quiz[_currentIndex].choices[index].title),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentIndex > 0 ? () => _changeQuestion(-1) : null,
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: _swapToRandomQuestion,
                  child: const Text('Random'),
                ),
                ElevatedButton(
                  onPressed: _currentIndex < quiz.length - 1 ? () => _changeQuestion(1) : _showScoreDialog,
                  child: Text(_currentIndex < quiz.length - 1 ? 'Next' : 'Show Score'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Score: $score'),
          ],
        ),
      ),
    );
  }

  void _answerQuestion(int? selectedIndex) {
    setState(() {
      userAnswers[_currentIndex] = selectedIndex;
      if (correctAnswers[_currentIndex] == selectedIndex) {
        score++;
      }
    });
  }

  void _changeQuestion(int offset) {
    setState(() {
      _currentIndex += offset;
    });
  }

  void _goToQuestion(int questionIndex) {
    setState(() {
      _currentIndex = questionIndex;
    });
  }

void _swapToRandomQuestion() {
  setState(() {
    if (quiz.isNotEmpty) {
      // Check if all questions have been answered
      bool allQuestionsAnswered =
          userAnswers.every((answer) => answer != null);

      if (!allQuestionsAnswered) {
        // If not all questions are answered, select a random unanswered question
        _currentIndex = Random().nextInt(quiz.length);
        quiz[_currentIndex].choices.shuffle();

        // Make sure the selected question is unanswered
        while (userAnswers[_currentIndex] != null) {
          _currentIndex = Random().nextInt(quiz.length);
          quiz[_currentIndex].choices.shuffle();
        }
      }
    }
  });
}

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your Score'),
        content: Text('You scored $score out of ${quiz.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                score = 0;
                userAnswers = List<int?>.filled(quiz.length, null);
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
