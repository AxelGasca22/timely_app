import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timely_app/answer_button.dart';
import 'package:timely_app/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);

    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Container(
      color: const Color(0xFFDBEAFE), // Fondo azul pastel muy claro
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            'QUIZZ INICIAL',
            style: GoogleFonts.lato(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A2236),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            width: 340,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pregunta ${currentQuestionIndex + 1} de ${questions.length}',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A2236),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  height: 2,
                  width: double.infinity,
                  color: const Color(0xFFB2C7F7),
                ),
                const SizedBox(height: 8),
                Text(
                  currentQuestion.text,
                  style: GoogleFonts.lato(
                    color: const Color(0xFF1A2236),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  height: 2,
                  width: double.infinity,
                  color: const Color(0xFFB2C7F7),
                ),
                const SizedBox(height: 18),
                ...currentQuestion.getShuffledAnswers().asMap().entries.map((
                  entry,
                ) {
                  final idx = entry.key;
                  final answer = entry.value;
                  // Colores de botón según posición para simular el gradiente
                  final List<Color> buttonColors = [
                    const Color(0xFF3887FE),
                    const Color(0xFF5EA1FF),
                    const Color(0xFF8EC6FF),
                    const Color(0xFFE6F0FF),
                  ];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          answerQuestion(answer);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              buttonColors[idx % buttonColors.length],
                          foregroundColor:
                              idx == 3 ? const Color(0xFF1A2236) : Colors.white,
                          elevation: idx == 0 ? 6 : 0,
                          shadowColor:
                              idx == 0
                                  ? Colors.blue.withOpacity(0.25)
                                  : Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        child: Text(answer, textAlign: TextAlign.center),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
