import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  //constructor
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Container(
      color: Colors.white, // Fondo blanco
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Imagen de bienvenida (más grande)
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  width: 2,
                ),
              ),
              child: Image.asset(
                'assets/images/bienvenida.png',
                width: 380, // Más grande
                height: 400, // Más grande
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Timely',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'La herramienta perfecta para saber cuando\neres más fuerte, más eficiente y más\nseguro para lograr todo lo que te propones.',
              style: GoogleFonts.lato(color: Colors.black87, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 300,
              height: 48,
              child: ElevatedButton(
                onPressed: startQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB2DFDB),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(fontSize: 15),
                ),
                child: const Text('Descubre tu mejor momento!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
