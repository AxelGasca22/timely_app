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
              const SizedBox(height: 10),
              Text(
                'Descubre tus mejores momentos para rendir y evita el burnout.',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Image.asset(
                'assets/images/productivity_1.jpg',
                height: 300,
                width: 300,
              ),
              const SizedBox(height: 36),
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bulletPoint(
                      'Te ayuda a conocerte y a trabajar en el momento exacto en el que tu cuerpo, mente y emoción están alineados.',
                    ),
                    const SizedBox(height: 12),
                    bulletPoint(
                      'La mayoría de las personas no sabe cuándo es su mejor hora para concentrarse, tomar decisiones importantes o simplemente rendir bien.',
                    ),
                    const SizedBox(height: 12),
                    bulletPoint(
                      'Como resultado, pierden tiempo, se frustran o se queman.',
                    ),
                    const SizedBox(height: 12),
                    bulletPoint(
                      'Esta app te da datos reales sobre ti mismo: combina tu nivel de energía, confianza y ritmo diario para decirte cuándo estás “apagado”, cuándo vas camino al burnout (“violento”), o cuándo estás en “modo perfecto”.',
                    ),
                    const SizedBox(height: 12),
                    bulletPoint(
                      'No solo te lo dice: te da acciones concretas para mejorar.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Para comenzar, necesitamos que realices un pequeño quizz inicial. ¡Te tomará menos de 3 minutos!',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 44),
              _AnimatedButton(onPressed: onContinue),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper widget for bullet points
Widget bulletPoint(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '• ',
        style: TextStyle(fontSize: 20, color: Color(0xFF333333)),
      ),
      Expanded(
        child: Text(
          text,
          style: GoogleFonts.lato(
            fontSize: 16,
            color: const Color(0xFF333333),
            height: 1.5,
          ),
        ),
      ),
    ],
  );
}

class _AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _AnimatedButton({required this.onPressed});

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final color = Colors.blueAccent.shade700;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.06 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            boxShadow:
                _hovering
                    ? [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ]
                    : [],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton.icon(
            onPressed: widget.onPressed,
            icon: const Icon(Icons.rocket_launch, color: Colors.white),
            label: const Text('Comenzar cuestionario'),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              minimumSize: const Size(260, 56),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: _hovering ? 8 : 2,
            ),
          ),
        ),
      ),
    );
  }
}
