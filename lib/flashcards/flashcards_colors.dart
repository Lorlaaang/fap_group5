import 'package:flutter/material.dart';

class FlashcardsColorsPage extends StatefulWidget {
  const FlashcardsColorsPage({super.key});

  @override
  State<FlashcardsColorsPage> createState() => _FlashcardsColorsPageState();
}

class _FlashcardsColorsPageState extends State<FlashcardsColorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Flashcards Colors Page'
        ),
      ),
    );
  }
}
