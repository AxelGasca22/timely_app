import 'package:flutter/material.dart';
import 'package:timely_app/start_screen.dart';
import 'package:timely_app/questions_screen.dart';
import 'package:timely_app/results_screen.dart';
import 'package:timely_app/data/questions.dart';
import 'package:timely_app/why_screen.dart';
import 'package:timely_app/auth_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'why-screen';
    });
  }

  void goToAuth() {
    setState(() {
      activeScreen = 'auth-screen';
    });
  }

  void goToQuiz() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'why-screen') {
      screenWidget = WhyScreen(onContinue: goToAuth);
    } else if (activeScreen == 'auth-screen') {
      screenWidget = AuthScreen(
        onSuccess: goToQuiz,
      );
    } else if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswer);
    } else if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 65, 21, 142),
                Color.fromARGB(255, 130, 90, 199),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              //gradient
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
