import 'package:flutter/material.dart';

class MuertoPage extends StatelessWidget {
  const MuertoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estado: Muerto')),
      body: const Center(
        child: Text('Aquí van tus recomendaciones para el estado "Muerto".'),
      ),
    );
  }
}


class ApagadoPage extends StatelessWidget {
  const ApagadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estado: Apagado')),
      body: const Center(
        child: Text('Aquí van tus recomendaciones para el estado "Apagado".'),
      ),
    );
  }
}


class InestablePage extends StatelessWidget {
  const InestablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estado: Inestable')),
      body: const Center(
        child: Text('Aquí van tus recomendaciones para el estado "Inestable".'),
      ),
    );
  }
}

class ProductivoPage extends StatelessWidget {
  const ProductivoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estado: Productivo')),
      body: const Center(
        child: Text('Aquí van tus recomendaciones para el estado "Productivo".'),
      ),
    );
  }
}

class FlowPage extends StatelessWidget {
  const FlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estado: Flow')),
      body: const Center(
        child: Text('Aquí van tus recomendaciones para el estado "Flow".'),
      ),
    );
  }
}

class ViolentoPage extends StatelessWidget {
  const ViolentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estado: Violento')),
      body: const Center(
        child: Text('Aquí van tus recomendaciones para el estado "Violento".'),
      ),
    );
  }
}

class PerfectoPage extends StatelessWidget {
  const PerfectoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estado: Perfecto')),
      body: const Center(
        child: Text('Aquí van tus recomendaciones para el estado "Perfecto".'),
      ),
    );
  }
}


class DefaultPage extends StatelessWidget {
  const DefaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estado: Sin estado')),
      body: const Center(
        child: Text('No se logró determinar un estado.'),
      ),
    );
  }
}
