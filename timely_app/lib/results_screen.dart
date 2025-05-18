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
        // Fondo degradado para toda la pantalla de resultados
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 77, 50, 212), // morado oscuro
              Color.fromARGB(255, 106, 79, 195), // morado medio
              Color.fromARGB(255, 153, 124, 206), // morado claro
            ],
          ),
        ),
        margin: EdgeInsets.all(0), // Quita el margin para aprovechar el espacio
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¡Gracias por completar el cuestionario!\n',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Tu cuadrante actual es:',
                style: GoogleFonts.lato(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                quadrant,
                style: GoogleFonts.lato(
                  color: Colors.blueAccent,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'RP: ${scores['rp']!.toStringAsFixed(2)}   AC: ${scores['ac']!.toStringAsFixed(2)}',
                style: GoogleFonts.lato(fontSize: 18, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              Text(
                quadrantMessage,
                style: GoogleFonts.lato(fontSize: 18, color: Colors.black87),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 30),
              QuestionsSummary(summaryData: summaryData),
              const SizedBox(height: 30),
              TextButton.icon(
                onPressed: onRestart,
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                icon: const Icon(Icons.refresh),
                label: const Text('Reiniciar cuestionario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
