import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhyScreen extends StatelessWidget {
  final VoidCallback onContinue;
  const WhyScreen({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '¿Y esto por qué debería usarlo?',
                style: GoogleFonts.lato(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Porque te ayuda a conocerte y a trabajar en el momento exacto en el que tu cuerpo, tu mente y tu emoción están alineados.\n\n'
                  'La mayoría de las personas no sabe cuándo es su mejor hora para concentrarse, tomar decisiones importantes o simplemente rendir bien. Como resultado, pierden tiempo, se frustran o se queman.\n\n'
                  'Esta app te da datos reales sobre ti mismo: combina tu nivel de energía, confianza y ritmo diario para decirte cuándo estás “apagado”, cuándo vas camino al burnout (“violento”), o cuándo estás en “modo perfecto”. Y no solo te lo dice: te da acciones concretas para mejorar.\n\n'
                  'Ya no se trata de trabajar más, sino de trabajar mejor. Esta app te entrena para conocerte, autorregularte y vivir en sintonía con tu Timing perfecto.',
                  style: GoogleFonts.lato(
                    fontSize: 17,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 36),
              Text(
                'Para comenzar, necesitamos que realices un pequeño quizz inicial. ¡Te tomará menos de 3 minutos!',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: 220,
                height: 48,
                child: ElevatedButton(
                  onPressed: onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB2DFDB),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('¡Vamos!'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
