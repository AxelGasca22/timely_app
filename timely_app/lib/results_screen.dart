import 'package:timely_app/data/questions.dart';
import 'package:flutter/material.dart';
import 'package:timely_app/questions_summary/questions_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final List<String> chosenAnswers;
  final void Function() onRestart;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  double _answerToScore(int questionIndex, String answer) {
    // Las opciones están ordenadas de menor a mayor, 1 a 4 puntos
    // Si el usuario elige la opción 0, vale 1 punto; opción 3, vale 4 puntos
    return (questions[questionIndex].answers.indexOf(answer) + 1).toDouble();
  }

  Map<String, double> calculateScores() {
    // Preguntas por categoría (índices base 0)
    final rpIndexes = [0, 1, 2, 3, 4];
    final acIndexes = [10, 11, 12, 13, 14];
    final mixtoIndexes = [5, 6, 7, 8, 9];

    // Suma de respuestas
    double rpSum = 0;
    for (var i in rpIndexes) {
      rpSum += _answerToScore(i, chosenAnswers[i]);
    }
    double acSum = 0;
    for (var i in acIndexes) {
      acSum += _answerToScore(i, chosenAnswers[i]);
    }
    double mixtoSum = 0;
    for (var i in mixtoIndexes) {
      mixtoSum += _answerToScore(i, chosenAnswers[i]);
    }

    // Promedios
    double rpAvg = (rpSum + (mixtoSum / 2)) / 7.5; // 5 + mitad de 5 mixtas
    double acAvg = (acSum + (mixtoSum / 2)) / 7.5;
    // Normaliza a escala 1-4
    rpAvg = rpAvg * 1.5;
    acAvg = acAvg * 1.5;
    return {'rp': rpAvg, 'ac': acAvg};
  }

  String getQuadrantLabel(double rp, double ac) {
    if (rp >= 1.0 && rp <= 1.9 && ac >= 1.0 && ac <= 2.5) return 'Muerto';
    if (rp >= 1.0 && rp <= 1.9 && ac >= 2.6 && ac <= 4.0) return 'Apagado';
    if (rp >= 2.0 && rp <= 2.9 && ac >= 1.0 && ac <= 2.5) return 'Inestable';
    if (rp >= 2.0 && rp <= 2.9 && ac >= 2.6 && ac <= 3.4) return 'Productivo';
    if (rp >= 2.0 && rp <= 2.9 && ac >= 3.5 && ac <= 4.0)
      return 'Inicio de Flow';
    if (rp >= 3.0 && rp <= 4.0 && ac >= 1.0 && ac <= 2.9) return 'Violento';
    if (rp >= 3.0 && rp <= 4.0 && ac >= 3.0 && ac <= 4.0) return 'Perfecto';
    return 'Sin cuadrante';
  }

  String getQuadrantMessage(String quadrant) {
    switch (quadrant) {
      case 'Muerto':
        return 'Estás en un momento de muy baja energía y autoconfianza. Es importante que te tomes un descanso, cuides tu salud y busques pequeñas victorias para recuperar tu motivación. La app te ayudará a identificar patrones y a encontrar el mejor momento para retomar tu ritmo.';
      case 'Apagado':
        return 'Tu energía está baja, pero tu autoconfianza puede impulsarte. Aprovecha tu confianza para hacer tareas sencillas y no te exijas demasiado. La app te mostrará cuándo tu energía mejora para que puedas aprovechar esos momentos.';
      case 'Inestable':
        return 'Tienes energía, pero tu autoconfianza está baja. Trabaja en tu diálogo interno y celebra tus logros, por pequeños que sean. La app te dará ejercicios para fortalecer tu autoconfianza y aprovechar tu energía.';
      case 'Productivo':
        return '¡Buen momento! Tienes un balance adecuado entre energía y autoconfianza. Aprovecha para avanzar en tareas importantes. La app te ayudará a identificar estos momentos y a mantenerlos por más tiempo.';
      case 'Inicio de Flow':
        return 'Estás cerca de tu máximo potencial. Si mantienes este ritmo y confianza, puedes entrar en un estado de flow. La app te dará tips para potenciar este estado y evitar distracciones.';
      case 'Violento':
        return 'Tienes mucha energía, pero tu autoconfianza no acompaña. Cuidado con el agotamiento o el burnout. La app te sugerirá pausas activas y ejercicios de autoconocimiento para equilibrar tu ritmo.';
      case 'Perfecto':
        return '¡Estás en tu mejor momento! Tu energía y autoconfianza están alineadas. Aprovecha para tomar decisiones importantes y realizar tareas complejas. La app te ayudará a reconocer y repetir estos estados.';
      default:
        return 'Aún no se puede determinar tu cuadrante. Responde todas las preguntas para obtener un diagnóstico.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final scores = calculateScores();
    final quadrant = getQuadrantLabel(scores['rp']!, scores['ac']!);
    final quadrantMessage = getQuadrantMessage(quadrant);
    return SizedBox(
      width: double.infinity,
      child: Container(
        color: const Color(0xFFF0F9FF), // Fondo azul pastel muy claro
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 36),
              // Título principal
              Text(
                '¡Gracias por completar el cuestionario!\n',
                style: GoogleFonts.lato(
                  color: const Color(0xFF1A2236),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              // Tarjeta cuadrante
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3887FE),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Tu cuadrante actual es',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'RP: ${scores['rp']!.toStringAsFixed(1)}   AC: ${scores['ac']!.toStringAsFixed(1)}',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // Mensaje cuadrante
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                child: Text(
                  quadrantMessage,
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    color: const Color(0xFF1A2236),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Tarjeta de respuestas
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3887FE),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 12,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Respuestas',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 2,
                        width: 300,
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                      ),
                      QuestionsSummary(summaryData: summaryData),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextButton.icon(
                onPressed: onRestart,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF1A2236),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('Reiniciar cuestionario'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
