import 'package:flutter/material.dart';

void main() {
  runApp(const TinaAssistant());
}

class TinaAssistant extends StatelessWidget {
  const TinaAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tina Assistant',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tina Assistant'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: const Text(
          'Tina Assistant',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
