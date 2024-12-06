import 'package:flutter/material.dart';

class FlashcardsAnimalsPage extends StatefulWidget {
  const FlashcardsAnimalsPage({super.key});

  @override
  State<FlashcardsAnimalsPage> createState() => _FlashcardsAnimalsPageState();
}

class _FlashcardsAnimalsPageState extends State<FlashcardsAnimalsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Flashcards Animals Page'
        ),
      ),
    );
  }
}
